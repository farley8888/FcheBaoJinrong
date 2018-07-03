//
//  DMHomePageCell3.m
//  CheBaoJinRong
//
//  Created by apple on 2018/6/25.
//  Copyright © 2018年 apple. All rights reserved.
//

#import "DMHomePageCell3.h"

@interface DMHomePageCell3 ()
@property (weak, nonatomic) IBOutlet UIView *cellBkView;

@end

@implementation DMHomePageCell3


- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
    /**  添加两个layer达到UI底部有线条感  **/
    CALayer *layer2 = [CALayer layer];
    layer2.frame = CGRectMake(1, 2, kScreenW - 20-2, 55);
    layer2.cornerRadius = 5;
    layer2.backgroundColor = [UIColor colorWithRed:244/256.0 green:233/256.0 blue:210/256.0 alpha:1].CGColor;
    layer2.masksToBounds = NO;
    [self.cellBkView.layer insertSublayer:layer2 below:self.cellBkView.layer];
    
    CALayer *layer = [CALayer layer];
    layer.frame = CGRectMake(1, 0, kScreenW - 20-2, 55 -2);
    layer.cornerRadius = 5;
    layer.backgroundColor = [UIColor whiteColor].CGColor;
    layer.masksToBounds = NO;
    [self.cellBkView.layer insertSublayer:layer below:layer];
}

- (IBAction)moreButtonClick:(UIButton *)sender {
    
    if (self.moreButtonClick) {
        self.moreButtonClick();
    }
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
