//
//  NSObject+bwSwizzle.h
//  OCStudyTest
//
//  Created by Bright on 2020/5/9.
//  Copyright © 2020 Bright. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface NSObject (bwSwizzle)

+ (void)swizzleSEL:(SEL)originalSEL withSEL:(SEL)swizzledSEL;

@end

NS_ASSUME_NONNULL_END
