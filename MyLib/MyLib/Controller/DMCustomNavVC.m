//
//  DMCustomNavVC.m
//  XYG
//
//  Created by ltyj on 2017/12/20.
//  Copyright © 2017年 Mac. All rights reserved.
//

#import "DMCustomNavVC.h"

@interface DMCustomNavVC ()

@end

@implementation DMCustomNavVC

- (UIStatusBarStyle )preferredStatusBarStyle
{
    return UIStatusBarStyleDefault;
}

- (DMCustomNavigationBar *)customNavBar
{
    if (_customNavBar == nil) {
        WeakSelf
        _customNavBar = [DMCustomNavigationBar CustomNavigationBar];
        [_customNavBar setOnClickLeftButton:^{
            [weakSelf leftButtonClick];
        }];
        [_customNavBar setOnClickRightButton:^{
            [weakSelf rightButtonClick];
        }];
    }
    return _customNavBar;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self.navigationController.navigationBar setBarStyle:UIBarStyleBlack];
    self.navigationController.navigationBar.hidden = YES;
    self.automaticallyAdjustsScrollViewInsets = NO;
    [self setupNavBar];
}
- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    self.navigationController.navigationBar.hidden = YES;
    
}

- (void)setupNavBar
{
    [self.view addSubview:self.customNavBar];
    
    // 设置自定义导航栏背景图片
    self.customNavBar.barBackgroundImage = nil;
    self.customNavBar.barBackgroundColor = KColorFromRGB(0xf9f9f9);
    // 设置自定义导航栏标题颜色
    self.customNavBar.titleLabelColor = [UIColor blackColor];
    if (self.navigationController.childViewControllers.count > 1) {
        [self.customNavBar dm_setLeftButtonWithImage:[UIImage imageNamed:@"fh"]];
    }
}


- (void)leftButtonClick
{
    [self.navigationController popViewControllerAnimated:YES];
}

- (void)rightButtonClick
{
    
}

@end
