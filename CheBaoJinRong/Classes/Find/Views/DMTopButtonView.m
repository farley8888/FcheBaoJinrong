//
//  DMTopButtonView.m
//  CheBaoJinRong
//
//  Created by apple on 2018/5/14.
//  Copyright © 2018年 apple. All rights reserved.
//

#import "DMTopButtonView.h"

@interface DMTopButtonView ()

@property (nonatomic, strong)UIView *lineView;
@property (nonatomic, strong)UIButton *leftButton;
@property (nonatomic, strong)UIButton *rightButton;

@end

@implementation DMTopButtonView

- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        [self setUpUI];
    }
    return self;
}

- (void)setUpUI
{
    UIButton *leftButton = [[UIButton alloc]initWithFrame:CGRectMake(0, 0, self.width/2.0, self.height -4)];
    UIButton *rightButton = [[UIButton alloc]initWithFrame:CGRectMake(self.width/2.0, 0, self.width/2.0, self.height - 4)];
    
    leftButton.tag = 1000;
    rightButton.tag = 1001;
    
    [leftButton setTitle:@"进行中" forState:UIControlStateNormal];
    [rightButton setTitle:@"已结束" forState:UIControlStateNormal];
    
    [leftButton setTitleColor:KColorFromRGB(0x555555) forState:UIControlStateNormal];
    [rightButton setTitleColor:KColorFromRGB(0x555555) forState:UIControlStateNormal];
    
    [leftButton setTitleColor:KColorFromRGB(0xffa500) forState:UIControlStateSelected];
    [rightButton setTitleColor:KColorFromRGB(0xffa500) forState:UIControlStateSelected];
    
    [leftButton addTarget:self action:@selector(leftAndRightButtonClick:) forControlEvents:UIControlEventTouchUpInside];
    [rightButton addTarget:self action:@selector(leftAndRightButtonClick:) forControlEvents:UIControlEventTouchUpInside];
     
    UIView *lineView = [[UIView alloc]init];
    lineView.backgroundColor = KColorFromRGB(0xffa500);
    self.lineView = lineView;
    
    [self addSubview:leftButton];
    [self addSubview:rightButton];
    [self addSubview:lineView];
    
    WeakSelf
    [lineView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.mas_equalTo(leftButton.mas_centerX);
        make.height.equalTo(@2);
        make.bottom.equalTo(@-1);
        make.width.mas_equalTo(leftButton.mas_width).multipliedBy(0.3);
    }];
}

- (void)leftAndRightButtonClick:(UIButton *)btn
{
    NSInteger tag = btn.tag - 1000;
    if (self.buttonClick) {
        self.buttonClick(tag);
    }
    WeakSelf
    [UIView animateWithDuration:0.3 animations:^{
        if (tag) {
            weakSelf.lineView.centerX = weakSelf.width/4.0 * 3;
        }else{
            weakSelf.lineView.centerX = weakSelf.width/4.0;
        }
    }];
}

- (void)setSelectIndex:(NSInteger)selectIndex
{
    _selectIndex = selectIndex;
    WeakSelf
    [UIView animateWithDuration:0.3 animations:^{
        if (selectIndex) {
            weakSelf.lineView.centerX = weakSelf.width/4.0 * 3;
        }else{
            weakSelf.lineView.centerX = weakSelf.width/4.0;
        }
    }];
}


@end
