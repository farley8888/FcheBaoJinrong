//
//  NSString+DMMatch.h
//  DMUnits
//
//  Created by 尚往文化 on 17/9/14.
//  Copyright © 2017年 DMing. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface NSString (DMMatch)

- (BOOL)isSFZ;
- (BOOL)isInteger;
- (BOOL)isEmail;
- (BOOL)isPhoneNum;


/**
 @param regex 正则表达式
 */
- (BOOL)mactchForRegex:(NSString *)regex;

@end
