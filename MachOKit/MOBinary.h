//
//  MOBinary.h
//  MachOKit
//
//  Created by Martin Johannesson on 2012-10-04.
//  Copyright (c) 2012 Martin Johannesson. All rights reserved.
//

#import <Foundation/Foundation.h>

@class MOMachO;

@interface MOBinary : NSObject

- (NSUInteger)imageCount;

- (MOMachO *)imageAtIndex:(NSUInteger)index;

+ (MOBinary *)binaryFromURL:(NSURL *)url;

@end
