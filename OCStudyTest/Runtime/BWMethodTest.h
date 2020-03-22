//
//  BWMethodTest.h
//  OCStudyTest
//
//  Created by Bright on 2020/3/22.
//  Copyright © 2020 Bright. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface BWMethodTest : NSObject

#pragma mark - 方法交换
+ (void)metaTest;

- (void)test;

#pragma mark - 消息转发
- (void)forwardTest;

@end

NS_ASSUME_NONNULL_END
