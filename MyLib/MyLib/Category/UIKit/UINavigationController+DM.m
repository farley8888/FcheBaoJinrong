//
//  UINavigationController+DM.m
//  ZCWL
//
//  Created by ios-dev on 16/3/29.
//  Copyright © 2016年 com.zcwljs.cnge.app. All rights reserved.
//

#import "UINavigationController+DM.h"

@implementation UINavigationController (DM)

- (nullable NSArray<__kindof UIViewController *> *)popViewControllerForIndex:(NSInteger)index animated:(BOOL)animated
{
    NSArray *vcs = self.viewControllers;
    if (index >= vcs.count) return nil;
    if (index < 0) return nil;
    UIViewController *vc = vcs[index];
    return [self popToViewController:vc animated:animated];
}

- (NSArray<UIViewController *> *)popViewControllerForReverseIndex:(NSInteger)index animated:(BOOL)animated
{
    NSArray *vcs = self.viewControllers;
    if (index >= vcs.count) return nil;
    if (index < 0) return nil;
    UIViewController *vc = vcs[vcs.count-index-1];
    return [self popToViewController:vc animated:animated];
}

- (UIViewController *)viewControlleForReverseIndex:(NSInteger)index
{
    NSArray *vcs = self.viewControllers;
    if (index >= vcs.count) return nil;
    if (index < 0) return nil;
    UIViewController *vc = vcs[vcs.count-index-1];
    return vc;
}

- (void)DM_pushViewController:(UIViewController *)viewController animated:(BOOL)animated
{
    NSMutableArray *vcs = [self.viewControllers mutableCopy];
    [vcs removeLastObject];
    [vcs addObject:viewController];
    [self setViewControllers:vcs animated:animated];
}

@end
