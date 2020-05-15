//
//  BWProperty.h
//  OCStudyTest
//
//  Created by Bright on 2020/5/15.
//  Copyright © 2020 Bright. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface BWProperty : NSObject

//strong 和 copy作用于可变对象和不可变对象
@property (nonatomic, copy) NSMutableArray *mCopyArray;
@property (nonatomic, strong) NSMutableArray *mStrongArray;
@property (nonatomic, copy) NSArray *acopyArray;
@property (nonatomic, strong) NSArray *astrongArray;
@property (nonatomic, copy) NSString *acopyString;

//strong 和 copy作用于可变对象和不可变对象

- (void)testCopy;

@end

NS_ASSUME_NONNULL_END
