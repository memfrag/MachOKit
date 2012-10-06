//
//  MOMachOUUIDLoadCommand.m
//  MachOKit
//
//  Created by Martin Johannesson on 2012-10-04.
//  Copyright (c) 2012 Martin Johannesson. All rights reserved.
//

#import "MOMachOUUIDLoadCommand.h"
#import <mach-o/loader.h>

@interface MOMachOUUIDLoadCommand ()

@property (nonatomic, copy, readwrite) NSString *uuid;

@end

@implementation MOMachOUUIDLoadCommand

- (id)initWithHeader:(struct load_command *)header
                base:(uint8_t *)base
{
    self = [super initWithHeader:header base:base];
    if (self) {
        struct uuid_command uuidHeader = *(struct uuid_command *)header;
        self.uuid = [NSString stringWithFormat:@"%x%x%x%x%x%x%x%x%x%x%x%x%x%x%x%x",
                     uuidHeader.uuid[0], uuidHeader.uuid[1], uuidHeader.uuid[2],
                     uuidHeader.uuid[3], uuidHeader.uuid[4], uuidHeader.uuid[5],
                     uuidHeader.uuid[6], uuidHeader.uuid[7], uuidHeader.uuid[8],
                     uuidHeader.uuid[9], uuidHeader.uuid[10], uuidHeader.uuid[11],
                     uuidHeader.uuid[12], uuidHeader.uuid[13], uuidHeader.uuid[14],
                     uuidHeader.uuid[15]];
    }
    
    return self;
}

@end
