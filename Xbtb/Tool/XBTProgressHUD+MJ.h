//
//  MBProgressHUD+MJ.h
//
//  Created by mj on 13-4-18.
//  Copyright (c) 2013年 itcast. All rights reserved.
//

#import "XBTProgressHUD.h"

@interface XBTProgressHUD (MJ)
+ (void)showSuccess:(NSString *)success toView:(UIView *)view;
+ (void)showError:(NSString *)error toView:(UIView *)view;

+ (XBTProgressHUD *)showMessage:(NSString *)message toView:(UIView *)view;


+ (void)showSuccess:(NSString *)success;
+ (void)showSuccess:(NSString *)success afterDelay:(NSTimeInterval)afterDelay;


+ (void)showError:(NSString *)error;
+ (void)showError:(NSString *)error afterDelay:(NSTimeInterval)afterDelay;

+ (XBTProgressHUD *)showMessage:(NSString *)message;

+ (void)hideHUDForView:(UIView *)view;
+ (void)hideHUD;

@end
