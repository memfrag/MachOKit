//
//  MOBinary.m
//  MachOKit
//
//  Created by Martin Johannesson on 2012-10-04.
//  Copyright (c) 2012 Martin Johannesson. All rights reserved.
//

#import "MOBinary.h"
#import "MOMachO.h"
#import "MOMemoryMappedFile.h"
#import <mach-o/fat.h>
#import <mach-o/loader.h>

@implementation MOBinary {
    MOMemoryMappedFile *_file;
}

+ (MOBinary *)binaryFromURL:(NSURL *)url
{
    MOBinary *binary = [[MOBinary alloc] init];
    
    if (![binary mapObjectFile:url]) {
        return nil;
    }
    
    if ([binary isFatBinary]) {
        return binary;
    }
    
    if ([binary isMachOBinary]) {
        return binary;
    }
    
    return nil;
}

- (BOOL)mapObjectFile:(NSURL *)url
{
    MOMemoryMappedFile *file = [[MOMemoryMappedFile alloc] initWithPath:[url path]];
    
    void *basePointer = [file map];
    
    if (basePointer == NULL) {
        return NO;
    }
    
    _file = file;
    
    return YES;
}

- (BOOL)isFatBinary
{
    struct fat_header *fatHeader = (struct fat_header *)_file.baseAddress;
    return fatHeader->magic == FAT_CIGAM;
}

- (BOOL)isMachOBinary
{
    struct mach_header *machHeader = (struct mach_header *)_file.baseAddress;
    if (machHeader->magic == MH_MAGIC) {
        // Mach-O binary has same endian as this computer.
        return YES;
    } else if (machHeader->magic == MH_CIGAM) {
        // Mach-O binary has opposite endian of this computer.
        return YES;
    } else if (machHeader->magic == MH_MAGIC_64) {
        // 64-bit Mach-O binary has same endian as this computer.
        return YES;
    } else if (machHeader->magic == MH_CIGAM_64) {
        // 64-bit Mach-O binary has opposite endian of this computer.
        return YES;
    }
    return NO;
}

- (NSUInteger)imageCount
{
    if ([self isFatBinary]) {
        struct fat_header *fatHeader = (struct fat_header *)_file.baseAddress;
        uint32_t count = ntohl(fatHeader->nfat_arch);
        return (NSUInteger)count;
    }
    return 1;
}

- (MOMachO *)imageAtIndex:(NSUInteger)index
{
    NSUInteger maxIndex = [self imageCount] - 1;
    
    if (index > maxIndex) {
        return nil;
    }
    
    uint8_t *base = (uint8_t *)_file.baseAddress;
    
    if ([self isFatBinary]) {
        struct fat_arch *arch = (struct fat_arch *)(base
                                            + sizeof(struct fat_header)
                                            + sizeof(struct fat_arch) * index);
        uint32_t offset = ntohl(arch->offset);
        base = base + offset;
    }
    
    return [[MOMachO alloc] initWithBase:base];
}

@end
