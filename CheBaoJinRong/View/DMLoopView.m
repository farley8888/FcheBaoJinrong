//
//  DMLoopView.m
//  拼图游戏
//
//  Created by 尚往文化 on 17/4/18.
//  Copyright © 2017年 DMing. All rights reserved.
//

#import "DMLoopView.h"

@interface DMLoopView ()

@property (nonatomic, strong) UIButton *currentBtn;
@property (nonatomic, strong) UIButton *nextBtn;

@property (nonatomic, assign) NSInteger currentIndex;


@property (nonatomic, assign) BOOL flag;//记录 titles 数组中是不是只有  一个元素

@end

@implementation DMLoopView
{
    NSTimer *_timer;
}

- (void)dealloc
{
    if (_timer.isValid) {
        [_timer invalidate];
    }
}

- (void)setTitles:(NSArray<NSString *> *)titles
{
    if (titles.count==0) {
        if (_timer.isValid) {
            [_timer invalidate];
        }
    }
    self.flag = titles.count==1;
    _titles = titles.count==1 ? [titles arrayByAddingObjectsFromArray:titles] : titles;
    
    [self.currentBtn setTitle:_titles[0] forState:UIControlStateNormal];
    [self.nextBtn setTitle:_titles[1] forState:UIControlStateNormal];
}

- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        self.clipsToBounds = YES;
        [self setupUI];
        [self setupTimer];
    }
    return self;
}

- (instancetype)initWithFrame:(CGRect)frame didClickBlock:(void (^)(NSInteger))didClickBlock titles:(NSArray<NSString *> *)titles
{
    self = [super initWithFrame:frame];
    if (self) {
        self.clipsToBounds = YES;
        self.didClickBlock = didClickBlock;
        [self setupUI];
        [self setupTimer];
        self.titles = titles;
    }
    return self;
}

- (instancetype)initWithCoder:(NSCoder *)coder
{
    self = [super initWithCoder:coder];
    if (self) {
        self.clipsToBounds = YES;
        [self setupUI];
        [self setupTimer];
    }
    return self;
}

- (void)setupUI
{
    self.currentBtn = [self creteBtn];
    self.nextBtn = [self creteBtn];
}

- (void)setupTimer
{
    _timer = [NSTimer timerWithTimeInterval:3 target:self selector:@selector(timerAction) userInfo:nil repeats:YES];
    [[NSRunLoop currentRunLoop] addTimer:_timer forMode:NSRunLoopCommonModes];
}

- (void)timerAction
{
    [UIView animateWithDuration:0.5 animations:^{
        self.currentBtn.frame = CGRectMake(0, -self.bounds.size.height, self.bounds.size.width, self.bounds.size.height);
        self.nextBtn.frame = CGRectMake(0, 0, self.bounds.size.width, self.bounds.size.height);
    } completion:^(BOOL finished) {
        self.currentBtn.frame = CGRectMake(0, self.bounds.size.height, self.bounds.size.width, self.bounds.size.height);
        UIButton *tempBtn = self.currentBtn;
        self.currentBtn = self.nextBtn;
        self.nextBtn = tempBtn;
        
        [self setupTitle];
        
    }];
}

- (void)setupTitle
{
    self.currentIndex++;
    if (self.currentIndex>self.titles.count-1) {
        self.currentIndex=0;
    }
    if (self.currentIndex+1<=self.titles.count-1) {
        [self.nextBtn setTitle:self.titles[self.currentIndex+1] forState:UIControlStateNormal];
    } else {
        [self.nextBtn setTitle:self.titles[0] forState:UIControlStateNormal];
    }
}

- (UIButton *)creteBtn
{
    UIButton *btn = [UIButton buttonWithType:UIButtonTypeRoundedRect];
    btn.titleLabel.font = [UIFont systemFontOfSize:12];
    [btn addTarget:self action:@selector(click:) forControlEvents:UIControlEventTouchUpInside];
    [btn setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
    //修改button文字对其方式
    btn.contentHorizontalAlignment = UIControlContentHorizontalAlignmentLeft;
    
    [self addSubview:btn];
    return btn;
}

- (void)click:(UIButton *)btn
{
    if (self.didClickBlock) {
        if (self.flag) {
            self.didClickBlock(0);
        } else {
            self.didClickBlock(self.currentIndex);
        }
    }
}

- (void)layoutSubviews
{
    self.currentBtn.frame = CGRectMake(0, 0, self.bounds.size.width, self.bounds.size.height);
    self.nextBtn.frame = CGRectMake(0, self.bounds.size.height, self.bounds.size.width, self.bounds.size.height);
}

@end
