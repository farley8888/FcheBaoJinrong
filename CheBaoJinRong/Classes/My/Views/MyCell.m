//
//  MyCell.m
//  XYG
//
//  Created by 张殿明 on 2017/11/14.
//  Copyright © 2017年 Mac. All rights reserved.
//

#import "MyCell.h"

@interface MyCell()
@property (weak, nonatomic) IBOutlet UIButton *getCashButton;
@property (weak, nonatomic) IBOutlet UIButton *rechargeButton;


@end


@implementation MyCell

- (void)awakeFromNib {
    [super awakeFromNib];
    
    self.getCashButton.layer.cornerRadius = 10;
    self.getCashButton.layer.borderWidth = 1;
    self.getCashButton.layer.borderColor = [UIColor blackColor].CGColor;
    
    self.rechargeButton.layer.cornerRadius = 10;
    self.rechargeButton.layer.borderWidth = 1;
    self.rechargeButton.layer.borderColor = KColorFromRGB(0xffa500).CGColor;
    
}
- (IBAction)buttonClick:(UIButton *)sender {
    
    NSInteger tag = sender.tag - 1200;
    if (self.buttonClickBlock) {
        self.buttonClickBlock(tag);
    }
}



@end
