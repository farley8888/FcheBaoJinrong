//
//  DMPurchaseRecordModel.h
//  CheBaoJinRong
//
//  Created by apple on 2018/5/28.
//  Copyright © 2018年 apple. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface XBTPurchaseRecordModel : NSObject

//borrowId = 1;
//borrowStatus = 0;
//cellPhone = "1*********5";
//deadline = 0;
//deadlineType = 0;
//id = 1;
//investAmount = 100;
@property (nonatomic, assign) CGFloat investAmount;
//investTime = 1527233154000;
@property (nonatomic, assign) unsigned long long investTime;
//investWay = 1;
//investorId = 1;
//isClaim = 0;
//numOfPeroids = 0;
//ordDate = 1527177600000;
//ordId = 20180525152554515301987;
//peroids = 0;
//realAmount = 100;
@property (nonatomic, assign) CGFloat realAmount;
//realName = "\U5f20\U5eb7\U661f";
//repayStatus = 0;
//repayType = 0;
//result = 3;
//transferAmount = 0;
//userName = 18676344375;
@property (nonatomic, copy) NSString *userName;
@property (nonatomic, copy) NSString *userNameString;

@end
