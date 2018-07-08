//
//  RealNameAuthenticationVController.h
//  CheBaoJinRong
//
//  Created by apple on 2018/5/16.
//  Copyright © 2018年 apple. All rights reserved.
//

//#import <UIKit/UIKit.h>
#import "XBTBaseController.h"

typedef NS_ENUM(NSInteger, RealAndTransactionType) {
    
    RealNameAuthentication,
    TransactionPassWord
    
};

@interface RealNameAuthenticationVController : XBTBaseController

@property (nonatomic, assign)RealAndTransactionType  type;

@end
