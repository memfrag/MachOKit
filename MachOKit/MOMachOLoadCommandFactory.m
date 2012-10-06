//
//  MOMachOLoadCommandFactory.m
//  MachOKit
//
//  Created by Martin Johannesson on 2012-10-04.
//  Copyright (c) 2012 Martin Johannesson. All rights reserved.
//

#import "MOMachOLoadCommandFactory.h"
#import "MOMachOLoadCommand.h"
#import "MOMachOUUIDLoadCommand.h"
#import "MOMachOiOSVersionMinLoadCommand.h"
#import "MOMachOOSXVersionMinLoadCommand.h"
#import "MOMachOSymtabLoadCommand.h"
#import "MOMachOSegmentLoadCommand.h"
#import <mach-o/loader.h>

@implementation MOMachOLoadCommandFactory

+ (MOMachOLoadCommand *)loadCommandFromPointer:(uint8_t *)pointer
                                          base:(uint8_t *)base
{
    struct load_command *header = (struct load_command *)pointer;
    
    if (header == NULL) {
        return nil;
    }
    
    MOMachOLoadCommand *command = nil;
    switch (header->cmd) {
        case LC_UUID:
            command = [[MOMachOUUIDLoadCommand alloc] initWithHeader:header
                                                                base:base];
            break;
        case LC_VERSION_MIN_MACOSX: /* build for OS X min OS version */
            command = [[MOMachOOSXVersionMinLoadCommand alloc] initWithHeader:header
                                                                         base:base];
            break;
        case LC_VERSION_MIN_IPHONEOS: /* build for iPhoneOS min OS version */
            command = [[MOMachOiOSVersionMinLoadCommand alloc] initWithHeader:header
                                                                         base:base];
            break;
        case LC_SYMTAB: /* link-edit stab symbol table info */
            command = [[MOMachOSymtabLoadCommand alloc] initWithHeader:header
                                                                  base:base];
            break;
        case LC_SEGMENT: /* segment of this file to be mapped */
            command = [[MOMachOSegmentLoadCommand alloc] initWithHeader:header
                                                                   base:base];
            break;
            
        case LC_THREAD:	/* thread */
            // struct thread_command
        case LC_UNIXTHREAD:	/* unix thread (includes a stack) */
            // struct thread_command
            
        case LC_DYSYMTAB:	/* dynamic link-edit symbol table info */
            // struct dysymtab_command

        case LC_LOAD_DYLIB:	/* load a dynamically linked shared library */
            // struct dylib_command
        case LC_ID_DYLIB:	/* dynamically linked shared lib ident */
            // struct dylib_command
        case LC_REEXPORT_DYLIB: /* load and re-export dylib */
            // struct dylib_command
        case LC_LOAD_WEAK_DYLIB: /* load a dynamically linked shared library that is allowed to be missing (all symbols are weak imported). */
            // struct dylib_command

        case LC_LOAD_DYLINKER:	/* load a dynamic linker */
            // struct dylinker_command
        case LC_ID_DYLINKER:	/* dynamic linker identification */
            // struct dylinker_command
        case LC_DYLD_ENVIRONMENT: /* string for dyld to treat like environment variable */
            // struct dylinker_command
            
        case LC_PREBOUND_DYLIB:	/* modules prebound for a dynamically */
            // struct prebound_dylib_command
            
        case LC_ROUTINES:	/* image routines */
            // struct routines_command
        
        case LC_SUB_FRAMEWORK:	/* sub framework */
            // struct sub_framework_command
        
        case LC_SUB_UMBRELLA:	/* sub umbrella */
            // sub_umbrella_command
        
        case LC_SUB_CLIENT:	/* sub client */
            // struct sub_client_command
            
        case LC_SUB_LIBRARY:	/* sub library */
            // sub_library_command
            
        case LC_TWOLEVEL_HINTS:	/* two-level namespace lookup hints */
            // struct twolevel_hints_command
            
        case LC_PREBIND_CKSUM:	/* prebind checksum */
            // struct prebind_cksum_command
        
        case LC_SEGMENT_64:	/* 64-bit segment of this file to be mapped */
            // struct segment_command_64
            // struct section_64
            
        case LC_ROUTINES_64:	/* 64-bit image routines */
            // struct routines_command_64
            
        case LC_RPATH:    /* runpath additions */
            // struct rpath_command
            
        case LC_CODE_SIGNATURE:	/* local of code signature */
            // struct linkedit_data_command 
        case LC_SEGMENT_SPLIT_INFO: /* local of info to split segments */
            // struct linkedit_data_command
        case LC_FUNCTION_STARTS: /* compressed table of function start addresses */
            // struct linkedit_data_command
        case LC_DATA_IN_CODE: /* table of non-instructions in __text */
            // struct linkedit_data_command
        case LC_DYLIB_CODE_SIGN_DRS: /* Code signing DRs copied from linked dylibs */
            // struct linkedit_data_command
            
        case LC_LAZY_LOAD_DYLIB:	/* delay load of dylib until first use */
            // ???
        
        case LC_ENCRYPTION_INFO:	/* encrypted segment information */
            // struct encryption_info_command
            
        case LC_DYLD_INFO:	/* compressed dyld information */
            // struct dyld_info_command
        case LC_DYLD_INFO_ONLY:	/* compressed dyld information only */
            // struct dyld_info_command
            
        case LC_LOAD_UPWARD_DYLIB: /* load upward dylib */
            // ???
        
        case LC_MAIN: /* replacement for LC_UNIXTHREAD */
            // struct entry_point_command
            
        case LC_SOURCE_VERSION: /* source version used to build binary */
            // struct source_version_command
            
        default:
            command = [[MOMachOLoadCommand alloc] initWithHeader:header
                                                            base:base];
            break;
    }
    
    return command;
}

@end
