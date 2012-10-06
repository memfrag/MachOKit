//
//  MOMachOSymbolTable.h
//  MachOKit
//
//  Created by Martin Johannesson on 2012-10-04.
//  Copyright (c) 2012 Martin Johannesson. All rights reserved.
//

#import <Foundation/Foundation.h>

@class MOMachOSymtabLoadCommand;

@interface MOMachOSymbolTable : NSObject

@property (nonatomic, readonly) NSArray *symbols;

+ (MOMachOSymbolTable *)symbolTableFromBase:(void *)base
                                loadCommand:(MOMachOSymtabLoadCommand *)command;

@end
