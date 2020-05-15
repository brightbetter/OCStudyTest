//
//  UIViewController+bwSwizzle.m
//  OCStudyTest
//
//  Created by Bright on 2020/5/9.
//  Copyright © 2020 Bright. All rights reserved.
//

#import "UIViewController+bwSwizzle.h"
#import "NSObject+bwSwizzle.h"
#import <objc/runtime.h>


@implementation UIViewController (bwSwizzle)

//+(void)load {
//    NSLog(@"bwSwizzle load");
//    static dispatch_once_t onceToken;
//    dispatch_once(&onceToken, ^{
//        [self swizzleSEL:@selector(viewWillAppear:) withSEL:@selector(bwSwizzled_viewWillAppear:)];
//    });
//}

- (void)bwSwizzled_viewWillAppear:(BOOL)animated {
     NSLog(@"555 %@", [self class]);
    [self bwSwizzled_viewWillAppear:animated];
}


@end
