//
//  DMSubstitutePaymentCell.h
//  CheBaoJinRong
//
//  Created by apple on 2018/5/15.
//  Copyright © 2018年 apple. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "DMReturnMoneyModel.h"
#import "DMTransactionRecordModel.h"
#import "DMInvestmentRecordsModel.h"

typedef NS_ENUM(NSInteger, CellType) { //不同类型，对应不同颜色
    
    InvestmentRecordsCell,      //出借记录cell类型
    TransactionRecordCell,      //交易记录cell类型
    SubstitutePaymentCell,      //回款-待付款cell类型
    ReceivablesCell             //回款-已收款cell类型
};


@interface DMSubstitutePaymentCell : UITableViewCell

@property(nonatomic,assign)CellType type;

@property (nonatomic, strong) DMReturnMoneyModel *cellReturnModel;
@property (nonatomic, strong) DMTransactionRecordModel *cellTransaModel;
@property (nonatomic, strong) DMInvestmentRecordsModel *cellInvestModel;


@end
