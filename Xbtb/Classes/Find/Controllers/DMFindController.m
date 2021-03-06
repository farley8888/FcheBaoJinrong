//
//  DMFindController.m
//  CheBaoJinRong
//
//  Created by apple on 2018/5/14.
//  Copyright © 2018年 apple. All rights reserved.
//

#import "DMFindController.h"
#import "DMTopButtonView.h"
#import "DMLeftView.h"

@interface DMFindController ()<UIScrollViewDelegate>

@property(nonatomic, strong)UIScrollView *scrollerView;
@property(nonatomic, strong)DMTopButtonView *topButtonView;

@end

@implementation DMFindController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self setUpUI];
    [self setScrollerView];
    [self skipToPageForType:0];
}

- (void)setUpUI
{
    DMLog(@"屏幕高度%.2f",kScreenH);
    DMTopButtonView *topView = [[DMTopButtonView alloc]initWithFrame:CGRectMake(0, 0, kScreenW, 50)];
    self.topButtonView = topView;
//    topView.backgroundColor = [UIColor blackColor];
    WeakSelf
    [topView setButtonClick:^(NSInteger index) {
        [weakSelf skipToPageForType:index];
    }];
    [self.view addSubview:topView];
    
}

- (void)setScrollerView
{
    UIScrollView *scrollerView = [[UIScrollView alloc]initWithFrame:CGRectMake(0, CGRectGetMaxY(self.topButtonView.frame), kScreenW, kScreenH - 50 - SafeAreaTopHeight - SafeAreaBottomHeight - Tabbar_H)];
    scrollerView.delegate =self;
    scrollerView.bounces = NO;
    scrollerView.showsHorizontalScrollIndicator = NO;
    scrollerView.pagingEnabled = YES;
    scrollerView.backgroundColor = [UIColor yellowColor];
    
    [scrollerView setContentSize:CGSizeMake(2 * kScreenW, 0)];
    self.scrollerView = scrollerView;
    [self.view addSubview:scrollerView];
    
    DMLeftView *left = [[DMLeftView alloc]initWithFrame:CGRectMake(0, 0, kScreenW, CGRectGetHeight(self.scrollerView.frame))];
    left.type = OnGing;
    left.tag = 2000;
    [scrollerView addSubview:left];
    
    DMLeftView *right = [[DMLeftView alloc]initWithFrame:CGRectMake(kScreenW, 0, kScreenW, CGRectGetHeight(self.scrollerView.frame))];
    right.type = Finish;
    right.tag = 2001;
    [scrollerView addSubview:right];
}


- (void)scrollerView:(NSInteger)tag
{
    [self.scrollerView setContentOffset:CGPointMake(tag * kScreenW, 0) animated:YES];
    //    NSInteger index = (self.scroller.contentOffset.x+ self.scroller.width/2)/self.scroller.width;
    [self skipToPageForType:tag];
}

- (void)scrollViewDidEndDecelerating:(UIScrollView *)scrollView
{
    NSInteger index = (scrollView.contentOffset.x+scrollView.width/2)/scrollView.width;
    self.topButtonView.selectIndex = index;
    [self scrolleAndLoadData:index];
}

- (void)scrolleAndLoadData:(NSInteger)tag
{
    __kindof DMLeftView *vc = [self.scrollerView viewWithTag:tag + 2000];
    if (!vc.isLoadData) {
        [vc loadData];
    }
}

//根据type跳到相应的页面
- (void)skipToPageForType:(NSInteger )type
{
    [self.scrollerView setContentOffset:CGPointMake(type*self.scrollerView.width, 0) animated:YES];
    
    [self scrolleAndLoadData:type];
}



@end
