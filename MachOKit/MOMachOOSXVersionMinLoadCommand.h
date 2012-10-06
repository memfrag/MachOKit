//
//  MOMachOOSXVersionMinLoadCommand.h
//  MachOKit
//
//  Created by Martin Johannesson on 2012-10-04.
//  Copyright (c) 2012 Martin Johannesson. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "MOMachOLoadCommand.h"

@interface MOMachOOSXVersionMinLoadCommand : MOMachOLoadCommand

@property (nonatomic, readonly) uint32_t major;
@property (nonatomic, readonly) uint32_t minor;
@property (nonatomic, readonly) uint32_t revision;

@end
