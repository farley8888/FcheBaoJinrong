//
//  DMMyHongBaoModel.h
//  CheBaoJinRong
//
//  Created by apple on 2018/5/21.
//  Copyright © 2018年 apple. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface DMMyHongBaoModel : NSObject

//couponAmount = 8;
/**  红包金额  **/
@property (nonatomic, copy) NSString *couponAmount;
//couponStatus = 3;
/**  红包状态  **/
@property (nonatomic, assign) NSInteger couponStatus;
//couponType = 2;
/**  红包类型  1：红包 2：推荐奖励**/
@property (nonatomic, assign) NSInteger couponType;
//expirationDate = 1529405109000;
/**  到期时间  **/
@property (nonatomic, assign) unsigned long long expirationDate;
//id = 25;
//useMinMoney = 1000;
/**  最少金额可使用  **/
@property (nonatomic, copy) NSString *useMinMoney;
//useqx = 30;
/**  使用期限  **/
@property (nonatomic, copy) NSString *useqx;

@end
