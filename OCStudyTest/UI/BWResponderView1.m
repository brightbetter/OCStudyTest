//
//  BWResponderView1.m
//  OCStudyTest
//
//  Created by Bright on 2020/3/30.
//  Copyright © 2020 Bright. All rights reserved.
//

#import "BWResponderView1.h"

@implementation BWResponderView1

- (UIView *)hitTest:(CGPoint)point withEvent:(UIEvent *)event {
    NSLog(@"hittest %@",self);
    return [super hitTest:point withEvent:event];
}

- (BOOL)pointInside:(CGPoint)point withEvent:(UIEvent *)event {
    NSLog(@"pointInside %@",self);
    return [super pointInside:point withEvent:event];
}

@end
