//
//  DMHomeHeardView.m
//  CheBaoJinRong
//
//  Created by ltyj on 2017/12/7.
//  Copyright © 2017年 ltyj. All rights reserved.
//

#import "DMHomeHeardView.h"
#import "HomeButton.h"
#import "NewPagedFlowView.h"
#import "PGIndexBannerSubiew.h"
#import "UIImageView+SD.h"
#import "DMLoopView.h"
#import "DMMessageController.h"

#define kBanner_H (kScreenW - 30) / (670.0/330.0)

@interface DMHomeHeardView()<NewPagedFlowViewDelegate, NewPagedFlowViewDataSource>


/**
 *  指示label
 */
@property (nonatomic, strong) UILabel *indicateLabel;
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *topBanner_H;
/**  搭载四个按钮和loopView的背景view  **/
@property (weak, nonatomic) IBOutlet UIView *rdView;
@property (weak, nonatomic) IBOutlet DMLoopView *loopView;
@property (weak, nonatomic) IBOutlet UIButton *moreButton;

/**
 *  轮播图
 */
@property (nonatomic, strong) NewPagedFlowView *pageFlowView;
@end



@implementation DMHomeHeardView

- (void)dealloc {
    
    /****************************
     在dealloc或者返回按钮里停止定时器
     ****************************/
    DMLog(@"%s",__func__);
    [self.pageFlowView stopTimer];
}

- (IBAction)moreButtonClick:(UIButton *)sender
{
    if (self.loopViewBlock) {
        self.loopViewBlock();
    }
}

+(DMHomeHeardView *)homeHeardView
{
    DMHomeHeardView *homeheardView = [[UINib nibWithNibName:@"DMHomeHeardView" bundle:nil]instantiateWithOwner:self options:nil].lastObject;
    [homeheardView setupUI];
    [homeheardView setHomeButtonUI];
    return homeheardView;
}

- (IBAction)HomeButtonClick:(HomeButton *)sender
{
    if(self.homeButtonClickBlock){
        self.homeButtonClickBlock(sender.tag - 1000);
    }
}

- (void)setImageArray:(NSMutableArray<Banners *> *)imageArray
{
    _imageArray = imageArray;
    [self.pageFlowView reloadData];
}

- (void)setLoopViewArray:(NSArray<Data4 *> *)loopViewArray
{
    _loopViewArray = loopViewArray;
    NSMutableArray *titleArray = [NSMutableArray new];
    for (Data4 *model in loopViewArray) {
        
        [titleArray addObject:model.noticeTitle];
    }
    
    self.loopView.titles = titleArray;
}

- (void)setupUI {
    
    self.rdView.layer.cornerRadius = 12;
    self.rdView.clipsToBounds = YES;
    
    self.topBanner_H.constant = kBanner_H;
    
    NewPagedFlowView *pageFlowView = [[NewPagedFlowView alloc] initWithFrame:CGRectMake(0, 5, kScreenW, kBanner_H + 8)];
//    pageFlowView.backgroundColor = [UIColor redColor];
    pageFlowView.delegate = self;
    pageFlowView.dataSource = self;
    pageFlowView.minimumPageAlpha = 0.4;
    pageFlowView.orginPageCount = self.imageArray.count;
    pageFlowView.isOpenAutoScroll = YES;
    //初始化pageControl
    UIPageControl *pageControl = [[UIPageControl alloc] initWithFrame:CGRectMake(0, pageFlowView.frame.size.height - 24, kScreenW, 8)];
    pageFlowView.pageControl = pageControl;
    [pageFlowView addSubview:pageControl];

    /****************************
     使用导航控制器(UINavigationController)
     如果控制器中不存在UIScrollView或者继承自UIScrollView的UI控件
     请使用UIScrollView作为NewPagedFlowView的容器View,才会显示正常,如下
     *****************************/

    [self addSubview:pageFlowView];
    self.pageFlowView = pageFlowView;
    //添加到主view上
    [self addSubview:self.indicateLabel];
    WeakSelf
    [self.loopView setDidClickBlock:^(NSInteger index) {
        if (weakSelf.loopViewBlock) {
            weakSelf.loopViewBlock();
        }
    }];
    //设置更多按钮
    CGFloat imageWidth = self.moreButton.imageView.bounds.size.width;
    CGFloat labelWidth = self.moreButton.titleLabel.bounds.size.width;
    self.moreButton.imageEdgeInsets = UIEdgeInsetsMake(0, labelWidth, 0, -labelWidth);
    self.moreButton.titleEdgeInsets = UIEdgeInsetsMake(0, -imageWidth, 0, imageWidth);
}

- (void)setHomeButtonUI
{
    for (NSInteger i = 0; i < 4; i++) {
        
        HomeButton *button = [self viewWithTag:1000+i];
        button.titleLabel.textAlignment = NSTextAlignmentCenter;
    }
}

- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation {
    
    return (interfaceOrientation != UIInterfaceOrientationPortraitUpsideDown);
}

#pragma mark NewPagedFlowView Delegate
- (void)didSelectCell:(UIView *)subView withSubViewIndex:(NSInteger)subIndex {
    
    DMLog(@"点击了第%ld张图",(long)subIndex + 1);
    if (self.banerClickBlock) {
        self.banerClickBlock(subIndex);
    }
    self.indicateLabel.text = [NSString stringWithFormat:@"点击了第%ld张图",(long)subIndex + 1];
}

#pragma mark NewPagedFlowView Datasource
- (NSInteger)numberOfPagesInFlowView:(NewPagedFlowView *)flowView {
    
    return self.imageArray.count;
}

- (UIView *)flowView:(NewPagedFlowView *)flowView cellForPageAtIndex:(NSInteger)index{
    
    //    B  670 * 330
    //    F   690 *340
    
    PGIndexBannerSubiew *bannerView = (PGIndexBannerSubiew *)[flowView dequeueReusableCell];
    if (!bannerView) {
        bannerView = [[PGIndexBannerSubiew alloc] initWithFrame:CGRectMake(0, 0, kScreenW - 30, kBanner_H)];
        bannerView.clipsToBounds = YES;

    }

    //在这里下载网络图片
    NSString *string = kAPI_URL;
//    NSString *string = @"http://www.chebaojr.com/";
    NSString *url = [string stringByAppendingString:self.imageArray[index].imgPath];
//    bannerView.contentMode = UIViewContentModeScaleAspectFill;
    [bannerView.mainImageView imageWithUrlStr:url phImage:nil];
    
    return bannerView;
}

- (void)didScrollToPage:(NSInteger)pageNumber inFlowView:(NewPagedFlowView *)flowView {
    
//    NSLog(@"TestViewController 滚动到了第%ld页",pageNumber);
}

- (void)drawRect:(CGRect)rect
{
    self.pageFlowView.frame = CGRectMake(0, 5, kScreenW, kBanner_H + 8);
}

@end
