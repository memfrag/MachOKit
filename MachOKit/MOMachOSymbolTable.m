//
//  MOMachOSymbolTable.m
//  MachOKit
//
//  Created by Martin Johannesson on 2012-10-04.
//  Copyright (c) 2012 Martin Johannesson. All rights reserved.
//

#import "MOMachOSymbolTable.h"
#import "MOMachOSymtabLoadCommand.h"
#import "MOMachOSymbol.h"
#import <mach-o/nlist.h>

@implementation MOMachOSymbolTable {
    NSMutableArray *_symbols;
}

- (id)init
{
    self = [super init];
    if (self) {
        _symbols = [[NSMutableArray alloc] initWithCapacity:100];
    }
    
    return self;
}

- (void)addSymbol:(MOMachOSymbol *)symbol
{
    [_symbols addObject:symbol];
}

- (NSArray *)symbols
{
    return _symbols;
}

+ (MOMachOSymbolTable *)symbolTableFromBase:(void *)base
                                loadCommand:(MOMachOSymtabLoadCommand *)command
{
    if (base == NULL || command == NULL) {
        return nil;
    }
    
    MOMachOSymbolTable *symbolTable = [[MOMachOSymbolTable alloc] init];
    
    struct nlist *nlists = (struct nlist *)((uint8_t *)base + command.symbolsFileOffset);
    char *stringsPointer = (char *)((uint8_t *)base + command.stringsFileOffset);
    
    for (uint32_t i = 0; i < command.symbolCount; i++) {
        MOMachOSymbol *symbol = [MOMachOSymbol symbolFromNlist:nlists[i]
                                                stringsPointer:stringsPointer];
        if (symbol) {
            [symbolTable addSymbol:symbol];
        }
    }
    
    return symbolTable;
}

@end
