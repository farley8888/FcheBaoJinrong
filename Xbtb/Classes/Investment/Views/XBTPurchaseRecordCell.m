//
//  DMPurchaseRecordCell.m
//  CheBaoJinRong
//
//  Created by apple on 2018/5/28.
//  Copyright © 2018年 apple. All rights reserved.
//

#import "XBTPurchaseRecordCell.h"
#import "NSDate+DM.h"

@interface XBTPurchaseRecordCell ()
@property (weak, nonatomic) IBOutlet UILabel *userNameLabel;

@property (weak, nonatomic) IBOutlet UILabel *timeLabel;
@property (weak, nonatomic) IBOutlet UILabel *amoutLabel;

@end


@implementation XBTPurchaseRecordCell

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
}

- (void)setCellModel:(XBTPurchaseRecordModel *)cellModel
{
    _cellModel = cellModel;
    self.userNameLabel.text = cellModel.userNameString;
    self.timeLabel.text = [NSDate stringWithTimeInterval:cellModel.investTime dateFormat:@"yyyy-MM-dd HH:mm:ss"];
    self.amoutLabel.text = [NSString stringWithFormat:@"%.2f元",cellModel.realAmount];
}
@end
