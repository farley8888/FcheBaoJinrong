//
//  DMLotOfViewScroller.m
//  CheBaoJinRong
//
//  Created by apple on 2018/5/16.
//  Copyright © 2018年 apple. All rights reserved.
//

#import "DMLotOfViewScroller.h"
#import "DMLotOfViewScrollerTopView.h"
#import "DMLotOfViewTableView.h"

@interface DMLotOfViewScroller ()<UIScrollViewDelegate>

@property (nonatomic, strong) UIScrollView *scrollerView;
@property (nonatomic, strong) DMLotOfViewScrollerTopView *topView;

@end

@implementation DMLotOfViewScroller

-(instancetype)initWithFrame:(CGRect)frame
{
    self= [super initWithFrame:frame];
    if (self) {
        [self setScrollerView];
        
    }
    return self;
}

- (void)setTitileArray:(NSArray *)titileArray
{
    _titileArray = titileArray;
//     DMLog(@"set数组个数%ld",titileArray.count);
    self.topView.titleArr = self.titileArray;
    self.scrollerView.contentSize = CGSizeMake(self.titileArray.count * self.width,0);
    
    [self setTableView];
}

- (void)setScrollerView
{
    DMLotOfViewScrollerTopView *topView = [[DMLotOfViewScrollerTopView alloc]initWithFrame:CGRectMake(0, 0, self.width, 60)];
    WeakSelf
    [topView setButtonClickBlock:^(NSInteger tag) {
        [weakSelf scrollerView:tag];
    }];
    self.topView = topView;
    [self addSubview:topView];
    
    UIScrollView *scrollerView = [[UIScrollView alloc]initWithFrame:CGRectMake(0, CGRectGetMaxY(topView.frame), self.width, self.height - topView.height)];
    self.scrollerView = scrollerView;
    scrollerView.delegate = self;
    scrollerView.pagingEnabled = YES;
    scrollerView.showsHorizontalScrollIndicator = NO;
    scrollerView.alwaysBounceVertical = NO;
    [self addSubview:scrollerView];
}

- (void)setTableView
{
    for (int i = 0; i < self.titileArray.count; i++) {
        DMLotOfViewTableView *tabView = [[DMLotOfViewTableView alloc]initWithFrame:CGRectMake(i*self.width, 0, self.width, self.scrollerView.height)];
        tabView.tag = 1500+i;
        tabView.type = i+1;
        [self.scrollerView addSubview:tabView];
    }
}

- (void)scrollerView:(NSInteger)tag
{
    [self.scrollerView setContentOffset:CGPointMake(tag * self.width, 0) animated:YES];
//    NSInteger index = (self.scrollerView.contentOffset.x+ self.scrollerView.width/2)/self.scrollerView.width;
    [self skipToPageForType:tag];
}

- (void)scrollViewDidEndDecelerating:(UIScrollView *)scrollView
{
    NSInteger index = (scrollView.contentOffset.x+scrollView.width/2)/scrollView.width;
    self.topView.selectIndex = index;
    
    DMLotOfViewTableView *tabView = [self viewWithTag:1500 + index];
    if (!tabView.isLoadData) {
        [tabView loadData];
    }
}


//根据type跳到相应的页面
- (void)skipToPageForType:(NSInteger )type
{
    [self.scrollerView setContentOffset:CGPointMake(type*self.scrollerView.width, 0) animated:YES];
    
    DMLotOfViewTableView *tabView = [self viewWithTag:1500 + type];
    if (!tabView.isLoadData) {
        [tabView loadData];
    }
}


@end
