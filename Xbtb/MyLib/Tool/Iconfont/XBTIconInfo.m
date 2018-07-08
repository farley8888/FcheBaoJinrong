//
//  DMIconInfo.m
//  Iconfont封装
//
//  Created by 尚往文化 on 17/2/10.
//  Copyright © 2017年 DMing. All rights reserved.
//

#import "XBTIconInfo.h"

@implementation XBTIconInfo

- (instancetype)initWithText:(NSString *)text size:(NSInteger)size color:(UIColor *)color {
    if (self = [super init]) {
        self.text = text;
        self.size = size;
        self.color = color;
    }
    return self;
}

+ (instancetype)iconInfoWithText:(NSString *)text size:(NSInteger)size color:(UIColor *)color {
    return [[XBTIconInfo alloc] initWithText:text size:size color:color];
}

@end
