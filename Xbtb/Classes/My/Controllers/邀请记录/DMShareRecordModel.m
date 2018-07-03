//
//  DMShareRecordModel.m
//  CheBaoJinRong
//
//  Created by apple on 2018/6/28.
//  Copyright © 2018年 apple. All rights reserved.
//

#import "DMShareRecordModel.h"

@implementation DMDataModel
    
@end


@implementation DMShareRecordModel

+(NSDictionary *)mj_objectClassInArray
{
    return @{@"data":[DMDataModel class]};
}
    
@end
