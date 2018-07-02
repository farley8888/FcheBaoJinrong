//
//  DMRegularModel.h
//  CheBaoJinRong
//
//  Created by apple on 2018/5/28.
//  Copyright © 2018年 apple. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface DMRegularModel : NSObject
//annualRate = "10.8";
/**  年利率  **/
@property (nonatomic, assign) CGFloat annualRate;

//borrowAmount = 170000;
/**  借款金额  **/
@property (nonatomic, assign) CGFloat borrowAmount;
//borrowNo = 20180525A001;
//borrowStatus = 3;
/**  标的状态 2：未开标  3：已开标 **/
@property (nonatomic, assign) NSInteger borrowStatus;
//borrowTitle = "\U8f66\U8f66\U5b9d20180525A001";
/**  借款标题  **/
@property (nonatomic, copy) NSString *borrowTitle;

/**  借款类型  **/
@property (nonatomic, assign) NSInteger borrowType;
//borrowerId = 16;
@property (nonatomic, copy) NSString *borrowerId;
//clockAmount = "-100";
@property (nonatomic, copy) NSString *clockAmount;
//collateralInfos = "<p>\U5ba2\U6237\U540d\U4e0b\U4e30\U7530\U8f66\Uff0c \U8d2d\U4e70\U4ef750\U4e07\Uff0c\U8bc4\U4f30\U4ef726\U4e07\Uff0c\U501f\U6b3e17\U4e07\Uff0c\U8f66\U8f86\U72b6\U51b5\U826f\U597d\U3002<br></p>";
/**  抵押品  **/
@property (nonatomic, copy) NSString *collateralInfos;
//createId = 1;
//createTime = 1527219705000;
/**  期限数量  **/
@property (nonatomic, assign) NSInteger deadline;
/** deadlineType 1天  2月  ,期限类型  **/
@property (nonatomic, assign) NSInteger deadlineType;
//firstAuditId = 1;
/**  保证类型  **/
@property (nonatomic, copy) NSString *guaranteetype;
//hasBorrowAmount = 100;
/**  已借出钱数  **/
@property (nonatomic, assign) CGFloat hasBorrowAmount;
//id = 1;
@property (nonatomic, copy) NSString *id;

/**  起息类型 1：满标计息 2：次日计息 3：及时计息 **/
@property (nonatomic, assign) NSInteger interestBearingTime;
/**  满标时间  **/
@property (nonatomic, assign) unsigned long long fullTime;
/**  起息类型文字  **/
@property (nonatomic, copy) NSString *interestBearingType;

//introductionInfos = "<p>\U501f\U6b3e\U4eba\U73b0\U5728\U5728\U6df1\U5733\U7ecf\U8425\U706b\U9505\U5e97\U8001\U677f\U4e3b\U8981\U505a\U9910\U996e\U53ca\U76f8\U5173\U670d\U52a1(\U4f9d\U6cd5\U987b\U7ecf\U6279\U51c6\U7684\U9879\U76ee\Uff0c\U7ecf\U76f8\U5173\U90e8\U95e8\U6279\U51c6\U540e\U65b9\U53ef\U5f00\U5c55\U6d3b\U52a8\Uff09\U516c\U53f8\U5458\U5de524\U4eba \U6708\U5e73\U5747\U8425\U4e1a\U989d316\U4e07\U6bcf\U6708\U51c0\U6536\U5165117\U4e07\Uff0c\U5ba2\U6237\U7ecf\U8425\U4e1a\U52a1\U6536\U5165\U7a33\U5b9a\Uff0c\U98ce\U63a7\U53ef\U63a7\Uff0c\U672c\U6b21\U501f\U6b3e\U7528\U9014\U7528\U4e8e\U5e97\U9762\U5f00\U5f20\U3002<br></p>";
/**  产品介绍  **/
@property (nonatomic, copy) NSString *introductionInfos;
//investStartTime = 1527231600000;
//isClaim = 0;
//maxInvestAmount = 0;
/**  最、大出借金额  **/
@property (nonatomic, assign) CGFloat maxInvestAmount;
//minInvestAmount = 100;
/**  最小出借金额  **/
@property (nonatomic, assign) CGFloat minInvestAmount;
/**  最小起投金额文字  **/
@property (nonatomic, copy) NSString *minInvestString;

//ordId = 17020180525145106208389280;
//personBorrowerId = 3;
//raisingPeriod = 7;
/**  剩余时间 （秒为单位) **/
@property (nonatomic, assign) NSInteger remainTime;

/** 还款方式（1，一次性还款，2，为按月付息，到期还本,3等额本息） **/
@property (nonatomic, assign) NSInteger repayType;

/**  还款方式文字  **/
@property (nonatomic, copy) NSString *repayTypeString;

//riskControlInfos = "<p>\U501f\U6b3e\U4eba\Uff1a\U90b9\U7d20\U743c</p><p>\U5e74\U9f84\Uff1a54\U5c81</p><p>\U5a5a\U59fb\Uff1a\U5df2\U5a5a</p><p>\U7c4d\U8d2f\Uff1a\U5e7f\U4e1c\U6df1\U5733</p><p>\U5f81\U4fe1\Uff1a\U826f\U597d</p><p>\U6536\U5165\U60c5\U51b5\Uff1a\U6bcf\U6708\U51c0\U6536\U5165100\U4e07\U4ee5\U4e0a</p><p>\U501f\U6b3e\U7528\U9014\Uff1a\U5e97\U9762\U6269\U5f20</p>";
@property (nonatomic, copy) NSString *riskControlInfos;
//riskrank = 1;



@end
