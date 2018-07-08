//
//  XBTButtonSelectView.m
//  CheBaoJinRong
//
//  Created by apple on 2018/5/15.
//  Copyright © 2018年 apple. All rights reserved.
//

#import "XBTButtonSelectView.h"


@interface XBTButtonSelectView()

@property (weak, nonatomic) IBOutlet UIView *lineView;

@end

@implementation XBTButtonSelectView

+ (XBTButtonSelectView *)buttonselectView
{
    XBTButtonSelectView *view = [[UINib nibWithNibName:@"XBTButtonSelectView" bundle:nil]instantiateWithOwner:self options:nil].lastObject;
    [view setUI];
    return view;
}

- (void)setUI
{
    self.lineView.layer.cornerRadius = 2;
    self.lineView.clipsToBounds = YES;
}

- (IBAction)buttonClick:(UIButton *)sender {
    
    NSInteger tag = sender.tag - 1100;
    if (self.buttonClick) {
        self.buttonClick(tag);
    }
    [self animateWithLineView:tag];
}

- (void)setSelectIndex:(NSInteger)selectIndex
{
    _selectIndex = selectIndex;
    [self animateWithLineView:selectIndex];
}

- (void)animateWithLineView:(NSInteger)tag
{
    WeakSelf
    [UIView animateWithDuration:0.3 animations:^{
        if (tag) {
            weakSelf.lineView.centerX = weakSelf.width/4.0 * 3;
        }else{
            weakSelf.lineView.centerX = weakSelf.width/4.0;
        }
    }];
}

@end
