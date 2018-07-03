//
//  DMScreenRecordController.h
//  CheBaoJinRong
//
//  Created by apple on 2018/5/31.
//  Copyright © 2018年 apple. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface DMScreenRecordController : UIViewController

@property (nonatomic, assign) NSInteger type;  //1：交易将记录筛选   2：出借记录筛选

@property (nonatomic, copy) void (^selectBlock)(NSString * type);

@end
