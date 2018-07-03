//
//  DMGestureLockView.h
//  GestureLockDemo
//
//  Created by DM on 2017/4/5.
//  Copyright © 2017年 DM. All rights reserved.
//  九宫格 手势密码页面

#import <UIKit/UIKit.h>
@class DMGestureLockView;

#define UIColorFromRGB(rgbValue) [UIColor colorWithRed:((float)((rgbValue & 0xFF0000) >> 16))/255.0 green:((float)((rgbValue & 0xFF00) >> 8))/255.0 blue:((float)(rgbValue & 0xFF))/255.0 alpha:1.0]

#define Screen_Width [UIScreen mainScreen].bounds.size.width
#define Screen_Height [UIScreen mainScreen].bounds.size.height

@protocol DMGestureLockDelegate <NSObject>

- (void)gestureLockView:(DMGestureLockView *)lockView drawRectFinished:(NSMutableString *)gesturePassword;

@end

@interface DMGestureLockView : UIView

@property (assign, nonatomic) id<DMGestureLockDelegate> delegate;

@end
