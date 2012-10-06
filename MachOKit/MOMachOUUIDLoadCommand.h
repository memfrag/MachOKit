//
//  MOMachOUUIDLoadCommand.h
//  MachOKit
//
//  Created by Martin Johannesson on 2012-10-04.
//  Copyright (c) 2012 Martin Johannesson. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "MOMachOLoadCommand.h"

@interface MOMachOUUIDLoadCommand : MOMachOLoadCommand

@property (nonatomic, copy, readonly) NSString *uuid;

@end
