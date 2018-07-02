//
//  DMRecordChildModel.m
//  CheBaoJinRong
//
//  Created by apple on 2018/6/1.
//  Copyright © 2018年 apple. All rights reserved.
//

#import "DMRecordChildModel.h"

@implementation DMRecordChildModel

- (NSString *)applyStatusString
{
    NSString *statusString = @"";
    switch (self.applyStatus) {
        case 0:
            statusString = @"  申请中  ";
            break;
        case 1:
            statusString = @"  赎回成功  ";
            break;
        case 2:
            statusString = @"  赎回失败  ";
            break;
            
        default:
            break;
    }
    return statusString;
}

@end
