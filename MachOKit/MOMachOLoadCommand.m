//
//  MOMachOLoadCommand.m
//  MachOKit
//
//  Created by Martin Johannesson on 2012-10-04.
//  Copyright (c) 2012 Martin Johannesson. All rights reserved.
//

#import "MOMachOLoadCommand.h"

@interface MOMachOLoadCommand ()

@property (nonatomic, readwrite) uint32_t command;
@property (nonatomic, readwrite) uint32_t commandSize;

@end

@implementation MOMachOLoadCommand

- (id)initWithHeader:(struct load_command *)header
                base:(uint8_t *)base
{
    self = [super init];
    if (self) {
        _base = base;
        self.command = header->cmd;
        self.commandSize = header->cmdsize;
    }
    
    return self;
}

@end
