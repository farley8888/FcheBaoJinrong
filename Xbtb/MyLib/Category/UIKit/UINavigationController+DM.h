//
//  UINavigationController+DM.h
//  ZCWL
//
//  Created by ios-dev on 16/3/29.
//  Copyright © 2016年 com.zcwljs.cnge.app. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UINavigationController (DM)

- (nullable NSArray<__kindof UIViewController *> *)popViewControllerForIndex:(NSInteger)index animated:(BOOL)animated;

- (nullable NSArray<__kindof UIViewController *> *)popViewControllerForReverseIndex:(NSInteger)index animated:(BOOL)animated;
- (nullable UIViewController *)viewControlleForReverseIndex:(NSInteger)index;

- (void)DM_pushViewController:(UIViewController *)viewController animated:(BOOL)animated;

@end
