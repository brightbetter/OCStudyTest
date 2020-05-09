//
//  UIViewController+psSwizzle.m
//  OCStudyTest
//
//  Created by Bright on 2020/5/9.
//  Copyright © 2020 Bright. All rights reserved.
//

#import "UIViewController+psSwizzle.h"
#import "NSObject+bwSwizzle.h"


@implementation UIViewController (psSwizzle)

+ (void)load {
    NSLog(@"psSwizzle load");
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        [self swizzleSEL:@selector(viewWillAppear:) withSEL:@selector(swizzled_viewWillAppear:)];
    });
}

- (void)swizzled_viewWillAppear:(BOOL)animated {
    [self swizzled_viewWillAppear:animated];
    NSLog(@"666");
}

@end
