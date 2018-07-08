//
//  RegularModel.m
//  CheBaoJinRong
//
//  Created by apple on 2018/5/28.
//  Copyright © 2018年 apple. All rights reserved.
//

#import "RegularModel.h"

@implementation RegularModel

- (NSString *)interestBearingType
{
    NSString *typeString = nil;
    switch (self.interestBearingTime) {
        case 1:
            typeString = @"满标计息";
            break;
        case 2:
            typeString = @"次日计息";
            break;
        case 3:
            typeString = @"即时计息";
            break;
            
        default:
            typeString = @"未知";
            break;
    }
    
    return  typeString;
}

- (NSString *)repayTypeString
{
    NSString *repStr = nil;
//    1，到期还本付息，2，先息后本，到期还本,3等额还款）
    
    switch (self.repayType) {
        case 1:
            repStr = @"到期还本付息";
            break;
        case 2:
            repStr = @"先息后本";
            break;
        case 3:
            repStr = @"等额还款";
            break;
            
        default:
            repStr = @"未知";
            break;
    }
    return repStr;
}

- (NSString *)minInvestString
{
    return [NSString stringWithFormat:@"%.2f元",self.minInvestAmount];
}

@end
