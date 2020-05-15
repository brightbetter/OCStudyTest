//
//  BWLock.h
//  OCStudyTest
//
//  Created by Bright on 2020/5/15.
//  Copyright © 2020 Bright. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface BWLock : NSObject

///OSSpinLock 自旋锁 已经废弃不安全了 替代方案 os_unfair_lock 是一种互斥锁
- (void)spinLock;

@end

NS_ASSUME_NONNULL_END
