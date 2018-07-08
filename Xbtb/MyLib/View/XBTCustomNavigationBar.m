//
//  XBTCustomNavigationBar.m
//  XYG
//
//  Created by ltyj on 2017/12/20.
//  Copyright © 2017年 Mac. All rights reserved.
//

#import "XBTCustomNavigationBar.h"

#define kDMDefaultTitleSize 18
#define kDMDefaultTitleColor [UIColor blackColor]
#define kDMDefaultBackgroundColor [UIColor whiteColor]
#define kDMScreenWidth [UIScreen mainScreen].bounds.size.width

@implementation UIViewController (DMRoute)

- (void)dm_toLastViewController
{
    if (self.navigationController) {
        if (self.navigationController.viewControllers.count == 1) {
            if (self.presentingViewController) {
                [self dismissViewControllerAnimated:YES completion:nil];
            }
        } else {
            [self.navigationController popViewControllerAnimated:YES];
        }
    } else if(self.presentingViewController) {
        [self dismissViewControllerAnimated:YES completion:nil];
    }
}

+ (UIViewController*)dm_currentViewController
{
    UIViewController* rootViewController = [UIApplication sharedApplication].delegate.window.rootViewController;
    return [self dm_currentViewControllerFrom:rootViewController];
}

+ (UIViewController*)dm_currentViewControllerFrom:(UIViewController*)viewController
{
    if ([viewController isKindOfClass:[UINavigationController class]]) {
        UINavigationController* navigationController = (UINavigationController *)viewController;
        return [self dm_currentViewControllerFrom:navigationController.viewControllers.lastObject];
    }
    else if([viewController isKindOfClass:[UITabBarController class]]) {
        UITabBarController* tabBarController = (UITabBarController *)viewController;
        return [self dm_currentViewControllerFrom:tabBarController.selectedViewController];
    }
    else if (viewController.presentedViewController != nil) {
        return [self dm_currentViewControllerFrom:viewController.presentedViewController];
    }
    else {
        return viewController;
    }
}

@end


@interface XBTCustomNavigationBar ()

@property (nonatomic, strong) UILabel     *titleLable;
@property (nonatomic, strong) UIButton    *leftButton;
@property (nonatomic, strong) UIButton    *rightButton;
@property (nonatomic, strong) UIView      *bottomLine;
@property (nonatomic, strong) UIView      *backgroundView;
@property (nonatomic, strong) UIImageView *backgroundImageView;

@end


@implementation XBTCustomNavigationBar

+ (instancetype)CustomNavigationBar {
    XBTCustomNavigationBar *navigationBar = [[self alloc] initWithFrame:CGRectMake(0, 0, kDMScreenWidth, [XBTCustomNavigationBar navBarBottom])];
    return navigationBar;
}
- (instancetype)init {
    if (self = [super init]) {
        [self setupView];
    }
    return self;
}
- (instancetype)initWithFrame:(CGRect)frame {
    if (self = [super initWithFrame:frame]) {
        [self setupView];
    }
    return self;
}

-(void)setupView
{
    [self addSubview:self.backgroundView];
    [self addSubview:self.backgroundImageView];
    [self addSubview:self.leftButton];
    [self addSubview:self.titleLable];
    [self addSubview:self.rightButton];
    [self addSubview:self.bottomLine];
    [self updateFrame];
    self.backgroundColor = [UIColor clearColor];
    self.backgroundView.backgroundColor = kDMDefaultBackgroundColor;
}

// TODO:这边结合 DMCellView 会不会更好呢？
-(void)updateFrame
{
    NSInteger top = ([XBTCustomNavigationBar isIphoneX]) ? 44 : 20;
    NSInteger margin = 5;
    NSInteger buttonHeight = 44;
    NSInteger buttonWidth = 44;
    NSInteger titleLabelHeight = 44;
    NSInteger titleLabelWidth = 180;
    
    self.backgroundView.frame = self.bounds;
    self.backgroundImageView.frame = self.bounds;
    self.leftButton.frame = CGRectMake(margin, top, buttonWidth, buttonHeight);
    [self.leftButton setImageEdgeInsets:UIEdgeInsetsMake(0, -7, 0, 7)];
    self.rightButton.frame = CGRectMake(kDMScreenWidth - buttonWidth - margin, top, buttonWidth, buttonHeight);
    self.titleLable.frame = CGRectMake((kDMScreenWidth - titleLabelWidth) / 2, top, titleLabelWidth, titleLabelHeight);
    self.bottomLine.frame = CGRectMake(0, (CGFloat)(self.bounds.size.height-0.5), kDMScreenWidth, 0.5);
}

#pragma mark - 导航栏左右按钮事件
-(void)clickBack {
    if (self.onClickLeftButton) {
        self.onClickLeftButton();
    } else {
        UIViewController *currentVC = [UIViewController dm_currentViewController];
        [currentVC dm_toLastViewController];
    }
}
-(void)clickRight {
    if (self.onClickRightButton) {
        self.onClickRightButton();
    }
}

- (void)dm_setBottomLineHidden:(BOOL)hidden {
    self.bottomLine.hidden = hidden;
}

- (void)dm_setBackgroundAlpha:(CGFloat)alpha {
    self.backgroundView.alpha = alpha;
    self.backgroundImageView.alpha = alpha;
    self.bottomLine.alpha = alpha;
}

- (void)dm_setTintColor:(UIColor *)color {
    [self.leftButton setTitleColor:color forState:UIControlStateNormal];
    [self.rightButton setTitleColor:color forState:UIControlStateNormal];
    [self.titleLable setTextColor:color];
}

#pragma mark - 左右按钮
- (void)dm_setLeftButtonWithNormal:(UIImage *)normal highlighted:(UIImage *)highlighted title:(NSString *)title titleColor:(UIColor *)titleColor
{
    self.leftButton.hidden = NO;
    [self.leftButton setImage:normal forState:UIControlStateNormal];
    [self.leftButton setImage:highlighted forState:UIControlStateHighlighted];
    [self.leftButton setTitle:title forState:UIControlStateNormal];
    [self.leftButton setTitleColor:titleColor forState:UIControlStateNormal];
}
- (void)dm_setLeftButtonWithImage:(UIImage *)image title:(NSString *)title titleColor:(UIColor *)titleColor {
    [self dm_setLeftButtonWithNormal:image highlighted:image title:title titleColor:titleColor];
}
- (void)dm_setLeftButtonWithNormal:(UIImage *)normal highlighted:(UIImage *)highlighted {
    [self dm_setLeftButtonWithNormal:normal highlighted:highlighted title:nil titleColor:nil];
}
- (void)dm_setLeftButtonWithImage:(UIImage *)image {
    [self dm_setLeftButtonWithNormal:image highlighted:image title:nil titleColor:nil];
}
- (void)dm_setLeftButtonWithTitle:(NSString *)title titleColor:(UIColor *)titleColor {
    [self dm_setLeftButtonWithNormal:nil highlighted:nil title:title titleColor:titleColor];
}

- (void)dm_setRightButtonWithNormal:(UIImage *)normal highlighted:(UIImage *)highlighted title:(NSString *)title titleColor:(UIColor *)titleColor
{
    self.rightButton.hidden = NO;
    [self.rightButton setImage:normal forState:UIControlStateNormal];
    [self.rightButton setImage:highlighted forState:UIControlStateHighlighted];
    [self.rightButton setTitle:title forState:UIControlStateNormal];
    [self.rightButton setTitleColor:titleColor forState:UIControlStateNormal];
}
- (void)dm_setRightButtonWithImage:(UIImage *)image title:(NSString *)title titleColor:(UIColor *)titleColor {
    [self dm_setRightButtonWithNormal:image highlighted:image title:title titleColor:titleColor];
}
- (void)dm_setRightButtonWithNormal:(UIImage *)normal highlighted:(UIImage *)highlighted {
    [self dm_setRightButtonWithNormal:normal highlighted:highlighted title:nil titleColor:nil];
}
- (void)dm_setRightButtonWithImage:(UIImage *)image {
    [self dm_setRightButtonWithNormal:image highlighted:image title:nil titleColor:nil];
}
- (void)dm_setRightButtonWithTitle:(NSString *)title titleColor:(UIColor *)titleColor {
    [self dm_setRightButtonWithNormal:nil highlighted:nil title:title titleColor:titleColor];
}

- (void)dm_setRightButtonFrame:(CGRect)frame
{
    self.rightButton.frame = frame;
}

#pragma mark - setter
-(void)setTitle:(NSString *)title {
    _title = title;
    self.titleLable.hidden = NO;
    self.titleLable.text = _title;
}
- (void)setTitleLabelColor:(UIColor *)titleLabelColor {
    _titleLabelColor = titleLabelColor;
    self.titleLable.textColor = _titleLabelColor;
}
- (void)setTitleLabelFont:(UIFont *)titleLabelFont {
    _titleLabelFont = titleLabelFont;
    self.titleLable.font = _titleLabelFont;
}
-(void)setBarBackgroundColor:(UIColor *)barBackgroundColor {
    self.backgroundImageView.hidden = YES;
    _barBackgroundColor = barBackgroundColor;
    self.backgroundView.hidden = NO;
    self.backgroundView.backgroundColor = _barBackgroundColor;
}
- (void)setBarBackgroundImage:(UIImage *)barBackgroundImage {
    self.backgroundView.hidden = YES;
    _barBackgroundImage = barBackgroundImage;
    self.backgroundImageView.hidden = NO;
    self.backgroundImageView.image = _barBackgroundImage;
}

#pragma mark - getter
-(UIButton *)leftButton
{
    if (!_leftButton) {
        _leftButton = [[UIButton alloc] init];
        [_leftButton addTarget:self action:@selector(clickBack) forControlEvents:UIControlEventTouchUpInside];
        _leftButton.imageView.contentMode = UIViewContentModeCenter;
        _leftButton.hidden = YES;
    }
    return _leftButton;
}
-(UIButton *)rightButton {
    if (!_rightButton) {
        _rightButton = [[UIButton alloc] init];
        _rightButton.titleLabel.font = [UIFont systemFontOfSize:16.0f];
        [_rightButton addTarget:self action:@selector(clickRight) forControlEvents:UIControlEventTouchUpInside];
        _rightButton.imageView.contentMode = UIViewContentModeCenter;
        _rightButton.hidden = YES;
    }
    return _rightButton;
}
-(UILabel *)titleLable {
    if (!_titleLable) {
        _titleLable = [[UILabel alloc] init];
        _titleLable.textColor = kDMDefaultTitleColor;
        _titleLable.font = [UIFont systemFontOfSize:kDMDefaultTitleSize];
        _titleLable.textAlignment = NSTextAlignmentCenter;
        _titleLable.hidden = YES;
    }
    return _titleLable;
}
- (UIView *)bottomLine {
    if (!_bottomLine) {
        _bottomLine = [[UIView alloc] init];
        _bottomLine.backgroundColor = [UIColor colorWithRed:(CGFloat)(218.0/255.0) green:(CGFloat)(218.0/255.0) blue:(CGFloat)(218.0/255.0) alpha:1.0];
    }
    return _bottomLine;
}
- (UIView *)backgroundView {
    if (!_backgroundView) {
        _backgroundView = [[UIView alloc] init];
    }
    return _backgroundView;
}
-(UIImageView *)backgroundImageView {
    if (!_backgroundImageView) {
        _backgroundImageView = [[UIImageView alloc] init];
        _backgroundImageView.hidden = YES;
    }
    return _backgroundImageView;
}

+ (int)navBarBottom
{
    if ([XBTCustomNavigationBar isIphoneX]) {
        return 88;
    } else {
        return 64;
    }
}
+ (BOOL)isIphoneX
{
    if (CGRectEqualToRect([UIScreen mainScreen].bounds,CGRectMake(0, 0, 375, 812))) {
        return YES;
    } else {
        return NO;
    }
}

@end




