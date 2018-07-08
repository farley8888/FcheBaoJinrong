//
//  XBTBauDidiBaoCell.m
//  CheBaoJinRong
//
//  Created by apple on 2018/5/22.
//  Copyright © 2018年 apple. All rights reserved.
//

#import "XBTBauDidiBaoCell.h"

@interface XBTBauDidiBaoCell ()
@property (weak, nonatomic) IBOutlet UILabel *amoutLabel;
@property (weak, nonatomic) IBOutlet UISlider *pressSlider;

@end


@implementation XBTBauDidiBaoCell

- (void)awakeFromNib {
    [super awakeFromNib];

    [self.pressSlider setThumbImage:[UIImage imageNamed:@"dangqianjindu"] forState:UIControlStateNormal];
    self.pressSlider.userInteractionEnabled = NO;
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
