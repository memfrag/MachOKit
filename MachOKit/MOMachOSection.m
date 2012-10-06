//
//  MOMachOSection.m
//  MachOKit
//
//  Created by Martin Johannesson on 2012-10-04.
//  Copyright (c) 2012 Martin Johannesson. All rights reserved.
//

#import "MOMachOSection.h"
#import <mach-o/arch.h>
#import <mach-o/loader.h>
#import <mach-o/getsect.h>

@interface MOMachOSection ()

@property (nonatomic, copy, readwrite) NSString *segmentName;
@property (nonatomic, copy, readwrite) NSString *sectionName;
@property (nonatomic, assign) struct section sectionHeader;

@end

@implementation MOMachOSection {
    uint8_t *_dataPointer;
    uint32_t _dataSize;
}

+ (MOMachOSection *)sectionWithHeader:(struct section *)header base:(uint8_t *)base
{
    MOMachOSection *machOSection = [[MOMachOSection alloc] init];
    
    machOSection.segmentName = [NSString stringWithCString:header->segname encoding:NSUTF8StringEncoding];
    machOSection.sectionName = [NSString stringWithCString:header->sectname encoding:NSUTF8StringEncoding];
    machOSection.sectionHeader = *header;
    
    [machOSection setDataPointer:(base + header->offset) size:header->size];
    
    return machOSection;
}

+ (MOMachOSection *)sectionFromBase:(uint8_t *)base
                            segment:(NSString *)segmentName
                            section:(NSString *)sectionName
{
    MOMachOSection *machOSection;
    machOSection = [[MOMachOSection alloc] init];
    
    machOSection.segmentName = segmentName;
    machOSection.sectionName = sectionName;
    
    struct mach_header *machHeader = (struct mach_header *)base;
    
    const struct section *section = getsectbynamefromheader(machHeader,
                                                            [segmentName UTF8String],
                                                            [sectionName UTF8String]);
    
    if (section == NULL) {
        return nil;
    }
    
    machOSection.sectionHeader = *section;
    
    uint32_t dataSize = 0;
    uint8_t *dataPointer = (uint8_t *)getsectdatafromheader(machHeader,
                                              [segmentName UTF8String],
                                              [sectionName UTF8String],
                                              &dataSize);
    
    [machOSection setDataPointer:dataPointer size:dataSize];
    
    return machOSection;
}

- (void)setDataPointer:(uint8_t *)dataPointer size:(uint32_t)size
{
    _dataPointer = dataPointer;
    _dataSize = size;
}

- (NSData *)sectionData
{
    if (_dataPointer == NULL || _dataSize == 0) {
        return nil;
    }

    return [NSData dataWithBytes:_dataPointer length:_dataSize];
}

- (uint32_t)sectionAddress
{
    return self.sectionHeader.addr;
}

- (uint32_t)sectionSize
{
    return self.sectionHeader.size;
}

- (uint32_t)fileOffset
{
    return self.sectionHeader.offset;
}

- (uint32_t)sectionAlignment
{
    return self.sectionHeader.align;
}

- (uint32_t)relocationEntriesFileOffset
{
    return self.sectionHeader.reloff;
}

- (uint32_t)relocationEntryCount
{
    return self.sectionHeader.nreloc;
}

- (uint32_t)sectionFlags
{
    return self.sectionHeader.flags;
}

@end
