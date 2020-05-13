//
//  NSObject+bwSwizzle.m
//  OCStudyTest
//
//  Created by Bright on 2020/5/9.
//  Copyright © 2020 Bright. All rights reserved.
//

#import "NSObject+bwSwizzle.h"
#import <objc/runtime.h>


@implementation NSObject (bwSwizzle)

+ (void)swizzleSEL:(SEL)originalSEL withSEL:(SEL)swizzledSEL {
    
    Class class = [self class];
    
    Method originalMethod = class_getInstanceMethod(class, originalSEL);
    Method swizzledMethod = class_getInstanceMethod(class, swizzledSEL);
    
    BOOL didAddMethod =
    class_addMethod(class,
                    originalSEL,
                    method_getImplementation(swizzledMethod),
                    method_getTypeEncoding(swizzledMethod));
    
    if (didAddMethod) {
        class_replaceMethod(class,
                            swizzledSEL,
                            method_getImplementation(originalMethod),
                            method_getTypeEncoding(originalMethod));
    } else {
        method_exchangeImplementations(originalMethod, swizzledMethod);
    }
}

@end
