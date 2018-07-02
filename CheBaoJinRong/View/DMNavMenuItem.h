//
//  DMNavMenuItem.h
//  XHGY_Agent
//
//  Created by 尚往文化 on 17/4/21.
//  Copyright © 2017年 DMing. All rights reserved.
//

#import <Foundation/Foundation.h>

typedef NS_ENUM(NSInteger, DMNavMenuItemType) {//状态
//    DMNavMenuItemTypeAllType = 0,               //全部
    DMNavMenuItemTypePendingPayment = 0,        //待付款  0
    DMNavMenuItemTypeGoodsToBeReceived,         //待收货  1
    DMNavMenuItemTypeCompleted,                 //已完成  2
    DMNavMenuItemTypeToBeEvaluated,             //待评价
    DMNavMenuItemTypePendingDelivery,           //待发货  4
    DMNavMenuItemTypeAllType                    //全部
    
    
};

@interface DMNavMenuItem : DMArchive

@property (nonatomic, copy) NSString *title;
@property (nonatomic, copy) NSString *cls;
@property (nonatomic, assign) DMNavMenuItemType type;
@property (nonatomic, assign, readonly) CGFloat width;
@property (nonatomic, assign) BOOL hidden;


+ (instancetype)itemWithTitle:(NSString *)title type:(DMNavMenuItemType)type cls:(Class)cls;



@end
