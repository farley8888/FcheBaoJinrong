//
//  CycleView.m
//  无限循环图片
//
//  Created by Jason on 15/8/12.
//  Copyright (c) 2015年 www.jizhan.com. All rights reserved.
//

#import "DMCycleView.h"
//#import "DMDefine.h"

#define kBannerTimeIntervalDefault 5

@interface DMCycleView ()<UIScrollViewDelegate>

@property (strong, nonatomic) UIPageControl *pageControl;

@property (assign, nonatomic) NSInteger index;

@end

@implementation DMCycleView
{
    NSTimer *_timer;
}

- (void)setImages:(NSArray *)images
{
    _images = images;
    self.scrollView.images = images;
    self.pageControl.numberOfPages = images.count;
}

- (void)setPageControlShowStyle:(DMCycleViewPageControlShowStyle)pageControlShowStyle
{
    _pageControlShowStyle = pageControlShowStyle;
    [self setupPageCotrolShowStyle];
}

- (void)setBannerTimeInterval:(NSTimeInterval)bannerTimeInterval
{
    _bannerTimeInterval = bannerTimeInterval;
    [self setupTimer];
}

- (void)setTimerEnable:(BOOL)timerEnable
{
    _timerEnable = timerEnable;
    [self setupTimer];
}

- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        self.timerEnable = YES;
    }
    return self;
}

+ (instancetype)cycleViewWithFrame:(CGRect)frame images:(NSArray *)images currentIndex:(NSInteger)currentIndex
{
    DMCycleView *cycleView = [[DMCycleView alloc] initWithFrame:frame images:images currentIndex:currentIndex];
    return cycleView;
}

- (instancetype)initWithFrame:(CGRect)frame images:(NSArray *)images currentIndex:(NSInteger)currentIndex
{
    NSInteger count = images.count;
    if (count == 0) {
        return nil;
    }
    self = [self initWithFrame:frame];
    if (self) {
        _scrollView = [[DMCycleScrollView alloc] initWithFrame:CGRectMake(0, 0, frame.size.width, frame.size.height) andImages:images andCurrentIndex:currentIndex andIndexChange:^(NSInteger index) {
            NSInteger count = self.images.count;
            self.pageControl.currentPage = (count==2&&index==2) ? 0 : index;
        }];
        [self addSubview:self.scrollView];
        
        
        UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(tap:)];
        [self.scrollView addGestureRecognizer:tap];
        
        self.pageControl = [[UIPageControl alloc] init];
        self.pageControl.numberOfPages = count;
        self.pageControl.userInteractionEnabled = YES;
        self.pageControl.pageIndicatorTintColor = [UIColor grayColor];
        self.pageControl.currentPageIndicatorTintColor = [UIColor orangeColor];
        [self.pageControl addTarget:self action:@selector(changeIndex:) forControlEvents:UIControlEventValueChanged];
        self.pageControl.backgroundColor = [UIColor clearColor];
        [self addSubview:self.pageControl];
        
        [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(restartTimer) name:TimerRestartNotification object:nil];
    }
    return self;
}

+ (instancetype)cycleViewWithFrame:(CGRect)frame images:(NSArray *)images currentIndex:(NSInteger)currentIndex didSelectForIndex:(DMCycleViewDidSelectForIndex)didSelectForIndex
{
    DMCycleView *cycleView = [[DMCycleView alloc] initWithFrame:frame images:images currentIndex:currentIndex didSelectForIndex:didSelectForIndex];
    return cycleView;
}

- (instancetype)initWithFrame:(CGRect)frame images:(NSArray *)images currentIndex:(NSInteger)currentIndex didSelectForIndex:(DMCycleViewDidSelectForIndex)didSelectForIndex
{
    self = [self initWithFrame:frame images:images currentIndex:currentIndex];
    if (self) {
        self.didSelectForIndex = didSelectForIndex;
    }
    return self;
}

- (void)restartTimer
{
    _timer.fireDate = [NSDate dateWithTimeIntervalSinceNow:self.bannerTimeInterval];
}

- (void)timerAction:(NSTimer *)timer
{
    self.scrollView.currentIndex = [self.scrollView beyondBoundWithIndex:self.scrollView.currentIndex];
    self.pageControl.currentPage = self.scrollView.currentIndex;
}

- (void)tap:(UITapGestureRecognizer *)tap
{
    if (_didSelectForIndex != nil) {
//        _didSelectForIndex(self.scrollView.currentIndex);
        _didSelectForIndex(self.pageControl.currentPage);
    }
    if ([_delegate respondsToSelector:@selector(cycleView:didSelectForIndex:)]) {
        [_delegate cycleView:self didSelectForIndex:self.scrollView.currentIndex];
    }
}

- (void)changeIndex:(UIPageControl *)pageCtl
{
    self.scrollView.flag = YES;
    self.scrollView.currentIndex = pageCtl.currentPage;
}

//即将添加到父视图中
- (void)willMoveToSuperview:(UIView *)newSuperview
{
    [self setupPageCotrolShowStyle];
    
    [self setupTimer];
    
}

- (void)setupTimer
{
    if ([_timer isValid]) {
        [_timer invalidate];
        _timer = nil;
    }
    if (!self.timerEnable) return;
    
    if (_bannerTimeInterval == 0) {
        _bannerTimeInterval = kBannerTimeIntervalDefault;
    }
    _timer = [NSTimer timerWithTimeInterval:_bannerTimeInterval target:self selector:@selector(timerAction:) userInfo:nil repeats:YES];
    [[NSRunLoop currentRunLoop] addTimer:_timer forMode:NSRunLoopCommonModes];
}

//私有方法
- (void)setupPageCotrolShowStyle
{
    CGFloat x = 0;
    CGFloat y = self.bounds.size.height - 30;
    CGFloat w = self.pageControl.numberOfPages * 20;
    CGFloat h = 30;
    self.pageControl.hidden = NO;
    switch (self.pageControlShowStyle) {
        case DMCycleViewPageControlShowStyleLeft:
            x = 5;
            break;
        case DMCycleViewPageControlShowStyleCenter:
            x = self.frame.size.width/2 - w/2;
            break;
        case DMCycleViewPageControlShowStyleRight:
            x = self.frame.size.width - w - 5;
            break;
        case DMCycleViewPageControlShowStyleNone:
            x = -w;
            self.pageControl.hidden = YES;
            break;
        default:
            break;
    }
    self.pageControl.frame = CGRectMake(x, y, w, h);
}

@end
