//
//  BWGcdTest.m
//  OCStudyTest
//
//  Created by Bright on 2020/3/29.
//  Copyright © 2020 Bright. All rights reserved.
//

#import "BWGcdTest.h"

@implementation BWGcdTest

+ (void)testBarrier {
    
}

+ (void)testAsync1 {
//    dispatch_sync(dispatch_get_main_queue(), ^{
//        NSLog(@"");
//    });
//    
//    dispatch_sync(dispatch_get_main_queue(), ^{
//        NSLog(@"");
//    });
//    
//    dispatch_async(dispatch_get_main_queue(), ^{
//        NSLog(@"");
//    });
//    
//    dispatch_async(dispatch_get_main_queue(), ^{
//        NSLog(@"");
//    });
    
}

+ (void)testAsync2 {
    dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0), ^{
        NSLog(@"1");
        [self performSelector:@selector(printLog) withObject:nil afterDelay:0];
        NSLog(@"3");
    });
    
//    dispatch_async(dispatch_get_main_queue(), ^{
//        NSLog(@"");
//    });
    
}

+ (void)taskDepend {
    dispatch_queue_t queue = dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0);
    dispatch_group_t group = dispatch_group_create();
    
    dispatch_group_async(group, queue, ^{
        sleep(5);
        NSLog(@"task1");
    });
    
    dispatch_group_async(group, queue, ^{
        sleep(2);
        NSLog(@"task2");
    });
    
    dispatch_group_async(group, queue, ^{
        sleep(3);
        NSLog(@"task3");
    });
    
    dispatch_group_notify(group, queue, ^{
        NSLog(@"all task done");
    });
}

+ (void)printLog {
    //不会执行，因为创建的线程没有将该方法添加到runlopp中
    NSLog(@"2");
}

@end
