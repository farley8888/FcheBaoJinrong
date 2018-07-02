//
//  DMMainController.m
//  CheBaoJinRong
//
//  Created by ltyj on 2017/12/7.
//  Copyright © 2017年 ltyj. All rights reserved.
//

#import "DMMainController.h"
#import "DMNavigationController.h"
#import "HomePageController.h"      //首页
#import "DMInvestmentController.h"  //出借
#import "DMFindController.h"        //发现
//#import "MyController.h"            //我的
#import "DMMyControllerCollection.h"

@interface DMMainController ()<UITabBarControllerDelegate>

@end

@implementation DMMainController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.delegate = self;
    [self addChildViewControllers];
}

//添加子控制器
- (void)addChildViewControllers
{
    HomePageController *homeVC = [HomePageController new];
    [self addOneChlildVc:homeVC title:@"首页" imageName:@"shouye" selectedImageName:@"shouye(dianji)"];

    DMInvestmentController *investmentVC = [DMInvestmentController new];
    [self addOneChlildVc:investmentVC title:@"出借" imageName:@"touzi" selectedImageName:@"touzi(xuanze)"];

    DMFindController *findVC = [DMFindController new];
    [self addOneChlildVc:findVC title:@"发现" imageName:@"faxian" selectedImageName:@"faxian(xuanze)"];
    
    DMMyControllerCollection *myVC =[DMMyControllerCollection new];
    [self addOneChlildVc:myVC title:@"我的" imageName:@"wode" selectedImageName:@"wode(xuanze)"];
}


- (void)addOneChlildVc:(UIViewController *)childVc title:(NSString *)title imageName:(NSString *)imageName selectedImageName:(NSString *)selectedImageName
{
    // 设置标题
    childVc.title = title;
    
    // 设置图标
    childVc.tabBarItem.image = [[UIImage imageNamed:imageName] imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal];
    // 设置tabBarItem的普通文字颜色
    NSMutableDictionary *textAttrs = [NSMutableDictionary dictionary];
    //    textAttrs[UITextAttributeTextColor] = kGrayColor;
    textAttrs[UITextAttributeFont] = [UIFont systemFontOfSize:10];
    [childVc.tabBarItem setTitleTextAttributes:textAttrs forState:UIControlStateNormal];
    
    // 设置tabBarItem的选中文字颜色
    NSMutableDictionary *selectedTextAttrs = [NSMutableDictionary dictionary];
    selectedTextAttrs[UITextAttributeTextColor] = kMenuColor;
    [childVc.tabBarItem setTitleTextAttributes:selectedTextAttrs forState:UIControlStateSelected];
    
    // 设置选中的图标
    UIImage *selectedImage = [[UIImage imageNamed:selectedImageName] imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal];
    childVc.tabBarItem.selectedImage = selectedImage;
    
    // 添加为tabbar控制器的子控制器
    DMNavigationController *nav = [[DMNavigationController alloc] init];
    [nav pushViewController:childVc animated:NO];
    [self addChildViewController:nav];
}

@end
