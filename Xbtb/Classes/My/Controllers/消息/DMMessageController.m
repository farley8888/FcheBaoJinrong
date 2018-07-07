//
//  DMMessageController.m
//  CheBaoJinRong
//
//  Created by apple on 2018/5/29.
//  Copyright © 2018年 apple. All rights reserved.
//

#import "DMMessageController.h"
#import "DMLotOfViewScrollerTopView.h"
#import "XBTMessageChildController.h"

@interface DMMessageController ()<UIScrollViewDelegate>

@property (nonatomic, strong) UIScrollView *scroller;
@property (nonatomic, strong) DMLotOfViewScrollerTopView *topView;

@end

@implementation DMMessageController

- (UIScrollView *)scroller
{
    if (_scroller == nil) {
        _scroller = [[UIScrollView alloc]initWithFrame:CGRectMake(0, 60 + SafeAreaTopHeight, kScreenW, kScreenH -60 - SafeAreaTopHeight - SafeAreaBottomHeight)];
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
    
    [self setTopViews];
    [self setController];
    [self skipToPageForType:0];
}

- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    if (self.type == 2) {
        [self.navigationController.navigationBar setTranslucent:YES];
    }
}

- (void)viewWillDisappear:(BOOL)animated
{
    [super viewWillDisappear:animated];
    if (self.type == 2) {
        [self.navigationController.navigationBar setTranslucent:NO];
    }
}

- (void)setController
{
    [self.view addSubview: self.scroller];
    NSArray *urlArr = @[@"noticeList",@"consultationPageApp"];
    for (int i = 0; i < 2; i++) {
        
        XBTMessageChildController *mcVC = [XBTMessageChildController new];
        mcVC.url = urlArr[i];
        mcVC.type = i+1;
        [self addChildViewController:mcVC];
        mcVC.view.frame = CGRectMake(i*kScreenW, 0, kScreenW, self.scroller.height);
        [self.scroller addSubview:mcVC.view];
    }
}

- (void)setTopViews
{
    self.navigationItem.title = @"消息";
    self.view.backgroundColor = [UIColor whiteColor];
    DMLotOfViewScrollerTopView *topView = [[DMLotOfViewScrollerTopView alloc]initWithFrame:CGRectMake(0, SafeAreaTopHeight, kScreenW  , 60)];
    topView.titleArr = @[@"平台公告",@"媒体报道"];
    WeakSelf
    [topView setButtonClickBlock:^(NSInteger tag) {
        [weakSelf scrollerView:tag];
    }];
    self.topView = topView;
    [self.view addSubview:topView];
}

- (void)scrollerView:(NSInteger)tag
{
    [self.scroller setContentOffset:CGPointMake(tag * kScreenW, 0) animated:YES];
    //    NSInteger index = (self.scroller.contentOffset.x+ self.scroller.width/2)/self.scroller.width;
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
    __kindof XBTMessageChildController *vc = self.childViewControllers[tag];
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
