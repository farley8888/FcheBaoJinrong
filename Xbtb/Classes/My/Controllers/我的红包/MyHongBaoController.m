//
//  MyHongBaoController.m
//  CheBaoJinRong
//
//  Created by apple on 2018/5/16.
//  Copyright © 2018年 apple. All rights reserved.
//

#import "MyHongBaoController.h"
#import "XBTLotOfViewScroller.h"
#import "XBTInvestmentController.h"

@interface MyHongBaoController ()

@end

@implementation MyHongBaoController

-(void)dealloc
{
    [kNotificationCenter removeObserver:self];
}

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self setScrollerViews];
}

- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    [self.navigationController.navigationBar setTranslucent:YES];
}

- (void)setScrollerViews
{
    self.navigationItem.title = @"我的红包";
    self.view.backgroundColor = [UIColor whiteColor];
    XBTLotOfViewScroller *scroller = [[XBTLotOfViewScroller alloc]initWithFrame:CGRectMake(0, SafeAreaTopHeight, kScreenW, kScreenH - SafeAreaTopHeight - SafeAreaBottomHeight)];
    scroller.titileArray = @[@"未使用",@"已使用",@"已过期"];
    [scroller skipToPageForType:0];
    [self.view addSubview:scroller];
    [kNotificationCenter addObserver:self selector:@selector(nowUse) name:kNowUse object:nil];
}

- (void)nowUse
{
    XBTInvestmentController *itVC = [XBTInvestmentController new];
    itVC.isHongbaoJoin = 1;
    [self.navigationController pushViewController:itVC animated:YES];
}
@end
