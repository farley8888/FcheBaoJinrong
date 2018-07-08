//
//  DMInvestmentModel.h
//  CheBaoJinRong
//
//  Created by apple on 2018/5/18.
//  Copyright © 2018年 apple. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "DMHomePageModel.h"
#import "XBTPageModel.h"

//@interface DMDataModel : NSObject
/** 年化利率 **/
//@property (nonatomic, assign) CGFloat annualRate;
/** 借款金额 **/
//@property (nonatomic, assign) CGFloat borrowAmount;
/**
 * 借款状态（1，申请中，2，初审通过，3，招标中，4，复审中，5，还款中，6，已还款，7，借款失败(初审)，8复审失败，9流标，10，
 * 复审处理中,11 流标或复审不通过处理中）
 **/
//@property (nonatomic, assign) NSInteger borrowStatus;
//"borrowTitle": "测试0001",
//"borrowType": 1,
//"createTime": 1526547832000,
//"deadline": 30,
//"deadlineType": 1,
//"hasBorrowAmount": 100.00,
//"id": 1,
//"investStartTime": 1526547960000,
//"maxInvestAmount": 0.00,
//"mayCast": 99900.00,
//"minInvestAmount": 100.00,
//"progress": 0.001000,
//"raisingPeriod": 7,
//"remainTime": 0,
//"repayType": 1
//@end

@interface DMInvestmentModel : NSObject
//"borrowhqll": "7.8", 利率
@property (nonatomic, assign) CGFloat borrowhqll;
@property (nonatomic, strong) XBTStateModel *state;

@property (nonatomic, strong)NSMutableArray<Data1 *> *data;
@property (nonatomic, strong) XBTPageModel *page;

@end
