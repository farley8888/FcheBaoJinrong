//
//  DMHomePageCell.m
//  CheBaoJinRong
//
//  Created by apple on 2018/5/14.
//  Copyright © 2018年 apple. All rights reserved.
//

#import "DMHomePageCell.h"

@interface DMHomePageCell ()
@property (weak, nonatomic) IBOutlet UILabel *increaseLabel;
@property (weak, nonatomic) IBOutlet UIButton *leftButton;
@property (weak, nonatomic) IBOutlet UIButton *goumaiButton;
@property (weak, nonatomic) IBOutlet UILabel *scareLab;

@end

@implementation DMHomePageCell

- (void)awakeFromNib {
    [super awakeFromNib];

    self.increaseLabel.layer.cornerRadius = 25.0/2.0;
    self.increaseLabel.clipsToBounds = YES;
    self.leftButton.userInteractionEnabled = NO;
    self.goumaiButton.userInteractionEnabled = NO;
    self.scareLab.textColor = kScareColor;

}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
