//
//  DMNavigationBar.h
//  XYG
//
//  Created by ltyj on 2017/12/20.
//  Copyright © 2017年 Mac. All rights reserved.
//

#import <UIKit/UIKit.h>

@class DMCustomNavigationBar;

@interface DMNavigationBar : UIView
+ (BOOL)isIphoneX;
+ (int)navBarBottom;
+ (int)tabBarHeight;
+ (int)screenWidth;
+ (int)screenHeight;

@end

#pragma mark - Default
@interface DMNavigationBar (DMDefault)

/** set default barTintColor of UINavigationBar */
+ (void)dm_setDefaultNavBarBarTintColor:(UIColor *)color;

/** set default barBackgroundImage of UINavigationBar */
/** warning: DM_setDefaultNavBarBackgroundImage is deprecated! place use DMCustomNavigationBar */
//+ (void)dm_setDefaultNavBarBackgroundImage:(UIImage *)image;

/** set default tintColor of UINavigationBar */
+ (void)dm_setDefaultNavBarTintColor:(UIColor *)color;

/** set default titleColor of UINavigationBar */
+ (void)dm_setDefaultNavBarTitleColor:(UIColor *)color;

/** set default statusBarStyle of UIStatusBar */
+ (void)dm_setDefaultStatusBarStyle:(UIStatusBarStyle)style;

/** set default shadowImage isHidden of UINavigationBar */
+ (void)dm_setDefaultNavBarShadowImageHidden:(BOOL)hidden;

@end



#pragma mark - UINavigationBar
@interface UINavigationBar (DMAddition) <UINavigationBarDelegate>

/** 设置导航栏所有BarButtonItem的透明度 */
- (void)dm_setBarButtonItemsAlpha:(CGFloat)alpha hasSystemBackIndicator:(BOOL)hasSystemBackIndicator;

/** 设置导航栏在垂直方向上平移多少距离 */
- (void)dm_setTranslationY:(CGFloat)translationY;

/** 获取当前导航栏在垂直方向上偏移了多少 */
- (CGFloat)dm_getTranslationY;

@end




#pragma mark - UIViewController
@interface UIViewController (DMAddition)

/** record current ViewController navigationBar backgroundImage */
/** warning: dm_setDefaultNavBarBackgroundImage is deprecated! place use dmCustomNavigationBar */
//- (void)dm_setNavBarBackgroundImage:(UIImage *)image;
- (UIImage *)dm_navBarBackgroundImage;

/** record current ViewController navigationBar barTintColor */
- (void)dm_setNavBarBarTintColor:(UIColor *)color;
- (UIColor *)dm_navBarBarTintColor;

/** record current ViewController navigationBar backgroundAlpha */
- (void)dm_setNavBarBackgroundAlpha:(CGFloat)alpha;
- (CGFloat)dm_navBarBackgroundAlpha;

/** record current ViewController navigationBar tintColor */
- (void)dm_setNavBarTintColor:(UIColor *)color;
- (UIColor *)dm_navBarTintColor;

/** record current ViewController titleColor */
- (void)dm_setNavBarTitleColor:(UIColor *)color;
- (UIColor *)dm_navBarTitleColor;

/** record current ViewController statusBarStyle */
- (void)dm_setStatusBarStyle:(UIStatusBarStyle)style;
- (UIStatusBarStyle)dm_statusBarStyle;

/** record current ViewController navigationBar shadowImage hidden */
- (void)dm_setNavBarShadowImageHidden:(BOOL)hidden;
- (BOOL)dm_navBarShadowImageHidden;

/** record current ViewController custom navigationBar */
/** warning: dm_setDefaultNavBarBackgroundImage is deprecated! place use dmCustomNavigationBar */
//- (void)dm_setCustomNavBar:(DMCustomNavigationBar *)navBar;

@end
