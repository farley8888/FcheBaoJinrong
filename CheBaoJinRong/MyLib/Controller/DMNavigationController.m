//
//  DMNavigationController.m
//  ZCWL
//
//  Created by ios-dev on 16/2/29.
//  Copyright © 2016年 com.zcwljs.cnge.app. All rights reserved.
//

#import "DMNavigationController.h"
#import "UIImage+DM.h"
#import "DMNavigationBar.h"

@interface DMNavigationController ()

@end

@implementation DMNavigationController

- (void)viewDidLoad
{
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor whiteColor];
//    [self setupNavigation];
    [self setNavBarAppearence];
}

//- (void)setupNavigation
//{
////    [self.navigationBar setBackgroundImage:[UIImage imageWithColor:[kMenuColor colorWithAlphaComponent:1]] forBarMetrics:UIBarMetricsDefault];
////    [self.navigationBar setShadowImage:[UIImage new]];
//
////    [self.navigationBar setBarTintColor:[UIColor whiteColor]];
//    [self.navigationBar setTintColor:[UIColor blackColor]];
//    self.navigationBar.titleTextAttributes = @{NSForegroundColorAttributeName: [UIColor blackColor]};
//}

/**
 *  设置UINavigationBarTheme的主题
 */
- (void)setNavBarAppearence
{
    [self.navigationBar setTranslucent:NO];
    
    // 设置导航栏默认的背景颜色
    [DMNavigationBar dm_setDefaultNavBarBarTintColor:[UIColor whiteColor]];
    // 设置导航栏所有按钮的默认颜色
    [DMNavigationBar dm_setDefaultNavBarTintColor:[UIColor blackColor]];
    // 设置导航栏标题默认颜色
    [DMNavigationBar dm_setDefaultNavBarTitleColor:[UIColor blackColor]];
    // 统一设置状态栏样式
    [DMNavigationBar dm_setDefaultStatusBarStyle:UIStatusBarStyleDefault];
    // 如果需要设置导航栏底部分割线隐藏，可以在这里统一设置
    [DMNavigationBar dm_setDefaultNavBarShadowImageHidden:NO];
}

- (void)pushViewController:(UIViewController *)viewController animated:(BOOL)animated
{
    
    viewController.navigationItem.backBarButtonItem = [[UIBarButtonItem alloc] initWithTitle:@"" style:UIBarButtonItemStylePlain target:nil action:nil];
    
    if (!self.viewControllers.count) {
        
    } else {
        viewController.hidesBottomBarWhenPushed = YES;
        
    }
    [super pushViewController:viewController animated:animated];
    // 修改tabBar的frame
    CGRect frame = self.tabBarController.tabBar.frame;
    frame.origin.y = [UIScreen mainScreen].bounds.size.height - frame.size.height;
    self.tabBarController.tabBar.frame = frame;
}

- (void)setViewControllers:(NSArray<UIViewController *> *)viewControllers animated:(BOOL)animated
{
    if (viewControllers.count>1) {

        [viewControllers enumerateObjectsUsingBlock:^(UIViewController * _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
            if (idx) {
                obj.hidesBottomBarWhenPushed = YES;
            }
        }];
    }
    [super setViewControllers:viewControllers animated:animated];
}


@end
