//
//  MOMachOSegmentLoadCommand.m
//  MachOKit
//
//  Created by Martin Johannesson on 2012-10-04.
//  Copyright (c) 2012 Martin Johannesson. All rights reserved.
//

#import "MOMachOSegmentLoadCommand.h"
#import "MOMachOSection.h"
#import <mach-o/loader.h>

@interface MOMachOSegmentLoadCommand ()

@property (nonatomic, readwrite, copy) NSString *segmentName;
@property (nonatomic, readwrite) uint32_t startingVirtualMemoryAddress;
@property (nonatomic, readwrite) uint32_t sizeInVirtualMemory;
@property (nonatomic, readwrite) uint32_t fileOffset;
@property (nonatomic, readwrite) uint32_t fileSize;
@property (nonatomic, readwrite) vm_prot_t maxPermittedVirtualMemoryProtections;
@property (nonatomic, readwrite) vm_prot_t initialVirtualMemoryProtections;
@property (nonatomic, readwrite) uint32_t sectionCount;
@property (nonatomic, readwrite) uint32_t flags;

@end

@implementation MOMachOSegmentLoadCommand {
    NSMutableArray *_sections;
}

- (id)initWithHeader:(struct load_command *)header
                base:(uint8_t *)base
{
    self = [super initWithHeader:header base:base];
    if (self) {
        struct segment_command segmentHeader = *(struct segment_command *)header;
        self.segmentName = [NSString stringWithCString:segmentHeader.segname
                                          encoding:NSUTF8StringEncoding];
        self.startingVirtualMemoryAddress = segmentHeader.vmaddr;
        self.sizeInVirtualMemory = segmentHeader.vmsize;
        self.fileOffset = segmentHeader.fileoff;
        self.fileSize = segmentHeader.filesize;
        self.maxPermittedVirtualMemoryProtections = segmentHeader.maxprot;
        self.initialVirtualMemoryProtections = segmentHeader.initprot;
        self.sectionCount = segmentHeader.nsects;
        self.flags = segmentHeader.flags;
        
        _sections = [NSMutableArray arrayWithCapacity:self.sectionCount];
        
        struct section *sectionHeader = (struct section *)(((uint8_t *)header)
                        + (uint8_t)sizeof(struct segment_command));
        for (uint32_t i = 0; i < self.sectionCount; i++) {
            MOMachOSection *section = [MOMachOSection sectionWithHeader:sectionHeader base:base];
            [_sections addObject:section];
            sectionHeader++;
        }
    }
    
    return self;
}

- (MOMachOSection *)sectionAtIndex:(NSUInteger)index
{
    return [_sections objectAtIndex:index];
}


@end
