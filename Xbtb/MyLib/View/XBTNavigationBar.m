//
//  XBTNavigationBar.m
//  XYG
//
//  Created by ltyj on 2017/12/20.
//  Copyright © 2017年 Mac. All rights reserved.
//

#import "XBTNavigationBar.h"
#import <objc/runtime.h>
#import "UIView+GradientColor.h"
#import "XBTDefine.h"

@implementation XBTNavigationBar

+ (BOOL)isIphoneX
{
    if (CGRectEqualToRect([UIScreen mainScreen].bounds,CGRectMake(0, 0, 375, 812))) {
        return YES;
    } else {
        return NO;
    }
}
+ (int)navBarBottom {
    return [self isIphoneX] ? 88 : 64;
}
+ (int)tabBarHeight {
    return [self isIphoneX] ? 83 : 49;
}
+ (int)screenWidth {
    return [UIScreen mainScreen].bounds.size.width;
}
+ (int)screenHeight {
    return [UIScreen mainScreen].bounds.size.height;
}
@end


//===============================================================================================
#pragma mark - default navigationBar barTintColor、tintColor and statusBarStyle YOU CAN CHANGE!!!
//===============================================================================================
@implementation XBTNavigationBar (DMDefault)

static char kDMDefaultNavBarBarTintColorKey;
static char kDMDefaultNavBarBackgroundImageKey;
static char kDMDefaultNavBarTintColorKey;
static char kDMDefaultNavBarTitleColorKey;
static char kDMDefaultStatusBarStyleKey;
static char kDMDefaultNavBarShadowImageHiddenKey;

+ (UIColor *)defaultNavBarBarTintColor
{
    UIColor *color = (UIColor *)objc_getAssociatedObject(self, &kDMDefaultNavBarBarTintColorKey);
    return (color != nil) ? color : [UIColor whiteColor];
}
+ (void)dm_setDefaultNavBarBarTintColor:(UIColor *)color {
    objc_setAssociatedObject(self, &kDMDefaultNavBarBarTintColorKey, color, OBJC_ASSOCIATION_RETAIN_NONATOMIC);
}

+ (UIImage *)defaultNavBarBackgroundImage
{
    UIImage *image = (UIImage *)objc_getAssociatedObject(self, &kDMDefaultNavBarBackgroundImageKey);
    return image;
}
+ (void)dm_setDefaultNavBarBackgroundImage:(UIImage *)image {
    objc_setAssociatedObject(self, &kDMDefaultNavBarBackgroundImageKey, image, OBJC_ASSOCIATION_RETAIN_NONATOMIC);
}

+ (UIColor *)defaultNavBarTintColor {
    UIColor *color = (UIColor *)objc_getAssociatedObject(self, &kDMDefaultNavBarTintColorKey);
    return (color != nil) ? color : [UIColor colorWithRed:0 green:0.478431 blue:1 alpha:1.0];
}
+ (void)dm_setDefaultNavBarTintColor:(UIColor *)color {
    objc_setAssociatedObject(self, &kDMDefaultNavBarTintColorKey, color, OBJC_ASSOCIATION_RETAIN_NONATOMIC);
}

+ (UIColor *)defaultNavBarTitleColor
{
    UIColor *color = (UIColor *)objc_getAssociatedObject(self, &kDMDefaultNavBarTitleColorKey);
    return (color != nil) ? color : [UIColor blackColor];
}
+ (void)dm_setDefaultNavBarTitleColor:(UIColor *)color {
    objc_setAssociatedObject(self, &kDMDefaultNavBarTitleColorKey, color, OBJC_ASSOCIATION_RETAIN_NONATOMIC);
}

+ (UIStatusBarStyle)defaultStatusBarStyle
{
    id style = objc_getAssociatedObject(self, &kDMDefaultStatusBarStyleKey);
    return (style != nil) ? [style integerValue] : UIStatusBarStyleDefault;
}
+ (void)dm_setDefaultStatusBarStyle:(UIStatusBarStyle)style {
    objc_setAssociatedObject(self, &kDMDefaultStatusBarStyleKey, @(style), OBJC_ASSOCIATION_RETAIN_NONATOMIC);
}

+ (BOOL)defaultNavBarShadowImageHidden {
    id hidden = objc_getAssociatedObject(self, &kDMDefaultNavBarShadowImageHiddenKey);
    return (hidden != nil) ? [hidden boolValue] : NO;
}
+ (void)dm_setDefaultNavBarShadowImageHidden:(BOOL)hidden {
    objc_setAssociatedObject(self, &kDMDefaultNavBarShadowImageHiddenKey, @(hidden), OBJC_ASSOCIATION_RETAIN_NONATOMIC);
}

+ (CGFloat)defaultNavBarBackgroundAlpha {
    return 1.0;
}

+ (UIColor *)middleColor:(UIColor *)fromColor toColor:(UIColor *)toColor percent:(CGFloat)percent
{
    CGFloat fromRed = 0;
    CGFloat fromGreen = 0;
    CGFloat fromBlue = 0;
    CGFloat fromAlpha = 0;
    [fromColor getRed:&fromRed green:&fromGreen blue:&fromBlue alpha:&fromAlpha];
    
    CGFloat toRed = 0;
    CGFloat toGreen = 0;
    CGFloat toBlue = 0;
    CGFloat toAlpha = 0;
    [toColor getRed:&toRed green:&toGreen blue:&toBlue alpha:&toAlpha];
    
    CGFloat newRed = fromRed + (toRed - fromRed) * percent;
    CGFloat newGreen = fromGreen + (toGreen - fromGreen) * percent;
    CGFloat newBlue = fromBlue + (toBlue - fromBlue) * percent;
    CGFloat newAlpha = fromAlpha + (toAlpha - fromAlpha) * percent;
    return [UIColor colorWithRed:newRed green:newGreen blue:newBlue alpha:newAlpha];
}
+ (CGFloat)middleAlpha:(CGFloat)fromAlpha toAlpha:(CGFloat)toAlpha percent:(CGFloat)percent {
    return fromAlpha + (toAlpha - fromAlpha) * percent;
}

@end


//==========================================================================
#pragma mark - UINavigationBar
//==========================================================================
@implementation UINavigationBar (DMAddition)

static char kDMBackgroundViewKey;
static char kDMBackgroundImageViewKey;
static char kDMBackgroundImageKey;

- (UIView *)backgroundView {
    return (UIView *)objc_getAssociatedObject(self, &kDMBackgroundViewKey);
}
- (void)setBackgroundView:(UIView *)backgroundView {
    objc_setAssociatedObject(self, &kDMBackgroundViewKey, backgroundView, OBJC_ASSOCIATION_RETAIN_NONATOMIC);
}

- (UIImageView *)backgroundImageView {
    return (UIImageView *)objc_getAssociatedObject(self, &kDMBackgroundImageViewKey);
}
- (void)setBackgroundImageView:(UIImageView *)bgImageView {
    objc_setAssociatedObject(self, &kDMBackgroundImageViewKey, bgImageView, OBJC_ASSOCIATION_RETAIN_NONATOMIC);
}
- (UIImage *)backgroundImage {
    return (UIImage *)objc_getAssociatedObject(self, &kDMBackgroundImageKey);
}
- (void)setBackgroundImage:(UIImage *)image {
    objc_setAssociatedObject(self, &kDMBackgroundImageKey, image, OBJC_ASSOCIATION_RETAIN_NONATOMIC);
}

// set navigationBar backgroundImage
- (void)dm_setBackgroundImage:(UIImage *)image
{
    [self.backgroundView removeFromSuperview];
    self.backgroundView = nil;
    if (self.backgroundImageView == nil)
    {
        // add a image(nil color) to _UIBarBackground make it clear
        [self setBackgroundImage:[UIImage new] forBarMetrics:UIBarMetricsDefault];
        if (self.subviews.count > 0)
        {
            self.backgroundImageView = [[UIImageView alloc] initWithFrame:CGRectMake(0, 0, CGRectGetWidth(self.bounds), [XBTNavigationBar navBarBottom])];
            self.backgroundImageView.autoresizingMask = UIViewAutoresizingFlexibleWidth;
            
            // _UIBarBackground is first subView for navigationBar
            [self.subviews.firstObject insertSubview:self.backgroundImageView atIndex:0];
        }
    }
    self.backgroundImage = image;
    self.backgroundImageView.image = image;
}

// set navigationBar barTintColor
- (void)dm_setBackgroundColor:(UIColor *)color
{
    [self.backgroundImageView removeFromSuperview];
    self.backgroundImageView = nil;
    self.backgroundImage = nil;
    if (self.backgroundView == nil)
    {
        // add a image(nil color) to _UIBarBackground make it clear
        [self setBackgroundImage:[UIImage new] forBarMetrics:UIBarMetricsDefault];
        self.backgroundView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, CGRectGetWidth(self.bounds), [XBTNavigationBar navBarBottom])];
//        [self.backgroundView gradientColorTransverse:YES vertical:NO width:kScreenW]; // 此方法只为了添加渐变色
        self.backgroundView.autoresizingMask = UIViewAutoresizingFlexibleWidth;
        // _UIBarBackground is first subView for navigationBar
        [self.subviews.firstObject insertSubview:self.backgroundView atIndex:0];
    }
    self.backgroundView.backgroundColor = color;
}

// set _UIBarBackground alpha (_UIBarBackground subviews alpha <= _UIBarBackground alpha)
- (void)dm_setBackgroundAlpha:(CGFloat)alpha
{
    UIView *barBackgroundView = self.subviews.firstObject;
    if (@available(iOS 11.0, *))
    {   // sometimes we can't change _UIBarBackground alpha
        for (UIView *view in barBackgroundView.subviews) {
            view.alpha = alpha;
        }
    } else {
        barBackgroundView.alpha = alpha;
    }
}

- (void)dm_setBarButtonItemsAlpha:(CGFloat)alpha hasSystemBackIndicator:(BOOL)hasSystemBackIndicator
{
    for (UIView *view in self.subviews)
    {
        if (hasSystemBackIndicator == YES)
        {
            // _UIBarBackground/_UINavigationBarBackground对应的view是系统导航栏，不需要改变其透明度
            Class _UIBarBackgroundClass = NSClassFromString(@"_UIBarBackground");
            if (_UIBarBackgroundClass != nil)
            {
                if ([view isKindOfClass:_UIBarBackgroundClass] == NO) {
                    view.alpha = alpha;
                }
            }
            
            Class _UINavigationBarBackground = NSClassFromString(@"_UINavigationBarBackground");
            if (_UINavigationBarBackground != nil)
            {
                if ([view isKindOfClass:_UINavigationBarBackground] == NO) {
                    view.alpha = alpha;
                }
            }
        }
        else
        {
            // 这里如果不做判断的话，会显示 backIndicatorImage
            if ([view isKindOfClass:NSClassFromString(@"_UINavigationBarBackIndicatorView")] == NO)
            {
                Class _UIBarBackgroundClass = NSClassFromString(@"_UIBarBackground");
                if (_UIBarBackgroundClass != nil)
                {
                    if ([view isKindOfClass:_UIBarBackgroundClass] == NO) {
                        view.alpha = alpha;
                    }
                }
                
                Class _UINavigationBarBackground = NSClassFromString(@"_UINavigationBarBackground");
                if (_UINavigationBarBackground != nil)
                {
                    if ([view isKindOfClass:_UINavigationBarBackground] == NO) {
                        view.alpha = alpha;
                    }
                }
            }
        }
    }
}

// 设置导航栏在垂直方向上平移多少距离
- (void)dm_setTranslationY:(CGFloat)translationY {
    // CGAffineTransformMakeTranslation  平移
    self.transform = CGAffineTransformMakeTranslation(0, translationY);
}

/** 获取当前导航栏在垂直方向上偏移了多少 */
- (CGFloat)dm_getTranslationY {
    return self.transform.ty;
}

#pragma mark - call swizzling methods active 主动调用交换方法
+ (void)load
{
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^
                  {
                      SEL needSwizzleSelectors[1] = {
                          @selector(setTitleTextAttributes:)
                      };
                      
                      for (int i = 0; i < 1;  i++) {
                          SEL selector = needSwizzleSelectors[i];
                          NSString *newSelectorStr = [NSString stringWithFormat:@"dm_%@", NSStringFromSelector(selector)];
                          Method originMethod = class_getInstanceMethod(self, selector);
                          Method swizzledMethod = class_getInstanceMethod(self, NSSelectorFromString(newSelectorStr));
                          method_exchangeImplementations(originMethod, swizzledMethod);
                      }
                  });
}

- (void)dm_setTitleTextAttributes:(NSDictionary<NSString *,id> *)titleTextAttributes
{
    NSMutableDictionary<NSString *,id> *newTitleTextAttributes = [titleTextAttributes mutableCopy];
    if (newTitleTextAttributes == nil) {
        return;
    }
    
    NSDictionary<NSString *,id> *originTitleTextAttributes = self.titleTextAttributes;
    if (originTitleTextAttributes == nil) {
        [self dm_setTitleTextAttributes:newTitleTextAttributes];
        return;
    }
    
    __block UIColor *titleColor;
    [originTitleTextAttributes enumerateKeysAndObjectsUsingBlock:^(NSString * _Nonnull key, id  _Nonnull obj, BOOL * _Nonnull stop) {
        if ([key isEqual:NSForegroundColorAttributeName]) {
            titleColor = (UIColor *)obj;
            *stop = YES;
        }
    }];
    
    if (titleColor == nil) {
        [self dm_setTitleTextAttributes:newTitleTextAttributes];
        return;
    }
    
    if (newTitleTextAttributes[NSForegroundColorAttributeName] == nil) {
        newTitleTextAttributes[NSForegroundColorAttributeName] = titleColor;
    }
    [self dm_setTitleTextAttributes:newTitleTextAttributes];
}

@end

@interface UIViewController (Addition)
- (void)setPushToCurrentVCFinished:(BOOL)isFinished;
@end

//==========================================================================
#pragma mark - UINavigationController
//==========================================================================
@implementation UINavigationController (DMAddition)

static CGFloat dmPopDuration = 0.12;
static int dmPopDisplayCount = 0;
- (CGFloat)dmPopProgress
{
    CGFloat all = 60 * dmPopDuration;
    int current = MIN(all, dmPopDisplayCount);
    return current / all;
}

static CGFloat dmPushDuration = 0.10;
static int dmPushDisplayCount = 0;
- (CGFloat)dmPushProgress
{
    CGFloat all = 60 * dmPushDuration;
    int current = MIN(all, dmPushDisplayCount);
    return current / all;
}

- (UIStatusBarStyle)preferredStatusBarStyle {
    return [self.topViewController dm_statusBarStyle];
}

- (void)setNeedsNavigationBarUpdateForBarBackgroundImage:(UIImage *)backgroundImage {
    [self.navigationBar dm_setBackgroundImage:backgroundImage];
}
- (void)setNeedsNavigationBarUpdateForBarTintColor:(UIColor *)barTintColor {
    [self.navigationBar dm_setBackgroundColor:barTintColor];
}
- (void)setNeedsNavigationBarUpdateForBarBackgroundAlpha:(CGFloat)barBackgroundAlpha {
    [self.navigationBar dm_setBackgroundAlpha:barBackgroundAlpha];
}
- (void)setNeedsNavigationBarUpdateForTintColor:(UIColor *)tintColor {
    self.navigationBar.tintColor = tintColor;
}
- (void)setNeedsNavigationBarUpdateForShadowImageHidden:(BOOL)hidden {
    self.navigationBar.shadowImage = (hidden == YES) ? [UIImage new] : nil;
}
- (void)setNeedsNavigationBarUpdateForTitleColor:(UIColor *)titleColor
{
    NSDictionary *titleTextAttributes = [self.navigationBar titleTextAttributes];
    if (titleTextAttributes == nil) {
        self.navigationBar.titleTextAttributes = @{NSForegroundColorAttributeName:titleColor};
        return;
    }
    NSMutableDictionary *newTitleTextAttributes = [titleTextAttributes mutableCopy];
    newTitleTextAttributes[NSForegroundColorAttributeName] = titleColor;
    self.navigationBar.titleTextAttributes = newTitleTextAttributes;
}

- (void)updateNavigationBarWithFromVC:(UIViewController *)fromVC toVC:(UIViewController *)toVC progress:(CGFloat)progress
{
    // change navBarBarTintColor
    UIColor *fromBarTintColor = [fromVC dm_navBarBarTintColor];
    UIColor *toBarTintColor = [toVC dm_navBarBarTintColor];
    UIColor *newBarTintColor = [XBTNavigationBar middleColor:fromBarTintColor toColor:toBarTintColor percent:progress];
    [self setNeedsNavigationBarUpdateForBarTintColor:newBarTintColor];
    
    // change navBarTintColor
    UIColor *fromTintColor = [fromVC dm_navBarTintColor];
    UIColor *toTintColor = [toVC dm_navBarTintColor];
    UIColor *newTintColor = [XBTNavigationBar middleColor:fromTintColor toColor:toTintColor percent:progress];
    [self setNeedsNavigationBarUpdateForTintColor:newTintColor];
    
    // change navBarTitleColor（在dm_popToViewController:animated:方法中直接改变标题颜色）
    //    UIColor *fromTitleColor = [fromVC dm_navBarTitleColor];
    //    UIColor *toTitleColor = [toVC dm_navBarTitleColor];
    //    UIColor *newTitleColor = [XBTNavigationBar middleColor:fromTitleColor toColor:toTitleColor percent:progress];
    //    [self setNeedsNavigationBarUpdateForTitleColor:newTitleColor];
    
    // change navBar _UIBarBackground alpha
    CGFloat fromBarBackgroundAlpha = [fromVC dm_navBarBackgroundAlpha];
    CGFloat toBarBackgroundAlpha = [toVC dm_navBarBackgroundAlpha];
    CGFloat newBarBackgroundAlpha = [XBTNavigationBar middleAlpha:fromBarBackgroundAlpha toAlpha:toBarBackgroundAlpha percent:progress];
    [self setNeedsNavigationBarUpdateForBarBackgroundAlpha:newBarBackgroundAlpha];
}

#pragma mark - call swizzling methods active 主动调用交换方法
+ (void)load
{
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^
                  {
                      SEL needSwizzleSelectors[4] = {
                          NSSelectorFromString(@"_updateInteractiveTransition:"),
                          @selector(popToViewController:animated:),
                          @selector(popToRootViewControllerAnimated:),
                          @selector(pushViewController:animated:)
                      };
                      
                      for (int i = 0; i < 4;  i++) {
                          SEL selector = needSwizzleSelectors[i];
                          NSString *newSelectorStr = [[NSString stringWithFormat:@"dm_%@", NSStringFromSelector(selector)] stringByReplacingOccurrencesOfString:@"__" withString:@"_"];
                          Method originMethod = class_getInstanceMethod(self, selector);
                          Method swizzledMethod = class_getInstanceMethod(self, NSSelectorFromString(newSelectorStr));
                          method_exchangeImplementations(originMethod, swizzledMethod);
                      }
                  });
}

- (NSArray<UIViewController *> *)dm_popToViewController:(UIViewController *)viewController animated:(BOOL)animated
{   // pop 的时候导航栏标题颜色直接改变
    [self setNeedsNavigationBarUpdateForTitleColor:[viewController dm_navBarTitleColor]];
    __block CADisplayLink *displayLink = [CADisplayLink displayLinkWithTarget:self selector:@selector(popNeedDisplay)];
    [displayLink addToRunLoop:[NSRunLoop mainRunLoop] forMode:NSRunLoopCommonModes];
    [CATransaction setCompletionBlock:^{
        [displayLink invalidate];
        displayLink = nil;
        dmPopDisplayCount = 0;
    }];
    [CATransaction setAnimationDuration:dmPopDuration];
    [CATransaction begin];
    NSArray<UIViewController *> *vcs = [self dm_popToViewController:viewController animated:animated];
    [CATransaction commit];
    return vcs;
}

- (NSArray<UIViewController *> *)dm_popToRootViewControllerAnimated:(BOOL)animated
{
    __block CADisplayLink *displayLink = [CADisplayLink displayLinkWithTarget:self selector:@selector(popNeedDisplay)];
    [displayLink addToRunLoop:[NSRunLoop mainRunLoop] forMode:NSRunLoopCommonModes];
    [CATransaction setCompletionBlock:^{
        [displayLink invalidate];
        displayLink = nil;
        dmPopDisplayCount = 0;
    }];
    [CATransaction setAnimationDuration:dmPopDuration];
    [CATransaction begin];
    NSArray<UIViewController *> *vcs = [self dm_popToRootViewControllerAnimated:animated];
    [CATransaction commit];
    return vcs;
}

// change navigationBar barTintColor smooth before pop to current VC finished
- (void)popNeedDisplay
{
    if (self.topViewController != nil && self.topViewController.transitionCoordinator != nil)
    {
        dmPopDisplayCount += 1;
        CGFloat popProgress = [self dmPopProgress];
        UIViewController *fromVC = [self.topViewController.transitionCoordinator viewControllerForKey:UITransitionContextFromViewControllerKey];
        UIViewController *toVC = [self.topViewController.transitionCoordinator viewControllerForKey:UITransitionContextToViewControllerKey];
        [self updateNavigationBarWithFromVC:fromVC toVC:toVC progress:popProgress];
    }
}

- (void)dm_pushViewController:(UIViewController *)viewController animated:(BOOL)animated
{
    __block CADisplayLink *displayLink = [CADisplayLink displayLinkWithTarget:self selector:@selector(pushNeedDisplay)];
    [displayLink addToRunLoop:[NSRunLoop mainRunLoop] forMode:NSRunLoopCommonModes];
    [CATransaction setCompletionBlock:^{
        [displayLink invalidate];
        displayLink = nil;
        dmPushDisplayCount = 0;
        [viewController setPushToCurrentVCFinished:YES];
    }];
    [CATransaction setAnimationDuration:dmPushDuration];
    [CATransaction begin];
    [self dm_pushViewController:viewController animated:animated];
    [CATransaction commit];
}

// change navigationBar barTintColor smooth before push to current VC finished or before pop to current VC finished
- (void)pushNeedDisplay
{
    if (self.topViewController != nil && self.topViewController.transitionCoordinator != nil)
    {
        dmPushDisplayCount += 1;
        CGFloat pushProgress = [self dmPushProgress];
        UIViewController *fromVC = [self.topViewController.transitionCoordinator viewControllerForKey:UITransitionContextFromViewControllerKey];
        UIViewController *toVC = [self.topViewController.transitionCoordinator viewControllerForKey:UITransitionContextToViewControllerKey];
        [self updateNavigationBarWithFromVC:fromVC toVC:toVC progress:pushProgress];
    }
}

#pragma mark - deal the gesture of return
- (BOOL)navigationBar:(UINavigationBar *)navigationBar shouldPopItem:(UINavigationItem *)item
{
    __weak typeof (self) weakSelf = self;
    id<UIViewControllerTransitionCoordinator> coor = [self.topViewController transitionCoordinator];
    if ([coor initiallyInteractive] == YES)
    {
        NSString *sysVersion = [[UIDevice currentDevice] systemVersion];
        if ([sysVersion floatValue] >= 10)
        {
            [coor notifyWhenInteractionChangesUsingBlock:^(id<UIViewControllerTransitionCoordinatorContext>  _Nonnull context) {
                __strong typeof (self) pThis = weakSelf;
                [pThis dealInteractionChanges:context];
            }];
        }
        else
        {
            [coor notifyWhenInteractionEndsUsingBlock:^(id<UIViewControllerTransitionCoordinatorContext>  _Nonnull context) {
                __strong typeof (self) pThis = weakSelf;
                [pThis dealInteractionChanges:context];
            }];
        }
        return YES;
    }
    
    NSUInteger itemCount = self.navigationBar.items.count;
    NSUInteger n = self.viewControllers.count >= itemCount ? 2 : 1;
    UIViewController *popToVC = self.viewControllers[self.viewControllers.count - n];
    [self popToViewController:popToVC animated:YES];
    return YES;
}

// deal the gesture of return break off
- (void)dealInteractionChanges:(id<UIViewControllerTransitionCoordinatorContext>)context
{
    void (^animations) (UITransitionContextViewControllerKey) = ^(UITransitionContextViewControllerKey key){
        UIColor *curColor = [[context viewControllerForKey:key] dm_navBarBarTintColor];
        CGFloat curAlpha = [[context viewControllerForKey:key] dm_navBarBackgroundAlpha];
        [self setNeedsNavigationBarUpdateForBarTintColor:curColor];
        [self setNeedsNavigationBarUpdateForBarBackgroundAlpha:curAlpha];
    };
    
    // after that, cancel the gesture of return
    if ([context isCancelled] == YES)
    {
        double cancelDuration = [context transitionDuration] * [context percentComplete];
        [UIView animateWithDuration:cancelDuration animations:^{
            animations(UITransitionContextFromViewControllerKey);
        }];
    }
    else
    {
        // after that, finish the gesture of return
        double finishDuration = [context transitionDuration] * (1 - [context percentComplete]);
        [UIView animateWithDuration:finishDuration animations:^{
            animations(UITransitionContextToViewControllerKey);
        }];
    }
}

- (void)dm_updateInteractiveTransition:(CGFloat)percentComplete
{
    UIViewController *fromVC = [self.topViewController.transitionCoordinator viewControllerForKey:UITransitionContextFromViewControllerKey];
    UIViewController *toVC = [self.topViewController.transitionCoordinator viewControllerForKey:UITransitionContextToViewControllerKey];
    [self updateNavigationBarWithFromVC:fromVC toVC:toVC progress:percentComplete];
    
    [self dm_updateInteractiveTransition:percentComplete];
}

@end


//==========================================================================
#pragma mark - UIViewController
//==========================================================================
@implementation UIViewController (DMAddition)

static char kDMPushToCurrentVCFinishedKey;
static char kDMPushToNextVCFinishedKey;
static char kDMNavBarBackgroundImageKey;
static char kDMNavBarBarTintColorKey;
static char kDMNavBarBackgroundAlphaKey;
static char kDMNavBarTintColorKey;
static char kDMNavBarTitleColorKey;
static char kDMStatusBarStyleKey;
static char kDMNavBarShadowImageHiddenKey;
static char kDMCustomNavBarKey;

// navigationBar barTintColor can not change by currentVC before fromVC push to currentVC finished
- (BOOL)pushToCurrentVCFinished
{
    id isFinished = objc_getAssociatedObject(self, &kDMPushToCurrentVCFinishedKey);
    return (isFinished != nil) ? [isFinished boolValue] : NO;
}
- (void)setPushToCurrentVCFinished:(BOOL)isFinished {
    objc_setAssociatedObject(self, &kDMPushToCurrentVCFinishedKey, @(isFinished), OBJC_ASSOCIATION_RETAIN_NONATOMIC);
}

// navigationBar barTintColor can not change by currentVC when currentVC push to nextVC finished
- (BOOL)pushToNextVCFinished
{
    id isFinished = objc_getAssociatedObject(self, &kDMPushToNextVCFinishedKey);
    return (isFinished != nil) ? [isFinished boolValue] : NO;
}
- (void)setPushToNextVCFinished:(BOOL)isFinished
{
    objc_setAssociatedObject(self, &kDMPushToNextVCFinishedKey, @(isFinished), OBJC_ASSOCIATION_RETAIN_NONATOMIC);
}

// navigationBar backgroundImage
- (UIImage *)dm_navBarBackgroundImage
{
    UIImage *image = (UIImage *)objc_getAssociatedObject(self, &kDMNavBarBackgroundImageKey);
    image = (image == nil) ? [XBTNavigationBar defaultNavBarBackgroundImage] : image;
    return image;
}
- (void)dm_setNavBarBackgroundImage:(UIImage *)image
{
    if ([[self dm_customNavBar] isKindOfClass:[UINavigationBar class]])
    {
        //        UINavigationBar *navBar = (UINavigationBar *)[self dm_customNavBar];
        //        [navBar dm_setBackgroundImage:image];
    }
    else {
        objc_setAssociatedObject(self, &kDMNavBarBackgroundImageKey, image, OBJC_ASSOCIATION_RETAIN_NONATOMIC);
    }
}

// navigationBar barTintColor
- (UIColor *)dm_navBarBarTintColor
{
    UIColor *barTintColor = (UIColor *)objc_getAssociatedObject(self, &kDMNavBarBarTintColorKey);
    return (barTintColor != nil) ? barTintColor : [XBTNavigationBar defaultNavBarBarTintColor];
}
- (void)dm_setNavBarBarTintColor:(UIColor *)color
{
    objc_setAssociatedObject(self, &kDMNavBarBarTintColorKey, color, OBJC_ASSOCIATION_RETAIN_NONATOMIC);
    if ([[self dm_customNavBar] isKindOfClass:[UINavigationBar class]])
    {
        //        UINavigationBar *navBar = (UINavigationBar *)[self dm_customNavBar];
        //        [navBar dm_setBackgroundColor:color];
    }
    else
    {
        if (([self pushToCurrentVCFinished] == YES || [self isRootViewController] == YES) && [self pushToNextVCFinished] == NO) {
            [self.navigationController setNeedsNavigationBarUpdateForBarTintColor:color];
        }
    }
}

// navigationBar _UIBarBackground alpha
- (CGFloat)dm_navBarBackgroundAlpha
{
    id barBackgroundAlpha = objc_getAssociatedObject(self, &kDMNavBarBackgroundAlphaKey);
    return (barBackgroundAlpha != nil) ? [barBackgroundAlpha floatValue] : [XBTNavigationBar defaultNavBarBackgroundAlpha];
    
}
- (void)dm_setNavBarBackgroundAlpha:(CGFloat)alpha
{
    objc_setAssociatedObject(self, &kDMNavBarBackgroundAlphaKey, @(alpha), OBJC_ASSOCIATION_RETAIN_NONATOMIC);
    if ([[self dm_customNavBar] isKindOfClass:[UINavigationBar class]])
    {
        //        UINavigationBar *navBar = (UINavigationBar *)[self dm_customNavBar];
        //        [navBar dm_setBackgroundAlpha:alpha];
    }
    else
    {
        if (([self pushToCurrentVCFinished] == YES || [self isRootViewController] == YES) && [self pushToNextVCFinished] == NO) {
            [self.navigationController setNeedsNavigationBarUpdateForBarBackgroundAlpha:alpha];
        }
    }
}

// navigationBar tintColor
- (UIColor *)dm_navBarTintColor
{
    UIColor *tintColor = (UIColor *)objc_getAssociatedObject(self, &kDMNavBarTintColorKey);
    return (tintColor != nil) ? tintColor : [XBTNavigationBar defaultNavBarTintColor];
}
- (void)dm_setNavBarTintColor:(UIColor *)color
{
    objc_setAssociatedObject(self, &kDMNavBarTintColorKey, color, OBJC_ASSOCIATION_RETAIN_NONATOMIC);
    if ([[self dm_customNavBar] isKindOfClass:[UINavigationBar class]])
    {
        //        UINavigationBar *navBar = (UINavigationBar *)[self dm_customNavBar];
        //        navBar.tintColor = color;
    }
    else
    {
        if ([self pushToNextVCFinished] == NO) {
            [self.navigationController setNeedsNavigationBarUpdateForTintColor:color];
        }
    }
}

// navigationBartitleColor
- (UIColor *)dm_navBarTitleColor
{
    UIColor *titleColor = (UIColor *)objc_getAssociatedObject(self, &kDMNavBarTitleColorKey);
    return (titleColor != nil) ? titleColor : [XBTNavigationBar defaultNavBarTitleColor];
}
- (void)dm_setNavBarTitleColor:(UIColor *)color
{
    objc_setAssociatedObject(self, &kDMNavBarTitleColorKey, color, OBJC_ASSOCIATION_RETAIN_NONATOMIC);
    if ([[self dm_customNavBar] isKindOfClass:[UINavigationBar class]])
    {
        //        UINavigationBar *navBar = (UINavigationBar *)[self dm_customNavBar];
        //        navBar.titleTextAttributes = @{NSForegroundColorAttributeName:color};
    }
    else
    {
        if ([self pushToNextVCFinished] == NO) {
            [self.navigationController setNeedsNavigationBarUpdateForTitleColor:color];
        }
    }
}

// statusBarStyle
- (UIStatusBarStyle)dm_statusBarStyle
{
    id style = objc_getAssociatedObject(self, &kDMStatusBarStyleKey);
    return (style != nil) ? [style integerValue] : [XBTNavigationBar defaultStatusBarStyle];
}
- (void)dm_setStatusBarStyle:(UIStatusBarStyle)style
{
    objc_setAssociatedObject(self, &kDMStatusBarStyleKey, @(style), OBJC_ASSOCIATION_RETAIN_NONATOMIC);
    [self setNeedsStatusBarAppearanceUpdate];
}

// shadowImage
- (void)dm_setNavBarShadowImageHidden:(BOOL)hidden
{
    objc_setAssociatedObject(self, &kDMNavBarShadowImageHiddenKey, @(hidden), OBJC_ASSOCIATION_RETAIN_NONATOMIC);
    [self.navigationController setNeedsNavigationBarUpdateForShadowImageHidden:hidden];
    
}
- (BOOL)dm_navBarShadowImageHidden
{
    id hidden = objc_getAssociatedObject(self, &kDMNavBarShadowImageHiddenKey);
    return (hidden != nil) ? [hidden boolValue] : [XBTNavigationBar defaultNavBarShadowImageHidden];
}

// custom navigationBar
- (UIView *)dm_customNavBar
{
    UIView *navBar = objc_getAssociatedObject(self, &kDMCustomNavBarKey);
    return (navBar != nil) ? navBar : [UIView new];
}
- (void)dm_setCustomNavBar:(UINavigationBar *)navBar
{
    objc_setAssociatedObject(self, &kDMCustomNavBarKey, navBar, OBJC_ASSOCIATION_RETAIN_NONATOMIC);
}

+ (void)load
{
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^
                  {
                      SEL needSwizzleSelectors[3] = {
                          @selector(viewWillAppear:),
                          @selector(viewWillDisappear:),
                          @selector(viewDidAppear:)
                      };
                      
                      for (int i = 0; i < 3;  i++) {
                          SEL selector = needSwizzleSelectors[i];
                          NSString *newSelectorStr = [NSString stringWithFormat:@"dm_%@", NSStringFromSelector(selector)];
                          Method originMethod = class_getInstanceMethod(self, selector);
                          Method swizzledMethod = class_getInstanceMethod(self, NSSelectorFromString(newSelectorStr));
                          method_exchangeImplementations(originMethod, swizzledMethod);
                      }
                  });
}

- (void)dm_viewWillAppear:(BOOL)animated
{
    if ([self canUpdateNavigationBar] == YES)
    {
        [self setPushToNextVCFinished:NO];
        [self.navigationController setNeedsNavigationBarUpdateForTintColor:[self dm_navBarTintColor]];
        [self.navigationController setNeedsNavigationBarUpdateForTitleColor:[self dm_navBarTitleColor]];
    }
    [self dm_viewWillAppear:animated];
}

- (void)dm_viewWillDisappear:(BOOL)animated
{
    if ([self canUpdateNavigationBar] == YES) {
        [self setPushToNextVCFinished:YES];
    }
    [self dm_viewWillDisappear:animated];
}

- (void)dm_viewDidAppear:(BOOL)animated
{
    if ([self isRootViewController] == NO) {
        self.pushToCurrentVCFinished = YES;
    }
    if ([self canUpdateNavigationBar] == YES)
    {
        UIImage *barBgImage = [self dm_navBarBackgroundImage];
        if (barBgImage != nil) {
            [self.navigationController setNeedsNavigationBarUpdateForBarBackgroundImage:barBgImage];
        } else {
            [self.navigationController setNeedsNavigationBarUpdateForBarTintColor:[self dm_navBarBarTintColor]];
        }
        [self.navigationController setNeedsNavigationBarUpdateForBarBackgroundAlpha:[self dm_navBarBackgroundAlpha]];
        [self.navigationController setNeedsNavigationBarUpdateForTintColor:[self dm_navBarTintColor]];
        [self.navigationController setNeedsNavigationBarUpdateForTitleColor:[self dm_navBarTitleColor]];
        [self.navigationController setNeedsNavigationBarUpdateForShadowImageHidden:[self dm_navBarShadowImageHidden]];
    }
    [self dm_viewDidAppear:animated];
}

- (BOOL)canUpdateNavigationBar
{
    CGRect viewFrame = self.view.frame;
    CGRect maxFrame = [UIScreen mainScreen].bounds;
    CGRect middleFrame = CGRectMake(0, XBTNavigationBar.navBarBottom, XBTNavigationBar.screenWidth, XBTNavigationBar.screenHeight-XBTNavigationBar.navBarBottom);
    CGRect minFrame = CGRectMake(0, XBTNavigationBar.navBarBottom, XBTNavigationBar.screenWidth, XBTNavigationBar.screenHeight-XBTNavigationBar.navBarBottom-XBTNavigationBar.tabBarHeight);
    // 蝙蝠🦇 （灵机一动：视频通话问题？）
    BOOL isBat = CGRectEqualToRect(viewFrame, maxFrame) || CGRectEqualToRect(viewFrame, middleFrame) || CGRectEqualToRect(viewFrame, minFrame);
    if (self.navigationController && isBat) {
        return YES;
    } else {
        return NO;
    }
}

- (BOOL)isRootViewController
{
    UIViewController *rootViewController = self.navigationController.viewControllers.firstObject;
    if ([rootViewController isKindOfClass:[UITabBarController class]] == NO) {
        return rootViewController == self;
    } else {
        UITabBarController *tabBarController = (UITabBarController *)rootViewController;
        for (UIViewController *vc in tabBarController.viewControllers) {
            if (vc == self) {
                return YES;
            }
        }
        return NO;
    }
}

@end

