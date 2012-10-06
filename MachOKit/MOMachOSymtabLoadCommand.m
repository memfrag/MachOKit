//
//  MOMachOSymtabLoadCommand.m
//  MachOKit
//
//  Created by Martin Johannesson on 2012-10-04.
//  Copyright (c) 2012 Martin Johannesson. All rights reserved.
//

#import "MOMachOSymtabLoadCommand.h"
#import "MOMachOSymbolTable.h"
#import <mach-o/loader.h>

@interface MOMachOSymtabLoadCommand ()

@property (nonatomic, readwrite) uint32_t symbolsFileOffset;
@property (nonatomic, readwrite) uint32_t symbolCount;
@property (nonatomic, readwrite) uint32_t stringsFileOffset;
@property (nonatomic, readwrite) uint32_t stringsSize;

@end

@implementation MOMachOSymtabLoadCommand

- (id)initWithHeader:(struct load_command *)header
                base:(uint8_t *)base
{
    self = [super initWithHeader:header base:base];
    if (self) {
        struct symtab_command symtabHeader = *(struct symtab_command *)header;
        self.symbolsFileOffset = symtabHeader.symoff;
        self.symbolCount = symtabHeader.nsyms;
        self.stringsFileOffset = symtabHeader.stroff;
        self.stringsSize = symtabHeader.strsize;
    }
    
    return self;
}

- (MOMachOSymbolTable *)symbolTable
{
    return [MOMachOSymbolTable symbolTableFromBase:_base loadCommand:self];
}

@end
