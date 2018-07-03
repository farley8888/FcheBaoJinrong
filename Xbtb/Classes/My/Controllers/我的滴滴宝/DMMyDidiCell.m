//
//  DMMyDidiCell.m
//  CheBaoJinRong
//
//  Created by apple on 2018/5/15.
//  Copyright © 2018年 apple. All rights reserved.
//

#import "DMMyDidiCell.h"

@interface DMMyDidiCell ()
@property (weak, nonatomic) IBOutlet UIButton *redeemButton;
@property (weak, nonatomic) IBOutlet UIButton *depositButton;
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *button_W;

@end

@implementation DMMyDidiCell

- (void)awakeFromNib {
    [super awakeFromNib];
    self.redeemButton.layer.cornerRadius = 10;
    self.redeemButton.layer.borderColor = [UIColor blackColor].CGColor;
    self.redeemButton.layer.borderWidth = 1.0;
    self.depositButton.layer.cornerRadius = 10;

}
- (IBAction)buttonClick:(UIButton *)sender {
    
    NSInteger tag = sender.tag - 1300;
    if (self.cellButtonClick) {
        self.cellButtonClick(tag);
    }
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
