//
//  NSURL+UrlStringAutoAdjust.m
//  微金在线
//
//  Created by 首控微金财富 on 2018/1/16.
//  Copyright © 2018年 zhouli. All rights reserved.
//

#import "NSURL+UrlStringAutoAdjust.h"

@implementation NSURL (UrlStringAutoAdjust)

+ (void)load
{
    Method orignalMethod = class_getClassMethod(self, @selector(URLWithString:));
    Method exchangeMethod = class_getClassMethod(self, @selector(ys_URLWithString:));
    method_exchangeImplementations(orignalMethod, exchangeMethod);
}

+ (instancetype)ys_URLWithString:(NSString *)URLString
{
    if (URLString.length > 0) {// 中文转码
        URLString = [URLString stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding];
        return [self ys_URLWithString:URLString];
    }
    return nil;
}
@end
