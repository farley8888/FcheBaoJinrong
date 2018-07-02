//
//  NSString+DMMatch.m
//  DMUnits
//
//  Created by 尚往文化 on 17/9/14.
//  Copyright © 2017年 DMing. All rights reserved.
//

#import "NSString+DMMatch.h"

@implementation NSString (DMMatch)

- (BOOL)isSFZ
{
    if (self.length!=18 || self.length!=15) {
        return NO;
    }
    return [self mactchForRegex:@"\\d{15}$|\\d{18}$|(\\d{17}(\\d|X|x))"];
}

- (BOOL)isInteger
{
    return [self mactchForRegex:@"\\d+"];
}

- (BOOL)isPhoneNum
{
    if (self.length != 11) {
        return NO;
    }
    return [self mactchForRegex:@"(13[0-9]{9})|(14[579][0-9]{8})|(15([0-3]|[5-9])[0-9]{8})|(17([0-3]|[5-8])[0-9]{8})|(18[0-9]{9})"];
}

- (BOOL)isEmail
{
    return [self mactchForRegex:@"[A-Z0-9a-z._%+-]+@[A-Za-z0-9.-]+\\.[A-Za-z]{2,4}"];
}

- (BOOL)mactchForRegex:(NSString *)regex
{
    NSRegularExpression *reg = [NSRegularExpression regularExpressionWithPattern:regex options:NSRegularExpressionCaseInsensitive error:nil];
    NSArray *matches = [reg matchesInString:self options:NSMatchingReportCompletion range:NSMakeRange(0, self.length)];
    return matches.count;
}

@end
