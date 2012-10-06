//
//  MOMachOLoadCommand.h
//  MachOKit
//
//  Created by Martin Johannesson on 2012-10-04.
//  Copyright (c) 2012 Martin Johannesson. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <mach-o/loader.h>

@interface MOMachOLoadCommand : NSObject {
@protected
    uint8_t *_base;
}

@property (nonatomic, readonly) uint32_t command;
@property (nonatomic, readonly) uint32_t commandSize;

- (id)initWithHeader:(struct load_command *)header
                base:(uint8_t *)base;
@end
