//
//  DMMyDidiRecordController.m
//  CheBaoJinRong
//
//  Created by apple on 2018/6/1.
//  Copyright © 2018年 apple. All rights reserved.
//

#import "XBTMyDidiRecordController.h"
#import "DMLotOfViewScrollerTopView.h"
#import "DMRecordChildController.h"

@interface XBTMyDidiRecordController ()<UIScrollViewDelegate>

@property (nonatomic, strong) UIScrollView *scroller;
@property (nonatomic, strong) DMLotOfViewScrollerTopView *topView;
@property (nonatomic, strong) DMRecordChildController *recordVC;

@end

@implementation XBTMyDidiRecordController

- (UIScrollView *)scroller
{
    if (_scroller == nil) {
        _scroller = [[UIScrollView alloc]initWithFrame:CGRectMake(0, CGRectGetMaxY(self.topView.frame), kScreenW, kScreenH -60)];
        _scroller.showsVerticalScrollIndicator = NO;
        _scroller.showsHorizontalScrollIndicator = NO;
        _scroller.pagingEnabled = YES;
        _scroller.delegate = self;
        _scroller.contentSize = CGSizeMake(kScreenW * 2, 0);
    }
    return _scroller;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    [self setTopView];
    [self setController];
    [self skipToPageForType:0];
}

- (void)setTopView
{
    self.navigationItem.title = @"记录";
    self.view.backgroundColor = [UIColor whiteColor];
    DMLotOfViewScrollerTopView *topView = [[DMLotOfViewScrollerTopView alloc]initWithFrame:CGRectMake(0, SafeAreaTopHeight, kScreenW  , 60)];
    topView.titleArr = @[@"存入",@"赎回"];
    WeakSelf
    [topView setButtonClickBlock:^(NSInteger tag) {
        [weakSelf scrollerView:tag];
    }];
    self.topView = topView;
    [self.view addSubview:topView];
}

- (void)setController
{
    [self.view addSubview: self.scroller];
    DMRecordChildController *recVC = [DMRecordChildController new];
    recVC.type = 1; 
    [self addChildViewController:recVC];
    [self.scroller  addSubview:recVC.view];
    recVC.view.frame = CGRectMake(0, 0, kScreenW, self.scroller.height);
    
    DMRecordChildController *recVC2 = [DMRecordChildController new];
    recVC2.type = 2; 
    [self addChildViewController:recVC2];
    [self.scroller addSubview:recVC2.view];
    recVC2.view.frame = CGRectMake(kScreenW, 0, kScreenW, self.scroller.height);
}

- (void)scrollerView:(NSInteger)tag
{
    [self.scroller setContentOffset:CGPointMake(tag * kScreenW, 0) animated:YES];
    [self skipToPageForType:tag];
}

- (void)scrollViewDidEndDecelerating:(UIScrollView *)scrollView
{
    NSInteger index = (scrollView.contentOffset.x+scrollView.width/2)/scrollView.width;
    self.topView.selectIndex = index;
    [self scrolleAndLoadData:index];
}

- (void)scrolleAndLoadData:(NSInteger)tag
{
    __kindof DMRecordChildController *vc = self.childViewControllers[tag];
    if (!vc.isLoadData) {
        [vc loadData];
    }
}

//根据type跳到相应的页面
- (void)skipToPageForType:(NSInteger )type
{
    [self.scroller setContentOffset:CGPointMake(type*self.scroller.width, 0) animated:YES];
    
    [self scrolleAndLoadData:type];
}

@end
