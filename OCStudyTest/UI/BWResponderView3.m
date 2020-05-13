//
//  BWResponderView3.m
//  OCStudyTest
//
//  Created by Bright on 2020/3/30.
//  Copyright © 2020 Bright. All rights reserved.
//

#import "BWResponderView3.h"

@implementation BWResponderView3

- (UIView *)hitTest:(CGPoint)point withEvent:(UIEvent *)event {
    UIView *hitView =  [super hitTest:point withEvent:event];
    if (hitView) {
        NSLog(@"hittest view3 %@",hitView);
    }
    return hitView;
}

- (BOOL)pointInside:(CGPoint)point withEvent:(UIEvent *)event {
    
    BOOL flag = [super pointInside:point withEvent:event];
    if (flag) {
        NSLog(@"pointInside %@",self);
    }
    return flag;
}

@end
