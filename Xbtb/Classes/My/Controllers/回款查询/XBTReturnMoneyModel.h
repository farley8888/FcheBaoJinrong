//
//  DMReturnMoneyModel.h
//  CheBaoJinRong
//
//  Created by apple on 2018/5/21.
//  Copyright © 2018年 apple. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface XBTReturnMoneyModel : NSObject

//borrowId = 4;
/** 借款ID **/
@property (nonatomic, copy) NSString *borrowId;
//borrowTitle = "\U65b0\U624b\U6807008";
@property (nonatomic, copy) NSString *borrowTitle;
//capitalAmount = "792.33";
/**  总本金  **/
@property (nonatomic, assign) CGFloat capitalAmount;
//createTime = 1526817225000;
@property (nonatomic, assign) unsigned long long createTime;
//feeAmount = "9.17";
/**  期间费用  **/
@property (nonatomic, assign) CGFloat feeAmount;
//id = 1;
//investId = 4;
//investorId = 4;
//numOfPeriods = 1;
//ordId = 20180520195345161169896;
@property (nonatomic, copy) NSString *ordId;
//peroids = 12;
//profitAmount = "91.67";
@property (nonatomic, assign) CGFloat profitAmount;
//realRepayTime = 1526819223000;
@property (nonatomic, assign) unsigned long long realRepayTime;
//remainCapitalAmount = "9207.67";
/**  剩余本金  **/
@property (nonatomic, assign) CGFloat remainCapitalAmount;
//remainProfitAmount = "516.33";
/**  剩余利息  **/
@property (nonatomic, assign) CGFloat remainProfitAmount;
//repayDate = 1529424000000;
/**  还款时间  **/
@property (nonatomic, assign) unsigned long long repayDate;
//repayStatus = 2;
/**是否参与债转0未1已**/
//ynclaim = 0;


@end
