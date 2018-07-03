//
//  DMMyCouponModel.h
//  CheBaoJinRong
//
//  Created by apple on 2018/5/29.
//  Copyright © 2018年 apple. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface DMMyCouponModel : NSObject
//couponAmount = 20;
@property (nonatomic, copy) NSString *couponAmount;
//couponStatus = 2;
//couponType = 2;
@property (nonatomic, assign) NSInteger couponType;
//expirationDate = 1529564036000;
@property (nonatomic, assign) unsigned long long expirationDate;
//id = 26;
@property (nonatomic, assign) NSInteger id;
//useMinMoney = 3000;
@property (nonatomic, copy) NSString *useMinMoney;
//useqx = 30;
@property (nonatomic, copy) NSString *useqx;
@end
