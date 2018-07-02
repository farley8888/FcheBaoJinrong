//
//  UIViewController+DMExample.m
//  LanHUaJi
//
//  Created by apple on 2018/6/7.
//  Copyright © 2018年 apple. All rights reserved.
//

#import "UIViewController+DMExample.h"

@implementation UIViewController (DMExample)
#pragma mark - swizzle
+ (void)load
{
    Method method1 = class_getInstanceMethod([self class], NSSelectorFromString(@"dealloc"));
    Method method2 = class_getInstanceMethod([self class], @selector(deallocSwizzle));
    method_exchangeImplementations(method1, method2);
}

- (void)deallocSwizzle
{
    DMLog(@"%@被销毁了", self);
}

static char MethodKey;
- (void)setMethod:(NSString *)method
{
    objc_setAssociatedObject(self, &MethodKey, method, OBJC_ASSOCIATION_COPY_NONATOMIC);
}

- (NSString *)method
{
    return objc_getAssociatedObject(self, &MethodKey);
}

@end
