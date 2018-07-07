//
//  DMHomePageCell2.m
//  CheBaoJinRong
//
//  Created by apple on 2018/5/14.
//  Copyright © 2018年 apple. All rights reserved.
//

#import "XBTHomePageCell2.h"

@interface XBTHomePageCell2 ()
@property (weak, nonatomic) IBOutlet UILabel *increaseInterestLabel;
@property (weak, nonatomic) IBOutlet UISlider *progressSlider;
@property (weak, nonatomic) IBOutlet UILabel *nameLabel;
@property (weak, nonatomic) IBOutlet UILabel *interestLabel;
@property (weak, nonatomic) IBOutlet UILabel *interestTimeLabel;
@property (weak, nonatomic) IBOutlet UILabel *interestTypeLabel;
@property (weak, nonatomic) IBOutlet UIButton *rightButton;
@property (weak, nonatomic) IBOutlet UILabel *totalMoneyLabel;
@property (weak, nonatomic) IBOutlet UILabel *overplusMoneyLabel;

@end

@implementation XBTHomePageCell2

- (void)awakeFromNib {
    [super awakeFromNib];

    self.increaseInterestLabel.layer.cornerRadius = 25.0/2;
    self.increaseInterestLabel.clipsToBounds = YES;
    [self.progressSlider setThumbImage:[UIImage imageNamed:@"dangqianjindu"] forState:UIControlStateNormal];
    self.progressSlider.userInteractionEnabled = NO;
    self.interestLabel.textColor = kScareColor;
}

- (void)setCellData:(Data1 *)cellData
{
    _cellData = cellData;
    
    if ([cellData.borrowTitle containsString:@"新手标"]) {
        [self.rightButton setTitle:@"新手标" forState:UIControlStateNormal];
        self.increaseInterestLabel.text = @"限时加息3%";
        self.interestLabel.text = [NSString stringWithFormat:@"%.1f%%+3%%",(cellData.annualRate - 3.0)];
    }else{
        [self.rightButton setTitle:@"车车宝" forState:UIControlStateNormal];
        self.increaseInterestLabel.text = @"限时加息1%";
        self.interestLabel.text = [NSString stringWithFormat:@"%.1f%%+1%%",(cellData.annualRate - 1.0)];
    }
    self.totalMoneyLabel.text = [NSString stringWithFormat:@"总金额：%.2f万元",cellData.borrowAmount/10000.0];
    self.overplusMoneyLabel.text = [NSString stringWithFormat:@"剩余金额：%.2f元",cellData.borrowAmount - cellData.hasBorrowAmount];
    self.nameLabel.text = cellData.borrowTitle;
    
    if (cellData.deadlineType == 1) {
        self.interestTimeLabel.text = [NSString stringWithFormat:@"出借期限:%@天",cellData.deadline];
    }else if (cellData.deadlineType == 2){
        self.interestTimeLabel.text = [NSString stringWithFormat:@"出借期限:%@月",cellData.deadline];
    }

    //（1，一次性还款，2，为按月付息，到期还本,3等额本息）
    NSString *str = @"";
    switch (cellData.repayType) {
        case 1:
            str = @"到期还本付息";
            break;
        case 2:
            str = @"先息后本";
            break;
        case 3:
            str = @"等额还款";
            break;
            
        default:
            str = @"未知";
            break;
    }
    self.interestTypeLabel.text = str;
    [self.progressSlider setValue:cellData.progress animated:YES];
    
}

@end
