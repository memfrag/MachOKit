//
//  MOMachO.m
//  MachOKit
//
//  Created by Martin Johannesson on 2012-10-04.
//  Copyright (c) 2012 Martin Johannesson. All rights reserved.
//

#import "MOMachO.h"
#import "MOMachOSection.h"
#import "MOMachOLoadCommand.h"
#import "MOMachOSymtabLoadCommand.h"
#import "MOMachOLoadCommandFactory.h"
#import <mach-o/loader.h>

@implementation MOMachO {
    uint8_t *_base;
    NSMutableArray *_loadCommands;
}

- (id)initWithBase:(uint8_t *)base
{
    self = [super init];
    if (self) {
        _base = base;
    }
    
    return self;
}

- (MOMachOSection *)findSection:(NSString *)sectionName
                      inSegment:(NSString *)segmentName
{    
    return [MOMachOSection sectionFromBase:_base
                                   segment:segmentName
                                   section:sectionName];
}

- (struct mach_header)machHeader
{
    return *(struct mach_header *)_base;
}

- (cpu_type_t)cpuType
{
    return [self machHeader].cputype;
}

- (cpu_subtype_t)cpuSubtype
{
    return [self machHeader].cpusubtype;
}

- (uint32_t)filetype
{
    return [self machHeader].filetype;
}

- (uint32_t)loadCommandCount
{
    return [self machHeader].ncmds;
}

- (uint32_t)sizeOfAllCommands
{
    return [self machHeader].sizeofcmds;
}

- (uint32_t)flags
{
    return [self machHeader].flags;
}

- (NSArray *)loadCommands
{
    if (_loadCommands) {
        return _loadCommands;
    }
        
    uint32_t commandCount = self.loadCommandCount;
    _loadCommands = [[NSMutableArray alloc] initWithCapacity:commandCount];
    
    uint8_t *commandPointer = _base + sizeof(struct mach_header);
    
    for (uint32_t i = 0; i < commandCount; i++) {
        MOMachOLoadCommand *command;
        command = [MOMachOLoadCommandFactory loadCommandFromPointer:commandPointer base:_base];
        
        [_loadCommands addObject:command];
        
        commandPointer += command.commandSize;
    }
    
    return _loadCommands;
}

@end
