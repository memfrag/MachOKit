//
//  MOMachOSection.h
//  MachOKit
//
//  Created by Martin Johannesson on 2012-10-04.
//  Copyright (c) 2012 Martin Johannesson. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <mach-o/loader.h>

@interface MOMachOSection : NSObject

@property (nonatomic, copy, readonly) NSString *segmentName;

@property (nonatomic, copy, readonly) NSString *sectionName;

/* memory address of this section */
@property (nonatomic, readonly) uint32_t sectionAddress;

/* size in bytes of this section */
@property (nonatomic, readonly) uint32_t sectionSize;

/* file offset of this section */
@property (nonatomic, readonly) uint32_t fileOffset;

/* section alignment (power of 2) */
@property (nonatomic, readonly) uint32_t sectionAlignment;

/* file offset of relocation entries */
@property (nonatomic, readonly) uint32_t relocationEntriesFileOffset;

/* number of relocation entries */
@property (nonatomic, readonly) uint32_t relocationEntryCount;

/* flags (section type and attributes) */
@property (nonatomic, readonly) uint32_t sectionFlags;

@property (nonatomic, strong, readonly) NSData *sectionData;

+ (MOMachOSection *)sectionFromBase:(uint8_t *)base
                            segment:(NSString *)segmentName
                            section:(NSString *)sectionName;

+ (MOMachOSection *)sectionWithHeader:(struct section *)header
                                 base:(uint8_t *)base;


@end
