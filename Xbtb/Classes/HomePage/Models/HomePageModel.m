//
//  HomePageModel.m
//  CheBaoJinRong
//
//  Created by apple on 2018/5/18.
//  Copyright © 2018年 apple. All rights reserved.
//

#import "HomePageModel.h"

@implementation Banners
@end

@implementation Data4
@end

@implementation Data1
@end

@implementation HomePageModel

+ (NSDictionary *)mj_objectClassInArray
{
    return @{@"banners":[Banners class],
             @"data4":[Data4 class],
             @"data2":[Data1 class]
             };
}



@end
