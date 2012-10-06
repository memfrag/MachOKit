//
//  MOMachOOSXVersionMinLoadCommand.m
//  MachOKit
//
//  Created by Martin Johannesson on 2012-10-04.
//  Copyright (c) 2012 Martin Johannesson. All rights reserved.
//

#import "MOMachOOSXVersionMinLoadCommand.h"
#import <mach-o/loader.h>

@interface MOMachOOSXVersionMinLoadCommand ()

@property (nonatomic, readwrite) uint32_t major;
@property (nonatomic, readwrite) uint32_t minor;
@property (nonatomic, readwrite) uint32_t revision;

@end


@implementation MOMachOOSXVersionMinLoadCommand

- (id)initWithHeader:(struct load_command *)header
                base:(uint8_t *)base
{
    self = [super initWithHeader:header base:base];
    if (self) {
        struct version_min_command versionHeader = *(struct version_min_command *)header;
        uint32_t version = versionHeader.version;
        self.major = (version >> 16) & 0x0000FFFFL;
        self.major = (version >> 8) & 0x000000FFL;
        self.revision = version & 0x000000FFL;
    }
    
    return self;
}

@end
