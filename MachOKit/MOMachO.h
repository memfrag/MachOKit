//
//  MOMachO.h
//  MachOKit
//
//  Created by Martin Johannesson on 2012-10-04.
//  Copyright (c) 2012 Martin Johannesson. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <mach-o/loader.h>

@class MOMachOSection;

@interface MOMachO : NSObject

@property (nonatomic, readonly) cpu_type_t cpuType;
@property (nonatomic, readonly) cpu_subtype_t cpuSubtype;
@property (nonatomic, readonly) uint32_t filetype;
@property (nonatomic, readonly) uint32_t loadCommandCount;
@property (nonatomic, readonly) uint32_t sizeOfAllCommands;
@property (nonatomic, readonly) uint32_t flags;
@property (nonatomic, readonly) NSArray *loadCommands;

- (id)initWithBase:(uint8_t *)base;

- (MOMachOSection *)findSection:(NSString *)sectionName
                      inSegment:(NSString *)segmentName;
@end
