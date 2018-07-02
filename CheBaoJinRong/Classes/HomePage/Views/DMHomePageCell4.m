//
//  DMHomePageCell4.m
//  CheBaoJinRong
//
//  Created by apple on 2018/6/25.
//  Copyright © 2018年 apple. All rights reserved.
//

#import "DMHomePageCell4.h"
@interface DMHomePageCell4 ()
@property (weak, nonatomic) IBOutlet UIView *bgView;

@end

@implementation DMHomePageCell4

- (void)awakeFromNib {
    [super awakeFromNib];
    CGFloat score = 400.0/218;
    CGFloat layerHeight = kScreenW/score;
    /**  添加两个layer达到UI底部有线条感  **/
    CALayer *layer2 = [CALayer layer];
    layer2.frame = CGRectMake(1, 2, kScreenW - 20-2, layerHeight);
    layer2.cornerRadius = 5;
    layer2.backgroundColor = [UIColor colorWithRed:244/256.0 green:233/256.0 blue:210/256.0 alpha:0.95].CGColor;
    layer2.masksToBounds = NO;
    [self.bgView.layer insertSublayer:layer2 below:self.bgView.layer];
    
    CALayer *layer = [CALayer layer];
    layer.frame = CGRectMake(1, 0, kScreenW - 20-2, layerHeight -2);
    layer.cornerRadius = 5;
    layer.backgroundColor = [UIColor whiteColor].CGColor;
    layer.masksToBounds = NO;
    [self.bgView.layer insertSublayer:layer below:layer];

}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
