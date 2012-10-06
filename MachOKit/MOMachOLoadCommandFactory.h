//
//  MOMachOLoadCommandFactory.h
//  MachOKit
//
//  Created by Martin Johannesson on 2012-10-04.
//  Copyright (c) 2012 Martin Johannesson. All rights reserved.
//

#import <Foundation/Foundation.h>

@class MOMachOLoadCommand;

@interface MOMachOLoadCommandFactory : NSObject

+ (MOMachOLoadCommand *)loadCommandFromPointer:(uint8_t *)pointer
                                          base:(uint8_t *)base;

@end
