//
//  LotOfViewScrollerTopView.m
//  CheBaoJinRong
//
//  Created by apple on 2018/5/16.
//  Copyright © 2018年 apple. All rights reserved.
//

#import "LotOfViewScrollerTopView.h"

@interface LotOfViewScrollerTopView ()

@property (nonatomic, strong) UIView *lineView;

@end

@implementation LotOfViewScrollerTopView

-(instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        
    }
    return self;
}

- (void)setTitleArr:(NSArray *)titleArr
{
    _titleArr = titleArr;
    [self setLotOfButton];
}

- (void)setLotOfButton
{
    CGFloat button_W = self.width / (CGFloat)self.titleArr.count;
    CGFloat button_H = self.height - 8;
    for (int i = 0; i < self.titleArr.count; i++) {
        UIButton *button = [UIButton buttonWithType:UIButtonTypeCustom];
        button.tag = 1400+i;
        if (i == 0) {
            button.selected = YES;
            button.userInteractionEnabled = NO;
        }
        [button addTarget:self action:@selector(buttonClick:) forControlEvents:UIControlEventTouchUpInside];
        [button setTitle:self.titleArr[i] forState:UIControlStateNormal];
        [button setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
        [button setTitleColor:KColorFromRGB(0xffa500) forState:UIControlStateSelected];
        button.frame = CGRectMake(i * button_W, 0, button_W, button_H);
        [self addSubview:button];
    }
    
    UIButton *firestButton = [self viewWithTag:1400];
    UIView *lineView = [[UIView alloc]initWithFrame:CGRectMake(0, self.height - 6, 40, 4)];
    self.lineView = lineView;
    lineView.centerX = firestButton.centerX;
    lineView.backgroundColor = KColorFromRGB(0xffa500);
    [self addSubview:lineView];
    UIView *bottomView = [[UIView alloc]initWithFrame:CGRectMake(0, self.height - 1, self.width, 1)];
    bottomView.backgroundColor = [UIColor groupTableViewBackgroundColor];
    [self addSubview:bottomView];
}

- (void)setSelectIndex:(NSInteger)selectIndex
{
    _selectIndex = selectIndex;
    [self setButtonSelectOrDefin:1400+selectIndex];
    [self lineViewAnimateWithDuration:selectIndex + 1400];
    
}

- (void)buttonClick:(UIButton *)btn
{
    [self setButtonSelectOrDefin:btn.tag];
//    for (int i = 1400; i < self.titleArr.count + 1400; i++) {
//        UIButton *button = [self viewWithTag:i];
//        [button setSelected:NO];
//        button.userInteractionEnabled = YES;
//    }
//    btn.userInteractionEnabled = NO;
    [self lineViewAnimateWithDuration:btn.tag];
    if (self.buttonClickBlock) {
        DMLog(@"调用几次");
        self.buttonClickBlock(btn.tag - 1400);
    }
//    [btn setSelected:YES];;
}

- (void)setButtonSelectOrDefin:(NSInteger)tag
{
    UIButton *btn = [self viewWithTag:tag];
    
    for (int i = 1400; i < self.titleArr.count + 1400; i++) {
        UIButton *button = [self viewWithTag:i];
        [button setSelected:NO];
        button.userInteractionEnabled = YES;
    }
    btn.userInteractionEnabled = NO;
    [btn setSelected:YES];;
}

- (void)lineViewAnimateWithDuration:(NSInteger)tag
{
    UIButton *button = [self viewWithTag:tag];
    WeakSelf
    [UIView animateWithDuration:0.3 animations:^{
        weakSelf.lineView.centerX = button.centerX;
    }];
}


@end
