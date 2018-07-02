//
//  DMCustomNavigationBar.h
//  XYG
//
//  Created by ltyj on 2017/12/20.
//  Copyright © 2017年 Mac. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface DMCustomNavigationBar : UIView

@property (nonatomic, copy) void(^onClickLeftButton)(void);
@property (nonatomic, copy) void(^onClickRightButton)(void);

@property (nonatomic, copy)   NSString *title;
@property (nonatomic, strong) UIColor  *titleLabelColor;
@property (nonatomic, strong) UIFont   *titleLabelFont;
@property (nonatomic, strong) UIColor  *barBackgroundColor;
@property (nonatomic, strong) UIImage  *barBackgroundImage;

+ (instancetype)CustomNavigationBar;

- (void)dm_setBottomLineHidden:(BOOL)hidden;
- (void)dm_setBackgroundAlpha:(CGFloat)alpha;
- (void)dm_setTintColor:(UIColor *)color;

// 默认返回事件
//- (void)dm_setLeftButtonWithNormal:(UIImage *)normal highlighted:(UIImage *)highlighted title:(NSString *)title titleColor:(UIColor *)titleColor;
//- (void)dm_setLeftButtonWithImage:(UIImage *)image title:(NSString *)title titleColor:(UIColor *)titleColor;
- (void)dm_setLeftButtonWithNormal:(UIImage *)normal highlighted:(UIImage *)highlighted;
- (void)dm_setLeftButtonWithImage:(UIImage *)image;
- (void)dm_setLeftButtonWithTitle:(NSString *)title titleColor:(UIColor *)titleColor;

//- (void)dm_setRightButtonWithNormal:(UIImage *)normal highlighted:(UIImage *)highlighted title:(NSString *)title titleColor:(UIColor *)titleColor;
//- (void)dm_setRightButtonWithImage:(UIImage *)image title:(NSString *)title titleColor:(UIColor *)titleColor;
- (void)dm_setRightButtonWithNormal:(UIImage *)normal highlighted:(UIImage *)highlighted;
- (void)dm_setRightButtonWithImage:(UIImage *)image;
- (void)dm_setRightButtonWithTitle:(NSString *)title titleColor:(UIColor *)titleColor;
- (void)dm_setRightButtonFrame:(CGRect)frame;


@end
