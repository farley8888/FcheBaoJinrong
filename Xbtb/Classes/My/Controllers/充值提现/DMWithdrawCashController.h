//
//  DMwithdrawCashController.h
//  CheBaoJinRong
//
//  Created by apple on 2018/5/16.
//  Copyright © 2018年 apple. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "DMBaseController.h"

typedef NS_ENUM(NSInteger, CashOrRedeem){
    WithdrawCash,   //提现
    Redeem          //赎回
};

@interface DMWithdrawCashController : DMBaseController

@property (nonatomic, assign) CashOrRedeem type;


@end
