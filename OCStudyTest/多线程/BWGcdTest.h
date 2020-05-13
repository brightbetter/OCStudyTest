//
//  BWGcdTest.h
//  OCStudyTest
//
//  Created by Bright on 2020/3/29.
//  Copyright © 2020 Bright. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface BWGcdTest : NSObject

+ (void)testBarrier;

+ (void)testAsync1;

+ (void)testAsync2;

+ (void)taskDepend;

@end

NS_ASSUME_NONNULL_END
