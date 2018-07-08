//
//  XBTInvestmentCell.m
//  CheBaoJinRong
//
//  Created by apple on 2018/5/14.
//  Copyright © 2018年 apple. All rights reserved.
//

#import "XBTInvestmentCell.h"

@interface XBTInvestmentCell ()
@property (weak, nonatomic) IBOutlet UILabel *increaseLabel;
@property (weak, nonatomic) IBOutlet UISlider *progress;

@property (weak, nonatomic) IBOutlet UILabel *nameLabel;
@property (weak, nonatomic) IBOutlet UILabel *increaseNumberLabel;

@property (weak, nonatomic) IBOutlet UILabel *yearTypeLabel;
@property (weak, nonatomic) IBOutlet UILabel *timeLabel;
@property (weak, nonatomic) IBOutlet UILabel *increaseTypeLabel;
@property (weak, nonatomic) IBOutlet UIImageView *cellBackImageView;
@property (weak, nonatomic) IBOutlet UILabel *totalMoneyLabel;
@property (weak, nonatomic) IBOutlet UILabel *overplusMoneyLabel;
@property (weak, nonatomic) IBOutlet UIButton *leftConerButton;

@end

@implementation XBTInvestmentCell

- (void)awakeFromNib {
    [super awakeFromNib];
   
     [self.progress setThumbImage:[UIImage imageNamed:@"dangqianjindu"] forState:UIControlStateNormal];
    self.increaseLabel.layer.cornerRadius = 25.0/2;
    self.increaseLabel.clipsToBounds = YES;
    self.progress.userInteractionEnabled = NO;
    self.increaseNumberLabel.textColor = kScareColor;
}

- (void)setCellData:(Data1 *)cellData
{
    _cellData = cellData;

    if ([cellData.borrowTitle containsString:@"新手标"]) {
        [self.leftConerButton setTitle:@"新手标" forState:UIControlStateNormal];
        self.increaseLabel.text = @"限时加息3%";
        self.increaseNumberLabel.text = [NSString stringWithFormat:@"%.1f%%+3%%",(cellData.annualRate - 3.0)];
    }else{
        [self.leftConerButton setTitle:@"车车宝" forState:UIControlStateNormal];
        self.increaseLabel.text = @"限时加息1%";
        self.increaseNumberLabel.text = [NSString stringWithFormat:@"%.1f%%+1%%",(cellData.annualRate - 1.0)];
    }
    self.totalMoneyLabel.text = [NSString stringWithFormat:@"总金额：%.2f万元",cellData.borrowAmount/10000.0];
    self.overplusMoneyLabel.text = [NSString stringWithFormat:@"剩余金额：%.2f元",cellData.borrowAmount - cellData.hasBorrowAmount];
    self.nameLabel.text = cellData.borrowTitle;

    if (cellData.deadlineType == 1) {
        self.timeLabel.text = [NSString stringWithFormat:@"出借期限:%@天",cellData.deadline];
    }else if (cellData.deadlineType == 2){
        self.timeLabel.text = [NSString stringWithFormat:@"出借期限:%@月",cellData.deadline];
    }
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
    self.increaseTypeLabel.text = str;
    self.yearTypeLabel.text = @"年化利率";
    [self.progress setValue:cellData.progress animated:YES];
}

- (void)setType:(CellType)type
{
    _type = type;
    if (type == SellOutType) {
        self.increaseLabel.backgroundColor = [UIColor lightGrayColor];
        self.cellBackImageView.image = [UIImage imageNamed:@"sellOut_bk"];
        self.progress.minimumTrackTintColor = [UIColor groupTableViewBackgroundColor];
    }else{
        self.increaseLabel.backgroundColor = kColor(160, 251, 217);
        self.cellBackImageView.image = [UIImage imageNamed:@"bankuai"];
        self.progress.minimumTrackTintColor = kScareColor;
    }
    
}

@end
