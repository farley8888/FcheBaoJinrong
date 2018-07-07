//
//  DMMatch.m
//  正则表达式
//
//  Created by Jason on 15/11/2.
//  Copyright © 2015年 www.jizhan.com. All rights reserved.
//

#import "XBTMatch.h"

@implementation XBTMatch

+ (BOOL)isInteger:(NSString *)integer
{
    return [self mactch:integer regex:@"\\d+"];
}

+ (BOOL)isSFZ:(NSString *)sfz
{
    if (sfz.length != 18) {
        return NO;
    }
//    return [self mactch:sfz regex:@"[1-9]\\d{5}\\d{4}(([0][1-9])|([1][0-2]))(([0-2][1-9])|([3][0-1]))\\d{4}"];
    return [self mactch:sfz regex:@"\\d{15}$|\\d{18}$|(\\d{17}(\\d|X|x))"];
}

+ (BOOL)isPhoneNum:(NSString *)num
{
    if (num.length != 11) {
        return NO;
    }
    return [self mactch:num regex:@"(13[0-9]{9})|(14[579][0-9]{8})|(15([0-3]|[5-9])[0-9]{8})|(17([0-3]|[5-8])[0-9]{8})|(18[0-9]{9})"];
}

+ (BOOL)isEmail:(NSString *)email
{
    return [self mactch:email regex:@"[A-Z0-9a-z._%+-]+@[A-Za-z0-9.-]+\\.[A-Za-z]{2,4}"];
}

+ (BOOL)isPassword:(NSString *)password
{
    return [self mactch:password regex:@"[0-9A-Za-z\x21-\x7e]{6,12}"];
}

+ (BOOL)isCGFloat:(NSString *)f
{
    return [self mactch:f regex:@"^\\d+(\\.\\d+)?$"];
}

+ (BOOL)isMoney:(NSString *)money
{
    return [self mactch:money regex:@"^\\d{1,9}(\\.\\d{0,2})?$"];
}

+ (BOOL) isContinuityNumber:(NSString *)str
{
    return [self mactch:str regex:@"^(?=.*\\d+)(?!.*?([\\d])\\1{5})[\\d]{6}$"];
}

+ (BOOL)mactch:(NSString *)str regex:(NSString *)regex
{
    NSRegularExpression *reg = [NSRegularExpression regularExpressionWithPattern:regex options:NSRegularExpressionCaseInsensitive error:nil];
    NSArray *matches = [reg matchesInString:str options:NSMatchingReportCompletion range:NSMakeRange(0, str.length)];
    return matches.count;
}

@end
