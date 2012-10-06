//
//  MOMemoryMappedFile.h
//  MachOKit
//
//  Created by Martin Johannesson on 2012-10-04.
//  Copyright (c) 2012 Martin Johannesson. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface MOMemoryMappedFile : NSObject

// The path of the file to map into memory.
@property (nonatomic, readonly, copy) NSString *path;

// The memory address where the file is mapped.
// NULL when the file is not mapped into memory.
@property (nonatomic, readonly) void *baseAddress;

// Total size of the file.
@property (nonatomic, readonly) NSUInteger size;

// YES when the file is mapped into memory.
@property (nonatomic, readonly) BOOL isMapped;

// Prepares to map the specified file, but does not
// actually map the file into memory.
- (id)initWithPath:(NSString *)pathToFile;

// Maps the file into memory.
// Returns pointer to start of file.
- (void *)map;

// Unmaps the file from memory.
// The pointer returned by map is no longer valid.
- (void)unmap;

@end
