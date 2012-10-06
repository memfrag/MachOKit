//
//  MOMachOSegmentLoadCommand.h
//  MachOKit
//
//  Created by Martin Johannesson on 2012-10-04.
//  Copyright (c) 2012 Martin Johannesson. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "MOMachOLoadCommand.h"

@class MOMachOSection;

@interface MOMachOSegmentLoadCommand : MOMachOLoadCommand

@property (nonatomic, readonly, copy) NSString *segmentName;
@property (nonatomic, readonly) uint32_t startingVirtualMemoryAddress;
@property (nonatomic, readonly) uint32_t sizeInVirtualMemory;
@property (nonatomic, readonly) uint32_t fileOffset;
@property (nonatomic, readonly) uint32_t fileSize;
@property (nonatomic, readonly) vm_prot_t maxPermittedVirtualMemoryProtections;
@property (nonatomic, readonly) vm_prot_t initialVirtualMemoryProtections;
@property (nonatomic, readonly) uint32_t flags;
@property (nonatomic, readonly) uint32_t sectionCount;

- (MOMachOSection *)sectionAtIndex:(NSUInteger)index;

@end
