//
//  DMWithdrawCashModel.h
//  CheBaoJinRong
//
//  Created by apple on 2018/5/21.
//  Copyright © 2018年 apple. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface XBTWithdrawCashModel : NSObject

//bankCardNo = 6217002710000684874;
@property (nonatomic, copy) NSString *bankCardNo;
//cardStatus = 2;
//createTime = 1526893085000;
//id = 5;
//realName = "\U8d75\U516d";
//userId = 4;
//
//createTime = 1526813109000;
//frozenAmount = 200;
//id = 4;
//score = 50;
//usableAmount = "27800.05";
/**  可提现金额  **/
@property (nonatomic, assign) CGFloat usableAmount;
//userId = 4;

@end
