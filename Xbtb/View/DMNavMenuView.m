//
//  DMNavMenuView.m
//  XHGY_Agent
//
//  Created by 尚往文化 on 17/4/21.
//  Copyright © 2017年 DMing. All rights reserved.
//

#import "DMNavMenuView.h"
#import "DMIconFont.h"
#import "UIImage+DMIconFont.h"

#define kDMNavMenuSetButtonW 60

@interface DMNavMenuView ()

@property (nonatomic, strong) NSMutableArray<UIButton *> *btns;
@property (nonatomic, strong) UIButton *setBtn;
@property (nonatomic, strong) UIView *lineView;

@end

@implementation DMNavMenuView

- (NSMutableArray<UIButton *> *)btns
{
     if (_btns==nil) {
          _btns = [NSMutableArray array];
     }
     return _btns;
}

- (instancetype)initWithFrame:(CGRect)frame items:(NSArray<DMNavMenuItem *> *)items
{
     self = [super initWithFrame:frame];
     if (self) {
          [self setupUI];
          self.items = items;
     }
     return self;
}

- (void)setSelectIndex:(NSInteger)selectIndex
{
     _selectIndex = selectIndex;
     
     __block CGFloat countX = 0;
     [self.items enumerateObjectsUsingBlock:^(DMNavMenuItem * _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
          if (idx>=selectIndex) {
               *stop = YES;
          } else {
               countX += obj.width;
          }
     }];
//     countX = self.btns[selectIndex].x;
     [UIView animateWithDuration:0.3 animations:^{
          self.lineView.x = countX;
          self.lineView.width = self.items[selectIndex].width;
     }];
     
     if ((countX + self.items[selectIndex].width) > self.scrollView.contentOffset.x + self.scrollView.width) {  //判断按钮是否显示全
          DMLog(@"按钮没有显示全");
          
          //判断
          CGFloat x = (countX + self.items[selectIndex].width) - (self.scrollView.contentOffset.x + self.scrollView.width);
          
          [self.scrollView setContentOffset:CGPointMake(self.scrollView.contentOffset.x + x +2, 0) animated:YES];
     }
     CGFloat offsetX = self.lineView.x - self.scrollView.contentOffset.x;
     if (offsetX>self.width/2) { //判断按钮是否显示一半或小于一半
          if (self.lineView.x-self.width/2+self.width<self.scrollView.contentSize.width) {
               [self.scrollView setContentOffset:CGPointMake(self.lineView.x-self.width/2, 0) animated:YES];
          } else if (self.scrollView.contentSize.width-self.width>0) {
               [self.scrollView setContentOffset:CGPointMake(self.scrollView.contentSize.width-self.width, 0) animated:YES];
          }else{
               //            [self.scrollView setContentOffset:CGPointMake(kScreenW, 0)];
          }
     }
     if (offsetX<self.width/2) {
          if (self.lineView.x - self.width/2>0) {
               [self.scrollView setContentOffset:CGPointMake(self.lineView.x - self.width/2, 0) animated:YES];
          } else {
               [self.scrollView setContentOffset:CGPointMake(0, 0) animated:YES];
          }
     }
}

//右上角红色数字显示
- (void)setOrderDict:(NSDictionary *)orderDict
{
     _orderDict = orderDict;
     
     for (NSInteger i = 0; i < [orderDict allKeys].count; i++) {
          
          UIButton *button = [self.scrollView viewWithTag:i];
          if (i != 0) {
               UILabel *lab = [button viewWithTag:100+i];
               if (i == 1) {
                    if ([orderDict[@"payment"] integerValue] <= 0) {
                         lab.hidden = YES;
                    }else{
                         lab.hidden = NO;
                         lab.text = [NSString stringWithFormat:@"%@",orderDict[@"payment"]];
                    }
               }else if (i == 2){
                    if ([orderDict[@"delivered"] integerValue] <= 0) {
                         lab.hidden = YES;
                    }else{
                         lab.hidden = NO;
                         lab.text = [NSString stringWithFormat:@"%@",orderDict[@"delivered"]];
                    }
               }else if (i == 3){
                    if ([orderDict[@"received"] integerValue] <= 0) {
                         lab.hidden = YES;
                    }else{
                         lab.hidden = NO;
                         lab.text = [NSString stringWithFormat:@"%@",orderDict[@"received"]];
                    }
                    
               }else if (i == 4){
                    if ([orderDict[@"evaluated"] integerValue] <= 0) {
                         lab.hidden = YES;
                    }else{
                         lab.hidden = NO;
                         lab.text = [NSString stringWithFormat:@"%@",orderDict[@"evaluated"]];
                    }
               };
          }
     }
}

- (void)setItems:(NSArray<DMNavMenuItem *> *)items
{
     _items = items;
     WeakSelf
     [items enumerateObjectsUsingBlock:^(DMNavMenuItem * _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
          UIButton *btn = [UIButton buttonWithType:UIButtonTypeRoundedRect];
          btn.titleLabel.font = [UIFont systemFontOfSize:16];
          [btn setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
          btn.tag = idx;
          [btn setTitle:obj.title forState:UIControlStateNormal];
          [btn addTarget:weakSelf action:@selector(itemClick:) forControlEvents:UIControlEventTouchUpInside];
          if (idx != 0) {
               UILabel *labTag = [btn viewWithTag:100+idx];
               [labTag removeFromSuperview];
               UILabel *lab = [[UILabel alloc]initWithFrame: CGRectMake(btn.titleLabel.mj_x + btn.titleLabel.mj_textWith + 15,1, 15, 15)];
               lab.tag = 100 + idx;
               lab.textColor = [UIColor redColor];
               lab.layer.cornerRadius = 7.5;
               lab.layer.borderWidth = 1;
               lab.font = [UIFont systemFontOfSize:10];
               lab.textAlignment = NSTextAlignmentCenter;
               lab.adjustsFontSizeToFitWidth = YES;
               lab.clipsToBounds = YES;
               lab.layer.borderColor = [UIColor redColor].CGColor;
               lab.hidden = YES;
               [btn addSubview:lab];
          }
          [weakSelf.scrollView addSubview:btn];
          [weakSelf.btns addObject:btn];
     }];
}

- (void)setupUI
{
     [self setupScrollView];
     [self setupLineView];
}

- (void)setupScrollView
{
     self.scrollView = [[UIScrollView alloc] init];
     self.scrollView.frame = self.bounds;
     self.scrollView.showsHorizontalScrollIndicator = NO;
     [self addSubview:self.scrollView];
}

- (void)setupLineView
{
     self.lineView = [[UIView alloc] init];
     self.lineView.backgroundColor = [UIColor redColor];
     [self.scrollView addSubview:self.lineView];
}

- (void)setupSetBtn
{
     self.setBtn = [UIButton buttonWithType:UIButtonTypeCustom];
     [self.setBtn setImage:[UIImage imageWithInfo:DMIconInfoMake(@"", 25, [UIColor whiteColor])] forState:UIControlStateNormal];
     
     self.setBtn.imageView.contentMode = UIViewContentModeScaleAspectFit;
     [self.setBtn addTarget:self action:@selector(setClick) forControlEvents:UIControlEventTouchUpInside];
     [self.scrollView addSubview:self.setBtn];
}

- (void)setClick
{
     if (self.setClickBlock) {
          self.setClickBlock();
     }
}

- (void)itemClick:(UIButton *)btn
{
     NSInteger index = btn.tag;
     if (self.selectIndex==index) return;
     self.selectIndex = index;
     if (self.itemClickBlock) {
          self.itemClickBlock(index);
     }
}

- (void)layoutSubviews
{
     __block CGFloat countX = 0;
     [self.btns enumerateObjectsUsingBlock:^(UIButton * _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
          obj.x = countX;
          obj.y = 0;
          obj.width = self.items[obj.tag].width;
          obj.height = self.height;
          countX += obj.width;
     }];
     
     self.lineView.x = self.lineView.x?:0;
     self.lineView.y = self.height-2;
     self.lineView.width = [self.btns objectAtIndex:self.selectIndex].width;
     self.lineView.height = 2;
     self.scrollView.contentSize = CGSizeMake(CGRectGetMaxX([self.btns lastObject].frame), 0);
}

@end
