//
//  DMVCTool.m
//  XHGY_Agent
//
//  Created by 尚往文化 on 17/6/8.
//  Copyright © 2017年 DMing. All rights reserved.
//

#import "DMVCTool.h"

@implementation DMVCTool

+ (UIViewController *)getVCForView:(UIView *)view
{
    for (UIView *next = [view superview]; next; next = next.superview) {
        UIResponder* nextResponder = [next nextResponder];
        if ([nextResponder isKindOfClass:[UIViewController class]]) {
            return (UIViewController*)nextResponder;
        }
    }
    return nil;
}

+ (UIViewController *)getCurrentVC
{
    UIWindow *window = [[UIApplication sharedApplication].windows firstObject];
    UITabBarController *rootVC = window.rootViewController;
    if (rootVC.presentedViewController) {
        return rootVC.presentedViewController;
    } else {
        return ((UINavigationController *)rootVC.selectedViewController).topViewController;
    }
}


@end
