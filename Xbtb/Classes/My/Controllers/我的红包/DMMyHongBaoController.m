//
//  DMMyHongBaoController.m
//  CheBaoJinRong
//
//  Created by apple on 2018/5/16.
//  Copyright © 2018年 apple. All rights reserved.
//

#import "DMMyHongBaoController.h"
#import "DMLotOfViewScroller.h"
#import "XBTInvestmentController.h"

@interface DMMyHongBaoController ()

@end

@implementation DMMyHongBaoController

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
    DMLotOfViewScroller *scroller = [[DMLotOfViewScroller alloc]initWithFrame:CGRectMake(0, SafeAreaTopHeight, kScreenW, kScreenH - SafeAreaTopHeight - SafeAreaBottomHeight)];
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
