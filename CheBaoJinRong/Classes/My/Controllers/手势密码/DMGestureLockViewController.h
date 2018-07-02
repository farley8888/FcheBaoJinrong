//
//  DMGestureLockViewController.h
//  GestureLockDemo
//
//  Created by DM on 2017/4/5.
//  Copyright © 2017年 DM. All rights reserved.
//  手势密码界面 控制器

#import <UIKit/UIKit.h>

typedef NS_ENUM(NSInteger,DMUnlockType) {
    DMUnlockTypeCreatePsw, // 创建手势密码
    DMUnlockTypeValidatePsw // 校验手势密码
};

@interface DMGestureLockViewController : UIViewController

+ (void)deleteGesturesPassword;//删除手势密码
+ (NSString *)gesturesPassword;//获取手势密码

- (instancetype)initWithUnlockType:(DMUnlockType)unlockType;

@end
