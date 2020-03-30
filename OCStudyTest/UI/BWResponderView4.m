//
//  BWResponderView4.m
//  OCStudyTest
//
//  Created by Bright on 2020/3/30.
//  Copyright © 2020 Bright. All rights reserved.
//

#import "BWResponderView4.h"

@implementation BWResponderView4

- (UIView *)hitTest:(CGPoint)point withEvent:(UIEvent *)event {
    NSLog(@"hittest %@",self);
    return [super hitTest:point withEvent:event];
}

- (BOOL)pointInside:(CGPoint)point withEvent:(UIEvent *)event {
    //首先调用父类的方法确定点击的区域确实在按钮的区域中
    BOOL res = [super pointInside:point withEvent:event];
    if (res) {
        //绘制一个圆形path
        UIBezierPath *path = [UIBezierPath bezierPathWithOvalInRect:self.bounds];
        if ([path containsPoint:point]) {
            //如果在path区域内，返回YES
            return YES;
        }
        return NO;
    }
    return NO;
}

@end
