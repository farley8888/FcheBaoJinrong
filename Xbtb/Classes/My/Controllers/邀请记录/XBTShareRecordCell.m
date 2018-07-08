//
//  XBTShareRecordCell.m
//  CheBaoJinRong
//
//  Created by apple on 2018/6/28.
//  Copyright © 2018年 apple. All rights reserved.
//

#import "XBTShareRecordCell.h"
#import "NSDate+DM.h"

@interface XBTShareRecordCell ()
@property (weak, nonatomic) IBOutlet UILabel *phoneLabel;
@property (weak, nonatomic) IBOutlet UILabel *moneyLanel;
@property (weak, nonatomic) IBOutlet UILabel *timeLabel;
    
@end

@implementation XBTShareRecordCell

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
}

- (void)setCellModel:(DMDataModel *)cellModel
{
    _cellModel = cellModel;
    
    self.phoneLabel.text = cellModel.cellPhone;
    self.moneyLanel.text = [NSString stringWithFormat:@"%.2f",cellModel.awardAmount];
    self.timeLabel.text = [NSDate stringWithTimeInterval:cellModel.createTime dateFormat:@"yyyy-MM-dd"];
    
    
}
@end
