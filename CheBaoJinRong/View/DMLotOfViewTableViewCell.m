//
//  DMLotOfViewTableViewCell.m
//  CheBaoJinRong
//
//  Created by apple on 2018/5/16.
//  Copyright © 2018年 apple. All rights reserved.
//

#import "DMLotOfViewTableViewCell.h"
#import "NSDate+DM.h"

@interface DMLotOfViewTableViewCell ()

@property (weak, nonatomic) IBOutlet UILabel *moneyLabel;
@property (weak, nonatomic) IBOutlet UILabel *minCanUseLabel;
@property (weak, nonatomic) IBOutlet UILabel *useTimeCountLabel;
@property (weak, nonatomic) IBOutlet UILabel *expirationDateLabel;

@end

@implementation DMLotOfViewTableViewCell

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
}

- (void)setCellModel:(DMMyHongBaoModel *)cellModel
{
    _cellModel = cellModel;
    
    NSString *couponTypeStr = nil;
    
    switch (cellModel.couponType) {
        case 0:
            couponTypeStr = @"加息券";
            break;
        case 2:
            couponTypeStr = @"出借红包";
            break;
        case 4:
            couponTypeStr = @"现金券";
            break;

        default:
            break;
    }
    
    self.moneyLabel.text = [NSString stringWithFormat:@"%@元\n%@",cellModel.couponAmount,couponTypeStr];
    self.minCanUseLabel.text = [NSString stringWithFormat:@"满%@元使用",cellModel.useMinMoney];
    self.useTimeCountLabel.text = [NSString stringWithFormat:@"出借%@天以上可用",cellModel.useqx];
    NSString *dateStr = [NSDate stringWithTimeInterval:cellModel.expirationDate dateFormat:@"yyyy-MM-dd"];
    self.expirationDateLabel.text = [NSString stringWithFormat:@"%@前使用",dateStr];
}

- (void)setCoupModel:(DMMyCouponModel *)coupModel
{
    _coupModel = coupModel;
    NSString *couponTypeStr = nil;
    
    switch (coupModel.couponType) {
        case 1:
            couponTypeStr = @"红包";
            break;
        case 2:
            couponTypeStr = @"推荐奖励";
            break;
            
        default:
            break;
    }
    self.moneyLabel.text = [NSString stringWithFormat:@"%@元\n%@",coupModel.couponAmount,couponTypeStr];
    self.minCanUseLabel.text = [NSString stringWithFormat:@"满%@元使用",coupModel.useMinMoney];
    self.useTimeCountLabel.text = [NSString stringWithFormat:@"出借%@天以上可用",coupModel.useqx];
    NSString *dateStr = [NSDate stringWithTimeInterval:coupModel.expirationDate dateFormat:@"yyyy-MM-dd"];
    self.expirationDateLabel.text = [NSString stringWithFormat:@"%@前使用",dateStr];
}

@end
