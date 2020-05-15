//
//  BWProperty.m
//  OCStudyTest
//
//  Created by Bright on 2020/5/15.
//  Copyright © 2020 Bright. All rights reserved.
//

#import "BWProperty.h"

@implementation BWProperty

- (void)testCopy {
    NSString *tmp = @"dadasa";
//    self.mCopyArray = [@[@"sdsds"] mutableCopy];
//    [self.mCopyArray addObject: tmp];//crash copy 后是不可变对象
    NSLog(@"1111");
    self.mStrongArray = [@[@"sdsds"] mutableCopy];
    self.acopyArray = self.mStrongArray;
    self.astrongArray = self.mStrongArray;
    
    [self.mStrongArray addObject:tmp];
    NSLog(@"mStrongArray %@",self.mStrongArray);
    NSLog(@"acopyArray %@",self.acopyArray);
    NSLog(@"astrongArray %@",self.astrongArray);
}


#pragma mark - Setter && Getter

- (NSMutableArray *)mCopyArray {
    if (!_mCopyArray) {
        _mCopyArray = [NSMutableArray new];
    }
    return _mCopyArray;
}

- (NSMutableArray *)mStrongArray {
    if (!_mStrongArray) {
        _mStrongArray = [NSMutableArray new];
    }
    return _mStrongArray;
}

- (NSArray *)acopyArray {
    if (!_acopyArray) {
        _acopyArray = [NSArray new];
    }
    return _acopyArray;
}

- (NSArray *)astrongArray {
    if (!_astrongArray) {
        _astrongArray = [NSArray new];
    }
    return _astrongArray;
}

@end
