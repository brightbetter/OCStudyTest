//
//  BWMethodTest.m
//  OCStudyTest
//
//  Created by Bright on 2020/3/22.
//  Copyright © 2020 Bright. All rights reserved.
//

#import "BWMethodTest.h"
#import <objc/runtime.h>

@interface BWMethodForwardTest : NSObject

@end

@implementation BWMethodForwardTest

- (void)forwardTest {
    NSLog(@"called forwardMethod");
}

// 第1步 是否有动态添加方法
+ (BOOL)resolveInstanceMethod:(SEL)sel {//会继续消息转发流程
    NSLog(@"BWMethodForwardTest called resolveInstanceMethod:%@",NSStringFromSelector(sel));
//    NSString *methodName = NSStringFromSelector(sel);
//    if ([methodName isEqualToString:@"forwardTest"]) {
//        return class_addMethod(self, sel, (IMP)forwardTest, "v@:");
//    }
    return NO;
}

@end

@implementation BWMethodTest

#pragma mark - 方法交换

+ (void)load {
    Method metaTest = class_getClassMethod(self, @selector(metaTest));
    Method metaOtherTest = class_getClassMethod(self, @selector(metaOtherTest));
    
//    Method metaTest = class_getInstanceMethod(object_getClass(self), @selector(metaTest));
//    Method metaOtherTest = class_getInstanceMethod(object_getClass(self), @selector(metaOtherTest));
    method_exchangeImplementations(metaTest, metaOtherTest);
    
    Method test = class_getInstanceMethod(self, @selector(test));
    Method otherTest = class_getInstanceMethod(self, @selector(otherTest));
    method_exchangeImplementations(test, otherTest);
}

+ (void)metaTest {
    NSLog(@"called metaTest");
}

+ (void)metaOtherTest {
    [self metaOtherTest]; //实际上是调用的metaTest方法
    NSLog(@"called metaOtherTest");
}

- (void)test {
    NSLog(@"called test");
}

- (void)otherTest {
    [self otherTest]; //实际上是调用的test方法
    NSLog(@"called othertest");
}

#pragma mark - 消息转发

//- (void)forwardTest {
//    NSLog(@"called forwardTest");
//}

void forwardTest(id self,SEL _cmd) {
    NSLog(@"forwardTest msg");
}


// 第1步 是否有动态添加方法
+ (BOOL)resolveInstanceMethod:(SEL)sel {
    NSLog(@"called resolveInstanceMethod:%@",NSStringFromSelector(sel));
//    NSString *methodName = NSStringFromSelector(sel);
//    if ([methodName isEqualToString:@"forwardTest"]) {
//        return class_addMethod(self, sel, (IMP)forwardTest, "v@:");
//    }
    return NO;
}

// 第2步 是否有备用接收者，就是委托别人帮你实现了，返回这个类
- (id)forwardingTargetForSelector:(SEL)aSelector {
    NSLog(@"called forwardingTargetForSelector:%@",NSStringFromSelector(aSelector));
    NSString *methodName = NSStringFromSelector(aSelector);
    if ([methodName isEqualToString:@"forwardTest"]) {
        return [BWMethodForwardTest new];
    }
    return [super forwardingTargetForSelector:aSelector];
}

// 第3步 是否允许方法签名转发
- (NSMethodSignature *)methodSignatureForSelector:(SEL)aSelector {
    NSLog(@"called methodSignatureForSelector:%@",NSStringFromSelector(aSelector));
//    NSString *methodName = NSStringFromSelector(aSelector);
//    if ([methodName isEqualToString:@"forwardTest"]) {
//        return [NSMethodSignature signatureWithObjCTypes:"v@:"];
//    }
    return [super methodSignatureForSelector:aSelector];
}
// 方法签名转发到某个类
- (void)forwardInvocation:(NSInvocation *)anInvocation {
    NSLog(@"called forwardInvocation:%@", anInvocation);
//    SEL sel = anInvocation.selector;
//    BWMethodForwardTest *methodForwardTest = [BWMethodForwardTest new];
//    if ([methodForwardTest respondsToSelector:sel]) {
//        [anInvocation invokeWithTarget:methodForwardTest];
//    }else {
//        [super forwardInvocation:anInvocation];
//    }
    return;
}

//消息未处理，crash
-(void)doesNotRecognizeSelector:(SEL)aSelector{
    NSLog(@"called doesNotRecognizeSelector:%@",NSStringFromSelector(aSelector));
}

@end
