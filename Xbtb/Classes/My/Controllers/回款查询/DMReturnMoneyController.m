//
//  DMReturnMoneyController.m
//  CheBaoJinRong
//
//  Created by apple on 2018/5/15.
//  Copyright © 2018年 apple. All rights reserved.
//

#import "DMReturnMoneyController.h"
#import "XBTReturnMoneyTopView.h"
#import "XBTButtonSelectView.h"
#import "XBTSubstitutePaymentView.h"

@interface DMReturnMoneyController ()<UIScrollViewDelegate>

@property(nonatomic,strong)UIScrollView *scrollerView;
@property(nonatomic,strong)XBTButtonSelectView *buttonSelectView;
//@property (nonatomic, strong) DMSubstitutePaymentView *leftView;
//@property (nonatomic, strong) DMSubstitutePaymentView *rightView;

@end

@implementation DMReturnMoneyController

-(void)dealloc
{
    DMLog(@"%s",__func__);
}

- (void)viewDidLoad {
    [super viewDidLoad];
    [self setUI];
    [self setScrollerView];
}

- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    [self skipToPageForType:0];
}

- (void)setUI
{
    self.view.backgroundColor = [UIColor groupTableViewBackgroundColor];
    self.navigationItem.title = @"回款查询";
    XBTReturnMoneyTopView *topView = [[XBTReturnMoneyTopView alloc]initWithFrame:CGRectMake(0, SafeAreaTopHeight, kScreenW, 60)];
    [self.view addSubview:topView];
    
    XBTButtonSelectView *buttonSelect = [XBTButtonSelectView buttonselectView];
    self.buttonSelectView = buttonSelect;
    buttonSelect.frame = CGRectMake(0, SafeAreaTopHeight+60+15, kScreenW, 60);
    WeakSelf
    [buttonSelect setButtonClick:^(NSInteger tag) {
        [weakSelf scrollerContentOffset:tag];
    }];
    [self.view addSubview:buttonSelect];
}

- (void)setScrollerView
{
    UIScrollView *scrollerView = [[UIScrollView alloc]initWithFrame:CGRectMake(0, SafeAreaTopHeight + 120 + 15, kScreenW, kScreenH - SafeAreaTopHeight - 120 - 15 - SafeAreaBottomHeight)];
    scrollerView.delegate = self;
    scrollerView.bounces = NO;
    scrollerView.showsHorizontalScrollIndicator = NO;
    scrollerView.pagingEnabled = YES;
    scrollerView.backgroundColor = [UIColor yellowColor];
    
    [scrollerView setContentSize:CGSizeMake(2 * kScreenW, 0)];
    self.scrollerView = scrollerView;
    [self.view addSubview:scrollerView];
    
    XBTSubstitutePaymentView *left = [[XBTSubstitutePaymentView alloc]initWithFrame:CGRectMake(0, 0, kScreenW, kScreenH - SafeAreaTopHeight - 120 - 15 - SafeAreaBottomHeight)];
    left.type = 1;
    left.tag = 1600;
    [scrollerView addSubview:left];
    
    XBTSubstitutePaymentView *right = [[XBTSubstitutePaymentView alloc]initWithFrame:CGRectMake(kScreenW, 0, kScreenW, kScreenH - SafeAreaTopHeight - 120 - 15 - SafeAreaBottomHeight)];
    right.type = 2;
    right.tag = 1601;
    [scrollerView addSubview:right];
    
}

- (void)scrollerContentOffset:(NSInteger)tag
{
    [self.scrollerView setContentOffset:CGPointMake(tag * kScreenW, 0) animated:YES];
    [self skipToPageForType:tag];
}

- (void)scrollViewDidScroll:(UIScrollView *)scrollView
{
    DMLog(@"----%.2f",scrollView.contentOffset.x);
}

- (void)scrollViewDidEndDecelerating:(UIScrollView *)scrollView
{
    NSInteger index = (scrollView.contentOffset.x+scrollView.width/2)/scrollView.width;
    self.buttonSelectView.selectIndex = index;
    
    XBTSubstitutePaymentView *tabView = [self.scrollerView viewWithTag:1600 + index];
    if (!tabView.isLoadData) {
        [tabView loadData];
    }
}

//根据type跳到相应的页面
- (void)skipToPageForType:(NSInteger )type
{
    [self.scrollerView setContentOffset:CGPointMake(type*self.scrollerView.width, 0) animated:YES];
    
    XBTSubstitutePaymentView *tabView = [self.scrollerView viewWithTag:1600 + type];
    if (!tabView.isLoadData) {
        [tabView loadData];
    }

}


@end
