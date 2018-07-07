//
//  DMMyCouponController.h
//  CheBaoJinRong
//
//  Created by apple on 2018/5/29.
//  Copyright © 2018年 apple. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "XBTBaseTableViewController.h"

@interface XBTMyCouponController : XBTBaseTableViewController

@property (nonatomic, copy) void(^selsctCouponBlock)(NSInteger coupID, NSInteger coupType, NSString *coupAmout);

@property (nonatomic, copy) NSString *moneyAmout;   //输入的金额
@property (nonatomic, copy) NSString *deadlin;      //期限
@property (nonatomic, copy) NSString *deadlineType; //类型

@end
