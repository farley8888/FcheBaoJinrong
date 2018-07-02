//
//  BaseEntity.h
//  MobilePaymentOS
//
//  Created by admin on 2018/4/24.
//  Copyright © 2018年 yinsheng. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "MJExtension.h"

@interface BaseEntity : NSObject

+ (instancetype)modelWithDictionary:(NSDictionary *)dictionary;
@end
