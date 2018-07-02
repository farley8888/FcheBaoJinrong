//
//  DMPurchaseRecordModel.m
//  CheBaoJinRong
//
//  Created by apple on 2018/5/28.
//  Copyright © 2018年 apple. All rights reserved.
//

#import "DMPurchaseRecordModel.h"

@implementation DMPurchaseRecordModel


- (NSString *)userNameString
{
    NSString *string = [self.userName stringByReplacingCharactersInRange:NSMakeRange(3, 4) withString:@"****"];
    return string;
}


@end
