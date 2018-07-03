//
//  DMPurchaseRecordCell.m
//  CheBaoJinRong
//
//  Created by apple on 2018/5/28.
//  Copyright © 2018年 apple. All rights reserved.
//

#import "DMPurchaseRecordCell.h"
#import "NSDate+DM.h"

@interface DMPurchaseRecordCell ()
@property (weak, nonatomic) IBOutlet UILabel *userNameLabel;

@property (weak, nonatomic) IBOutlet UILabel *timeLabel;
@property (weak, nonatomic) IBOutlet UILabel *amoutLabel;

@end


@implementation DMPurchaseRecordCell

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
}

- (void)setCellModel:(DMPurchaseRecordModel *)cellModel
{
    _cellModel = cellModel;
    self.userNameLabel.text = cellModel.userNameString;
    self.timeLabel.text = [NSDate stringWithTimeInterval:cellModel.investTime dateFormat:@"yyyy-MM-dd HH:mm:ss"];
    self.amoutLabel.text = [NSString stringWithFormat:@"%.2f元",cellModel.realAmount];
}
@end
