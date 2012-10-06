//
//  MOMachOSymtabLoadCommand.h
//  MachOKit
//
//  Created by Martin Johannesson on 2012-10-04.
//  Copyright (c) 2012 Martin Johannesson. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "MOMachOLoadCommand.h"

@class MOMachOSymbolTable;

@interface MOMachOSymtabLoadCommand : MOMachOLoadCommand

@property (nonatomic, readonly) uint32_t symbolsFileOffset;
@property (nonatomic, readonly) uint32_t symbolCount;
@property (nonatomic, readonly) uint32_t stringsFileOffset;
@property (nonatomic, readonly) uint32_t stringsSize;

- (MOMachOSymbolTable *)symbolTable;

@end
