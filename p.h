//
//  p.h
//  p
//
//  Created by Stephen Sykes on 03/10/13.
//  Copyright (c) 2013. All rights reserved.
//

// Defines a macro p(arg) that will NSLog almost any type.
//
// The type is determined using the Objective C type encoding
// information from @encoding(). Objects, simple numeric types,
// C strings, and types that can be converted using the NSStringFrom...
// functions are supported.
//
// Compiler type errors are avoided by passing the argument
// through va_args.

#if TARGET_OS_IPHONE
    #import <UIKit/UIKit.h>
#else
    #import <Cocoa/Cocoa.h>
#endif

NSString *npStringFromAnyType(char *typeCode, ...);

#define p(arg) NSLog(@"%@", npStringFromAnyType(@encode(typeof(arg)), (arg)))
