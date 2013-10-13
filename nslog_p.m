//
//  nslog_p.c
//  nslog_p
//
//  Created by Stephen Sykes on 13/10/13.
//  Copyright (c) 2013 BinaryAge. All rights reserved.
//

#import "nslog_p.h"

#define npNSStringForType(type, stringFunction) \
    if (strcmp(typeCode, @encode(type)) == 0) {\
        type arg = va_arg(listPointer, type);\
        va_end(listPointer);\
        return stringFunction(arg);\
    }

#define npNSStringForSimpleType(type, va_argType, formatString) \
    if (strcmp(typeCode, @encode(type)) == 0) {\
        va_argType arg = va_arg(listPointer, va_argType);\
        va_end(listPointer);\
        return [NSString stringWithFormat:formatString, arg];\
    }


NSString * npStringFromAnyType(char *typeCode, ...) {
    va_list listPointer;
    va_start(listPointer, typeCode);
    
#if TARGET_OS_IPHONE
    npNSStringForType(CGPoint, NSStringFromCGPoint);
    npNSStringForType(CGRect, NSStringFromCGRect);
    npNSStringForType(CGSize, NSStringFromCGSize);
    npNSStringForType(CGAffineTransform, NSStringFromCGAffineTransform);
    npNSStringForType(UIEdgeInsets, NSStringFromUIEdgeInsets);
    npNSStringForType(UIOffset, NSStringFromUIOffset);
#else
    npNSStringForType(CGPoint, NSStringFromPoint);
    npNSStringForType(CGRect, NSStringFromRect);
    npNSStringForType(CGSize, NSStringFromSize);
#endif
    
    npNSStringForType(SEL, NSStringFromSelector);
    npNSStringForType(Class, NSStringFromClass);
    npNSStringForType(NSRange, NSStringFromRange);
    npNSStringForType(id, );

    npNSStringForSimpleType(BOOL, int, @"%d");
    npNSStringForSimpleType(int, int, @"%d");
    npNSStringForSimpleType(short, int, @"%d");
    npNSStringForSimpleType(unsigned int, unsigned int, @"%u");
    npNSStringForSimpleType(unsigned short, unsigned int, @"%u");
    npNSStringForSimpleType(long, long, @"%li");
    npNSStringForSimpleType(unsigned long, unsigned long, @"%lu");
    npNSStringForSimpleType(long long, long long, @"%lli");
    npNSStringForSimpleType(unsigned long long, unsigned long long, @"%llu");
    npNSStringForSimpleType(float, double, @"%f");
    npNSStringForSimpleType(double, double, @"%f");
    npNSStringForSimpleType(char *, char *, @"%s");
    npNSStringForSimpleType(unsigned char *, unsigned char *, @"%s");
    
    if (*typeCode == '[' && strspn(typeCode, "[]1234567890c") == strlen(typeCode)) {
        char *arg = va_arg(listPointer, char *);
        va_end(listPointer);
        return [NSString stringWithFormat:@"%s", arg];
    }

    if (*typeCode == '^' ) {
        void *arg = va_arg(listPointer, void *);
        va_end(listPointer);
        return [NSString stringWithFormat:@"%p", arg];
    }

    return @"(unknown type)";
}
