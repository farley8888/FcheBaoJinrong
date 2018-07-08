//
//  XBTSubstitutePaymentCell.m
//  CheBaoJinRong
//
//  Created by apple on 2018/5/15.
//  Copyright © 2018年 apple. All rights reserved.
//

#import "XBTSubstitutePaymentCell.h"
#import "NSDate+DM.h"

@interface XBTSubstitutePaymentCell ()

@property (weak, nonatomic) IBOutlet UILabel *titelLabel;
@property (weak, nonatomic) IBOutlet UILabel *timeLabel;
@property (weak, nonatomic) IBOutlet UILabel *amoutLabel;

@property (weak, nonatomic) IBOutlet UILabel *benxiLabel;

@end

@implementation XBTSubstitutePaymentCell

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
}

- (void)setUI
{
    switch (self.type) {
        case InvestmentRecordsCell: //出借记录cell类型
            
            break;
        case TransactionRecordCell: //交易记录cell类型
            
            break;
        case SubstitutePaymentCell: //回款-待付款cell类型
            
            break;
            
        default:
            break;
    }
    
}

- (void)setCellReturnModel:(XBTReturnMoneyModel *)cellReturnModel
{
    _cellReturnModel = cellReturnModel;
    
    self.titelLabel.text = cellReturnModel.borrowTitle;
    if (self.type == SubstitutePaymentCell) {
        self.timeLabel.text = [NSDate stringWithTimeInterval:cellReturnModel.repayDate dateFormat:@"yyyy-MM-dd HH:mm:ss"];
    }else{
        self.timeLabel.text = [NSDate stringWithTimeInterval:cellReturnModel.realRepayTime dateFormat:@"yyyy-MM-dd HH:mm:ss"];
    }

    self.amoutLabel.text = [NSString stringWithFormat:@"%.2f",(cellReturnModel.capitalAmount + cellReturnModel.profitAmount)];
    self.benxiLabel.text = [NSString stringWithFormat:@"(本:%.2f息:%.2f)",cellReturnModel.capitalAmount,cellReturnModel.profitAmount];
}

- (void)setCellTransaModel:(XBTTransactionRecordModel *)cellTransaModel
{
    _cellTransaModel = cellTransaModel;
    self.timeLabel.text = [NSDate stringWithTimeInterval:cellTransaModel.createTime dateFormat:@"yyyy-MM-dd HH:mm:ss"];
    self.titelLabel.text = cellTransaModel.fundMode;
    self.benxiLabel.text = [NSString stringWithFormat:@"余额：%.2f",cellTransaModel.usableAmount];

    NSString *str = @"";
    NSInteger type = cellTransaModel.operType;
    if (type == 4 || type == 2) {
        str = [NSString stringWithFormat:@"- %.2f",cellTransaModel.operAmount];
        self.amoutLabel.textColor = [UIColor redColor];
    }else if (type == 3 || type == 1){
        str = [NSString stringWithFormat:@"+ %.2f",cellTransaModel.operAmount];
        self.amoutLabel.textColor = kColor(241, 172, 61);
    }else{
        str = [NSString stringWithFormat:@"%.2f",cellTransaModel.operAmount];
    }
    self.amoutLabel.text = str;
}

- (void)setCellInvestModel:(XBTInvestmentRecordsModel *)cellInvestModel
{
    _cellInvestModel = cellInvestModel;
    
    self.timeLabel.text = [NSDate stringWithTimeInterval:cellInvestModel.investTime dateFormat:@"yyyy-MM-dd HH:mm:ss"];
    self.titelLabel.text = cellInvestModel.borrowTitle;
    //借款状态（1，申请中，2，初审通过，3，招标中，4，复审中，5，还款中，6，已还款，7，借款失败(初审)，8复审失败,9流标,10， 复审处理中,11 流标或复审不通过处理中
    
    NSString *string = @"";
    switch (cellInvestModel.borrowStatus) {
        case 1:
            string = @"申请中";
            break;
        case 2:
            string = @"初审通过";
            break;
        case 3:
            string = @"招标中";
            break;
        case 4:
            string = @"复审中";
            break;
        case 5:
            string = @"还款中";
            break;
        case 6:
            string = @"已还款";
            break;
        case 7:
            string = @"借款失败(初审)";
            break;
        case 8:
            string = @"复审失败";
            break;
        case 9:
            string = @"流标";
            break;
        case 10:
            string = @"复审处理中";
            break;
        case 11:
            string = @"流标或复审不通过处理中";
            break;
            
        default:
            break;
    }
    
    self.benxiLabel.text = [NSString stringWithFormat:@"  %@  ",string];
    self.amoutLabel.text = [NSString stringWithFormat:@"%.2f",cellInvestModel.investAmount];
    
}

@end
