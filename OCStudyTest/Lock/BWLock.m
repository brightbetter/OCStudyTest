//
//  BWLock.m
//  OCStudyTest
//
//  Created by Bright on 2020/5/15.
//  Copyright © 2020 Bright. All rights reserved.
//

#import "BWLock.h"
#import <pthread.h>

@implementation BWLock

#pragma mark - 锁性能
/*
锁性能 spinLock > semaphore > pthread_mutex > NSLock > NSCondition > pthreadMutexRecursive > NSRecursiveLock > NSConditionLock > @synchronized
*/

#pragma mark - 自旋锁
/*
 自旋锁：
 是用于多线程同步的一种锁，线程反复检查锁变量是否可用。由于线程在这一过程中保持执行，因此是一种忙等待。一旦获取了自旋锁，线程会一直保持该锁，直至显式释放自旋锁。 自旋锁避免了进程上下文的调度开销，因此对于线程只会阻塞很短时间的场合是有效的
 */
- (void)spinLock {
//    OSSpinLock lock = OS_SPINLOCK_INIT;
//    OSSpinLockLock(&lock);
//    NSLog(@"业务逻辑部分");
//    OSSpinLockUnlock(&lock);
//    if (@available(iOS 10.0, *)) {
//        os_unfair_lock_t unfairLock;
//        unfairLock = &(OS_UNFAIR_LOCK_INIT);
//        os_unfair_lock_lock(unfairLock);
//        os_unfair_lock_unlock(unfairLock);
//    } else {
//        // Fallback on earlier versions
//    }
    
}

#pragma mark - 信号量
/*
信号量（semaphore）：
 是一种更高级的同步机制，互斥锁可以说是semaphore在仅取值0/1时的特例。信号量可以有更多的取值空间，用来实现更加复杂的同步，而不单单是线程间互斥。
 */
- (void)semaphore {
    dispatch_semaphore_t signal = dispatch_semaphore_create(1);
    dispatch_time_t overTime = dispatch_time(DISPATCH_TIME_NOW, 3.0f * NSEC_PER_SEC);
    //线程1
    dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0), ^{
        NSLog(@"线程1 等待ing");
        dispatch_semaphore_wait(signal, overTime); //signal 值 -1
        NSLog(@"线程1");
        dispatch_semaphore_signal(signal); //signal 值 +1
        NSLog(@"线程1 发送信号");
        NSLog(@"--------------------------------------------------------");
    });

    //线程2
    dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0), ^{
        NSLog(@"线程2 等待ing");
        dispatch_semaphore_wait(signal, overTime);
        NSLog(@"线程2");
        dispatch_semaphore_signal(signal);
        NSLog(@"线程2 发送信号");
    });
}

#pragma mark - 互斥锁
/*
互斥锁（Mutex）：是一种用于多线程编程中，防止两条线程同时对同一公共资源（比如全局变量）进行读写的机制。该目的通过将代码切片成一个一个的临界区而达成。
*/
- (void)pthreadMutex {
    static pthread_mutex_t pLock;
    pthread_mutex_init(&pLock, NULL);
     //1.线程1
    dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0), ^{
        NSLog(@"线程1 准备上锁");
        pthread_mutex_lock(&pLock);
        sleep(3);
        NSLog(@"线程1");
        pthread_mutex_unlock(&pLock);
    });

    //1.线程2
    dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0), ^{
        NSLog(@"线程2 准备上锁");
        pthread_mutex_lock(&pLock);
        NSLog(@"线程2");
        pthread_mutex_unlock(&pLock);
    });
}

/*
 lock、unlock：不多做解释，和上面一样
 trylock：能加锁返回 YES 并执行加锁操作，相当于 lock，反之返回 NO
 ** lockBeforeDate：这个方法表示会在传入的时间内尝试加锁，若能加锁则执行加锁**操作并返回 YES，反之返回 NO
 */
- (void)nsLock {
    NSLock *lock = [NSLock new];
    //线程1
    dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0), ^{
        NSLog(@"线程1 尝试加速ing...");
        [lock lock];
        sleep(3);//睡眠5秒
        NSLog(@"线程1");
        [lock unlock];
        NSLog(@"线程1解锁成功");
    });

    //线程2
    dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0), ^{
        NSLog(@"线程2 尝试加速ing...");
        BOOL x =  [lock lockBeforeDate:[NSDate dateWithTimeIntervalSinceNow:4]];
        if (x) {
            NSLog(@"线程2");
            [lock unlock];
        }else{
            NSLog(@"失败");
        }
    });
}

#pragma mark - 递归锁

- (void)nsRecursiveLock {
//    NSLock *rLock = [NSLock new];//死锁
    NSRecursiveLock *rLock = [NSRecursiveLock new];
    dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0), ^{
        static void (^RecursiveBlock)(int);
        RecursiveBlock = ^(int value) {
            [rLock lock];
            if (value > 0) {
                NSLog(@"线程%d", value);
                RecursiveBlock(value - 1);
            }
            [rLock unlock];
        };
        RecursiveBlock(4);
    });
}

- (void)pthreadMutexRecursive {
    static pthread_mutex_t pLock;
    pthread_mutexattr_t attr;
    pthread_mutexattr_init(&attr); //初始化attr并且给它赋予默认
    pthread_mutexattr_settype(&attr, PTHREAD_MUTEX_RECURSIVE); //设置锁类型，这边是设置为递归锁
    pthread_mutex_init(&pLock, &attr);
    pthread_mutexattr_destroy(&attr); //销毁一个属性对象，在重新进行初始化之前该结构不能重新使用

    //1.线程1
    dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0), ^{
        static void (^RecursiveBlock)(int);
        RecursiveBlock = ^(int value) {
            pthread_mutex_lock(&pLock);
            if (value > 0) {
                NSLog(@"value: %d", value);
                RecursiveBlock(value - 1);
            }
            pthread_mutex_unlock(&pLock);
        };
        RecursiveBlock(5);
    });
}

#pragma mark - 读写锁
/*
读写锁：
 是计算机程序的并发控制的一种同步机制，也称“共享-互斥锁”、多读者-单写者锁) 用于解决多线程对公共资源读写问题。读操作可并发重入，写操作是互斥的。 读写锁通常用互斥锁、条件变量、信号量实现。
 */
- (void)pthreadRwlock {
    static pthread_rwlock_t rwlock;
    //加读锁
    pthread_rwlock_rdlock(&rwlock);
    //解锁
    pthread_rwlock_unlock(&rwlock);
    //加写锁
    pthread_rwlock_wrlock(&rwlock);
    //解锁
    pthread_rwlock_unlock(&rwlock);
}

#pragma mark - 条件锁
/*
条件锁：
 就是条件变量，当进程的某些资源要求不满足时就进入休眠，也就是锁住了。当资源被分配到了，条件锁打开，进程继续运行。
 */

/*
 wait：进入等待状态
 waitUntilDate:：让一个线程等待一定的时间
 signal：唤醒一个等待的线程
 broadcast：唤醒所有等待的线程
 */
- (void)nsCondition {
    NSCondition *cLock = [NSCondition new];
    //线程1
    dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0), ^{
        [cLock lock];
        NSLog(@"线程1加锁成功");
        [cLock waitUntilDate:[NSDate dateWithTimeIntervalSinceNow:2]];
        NSLog(@"线程1");
        [cLock unlock];
    });

    //线程2
    dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0), ^{
        [cLock lock];
        NSLog(@"线程2加锁成功");
        [cLock wait];
        NSLog(@"线程2");
        [cLock unlock];
    });

    dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0), ^{
        sleep(2);
        NSLog(@"唤醒一个等待的线程");
        [cLock signal];
    });
    
    dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0), ^{
        sleep(2);
        NSLog(@"唤醒所有等待的线程");
        [cLock broadcast];
    });
}

//NSConditionLock 还可以实现任务之间的依赖。
- (void)nsConditionLock {
    NSConditionLock *cLock = [[NSConditionLock alloc] initWithCondition:0];

    //线程1
    dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0), ^{
        if([cLock tryLockWhenCondition:0]){
            NSLog(@"线程1");
           [cLock unlockWithCondition:1];
        }else{
             NSLog(@"失败");
        }
    });

    //线程2
    dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0), ^{
        [cLock lockWhenCondition:3];
        NSLog(@"线程2");
        [cLock unlockWithCondition:2];
    });

    //线程3
    dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0), ^{
        [cLock lockWhenCondition:1];
        NSLog(@"线程3");
        [cLock unlockWithCondition:3];
    });
}

- (void)synchronized {
    //线程1
    dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0), ^{
        @synchronized (self) {
            sleep(2);
            NSLog(@"线程1");
        }
    });

    //线程2
    dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0), ^{
        @synchronized (self) {
            NSLog(@"线程2");
        }
    });
}

@end
