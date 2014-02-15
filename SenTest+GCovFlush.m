//
//  SenTest+GCovFlush.m
//  TestOutCoverage
//
//  Created by LeRoy Mattingly on 9/13/13.
//  Copyright (c) 2013 OpenSource. All rights reserved.
//

#import "SenTest+GCovFlush.h"

@implementation SenTest (GCovFlush)

+ (void)load
{
    Method original, swizzled;
    
    original = class_getInstanceMethod(self, @selector(tearDown));
    swizzled = class_getInstanceMethod(self, @selector(_swizzledTearDown));
    method_exchangeImplementations(original, swizzled);
}

- (void)_swizzledTearDown
{
    if (__gcov_flush) {
        __gcov_flush();
    }
    [self _swizzledTearDown];
}

@end
