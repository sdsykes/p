nslog_p
=======

Log any type in objective c with a single function call.

Defines a function that will NSLog almost any type.

    p(arg)

The type is determined using the Objective C type encoding
information from @encoding(). Objects, simple numeric types,
C strings, and types that can be converted using the NSStringFrom...
functions are supported.

Compiler type errors are avoided by passing the argument
through va_args.

## Examples
    #import "nslog_p.h"
    
    p(CGPointMake(123, 345));
    p(CGRectMake(1, 2, 3, 4));
    p(CGSizeMake(1.9, 100.9));
    p(99.2);
    p(YES);
    p(100);
    p(@"NSString");
    p(NSRangeFromString(@"99,5"));
    char *s = "C String";
    p(s);
    p(&s);
    p("Direct C String");
    p([NSObject new]);
    p([NSMutableArray class]);
    p(@selector(initWithCapacity:));
