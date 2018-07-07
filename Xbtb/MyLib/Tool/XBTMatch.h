//
//  DMMatch.h
//  正则表达式
//
//  Created by Jason on 15/11/2.
//  Copyright © 2015年 www.jizhan.com. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface XBTMatch : NSObject


/**
 判断是否为整数
 */
+ (BOOL)isInteger:(NSString *)integer;

/**
 *  判断是否为身份证号码
 */
+ (BOOL)isSFZ:(NSString *)sfz;

/**
 *  判断是否为金额
 */
+ (BOOL)isMoney:(NSString *)money;

/**
 *  判断是否为手机号码
 */
+ (BOOL)isPhoneNum:(NSString *)num;

/**
 *  判断是否为邮箱
 */
+ (BOOL)isEmail:(NSString *)email;

/**
 *  判断密码格式是否正确（6-12位数字与字母组合）
 */
+ (BOOL)isPassword:(NSString *)password;

/**
 *  判断是否为非负的浮点数
 */
+ (BOOL)isCGFloat:(NSString *)f;

/**
 * 判断是否为连续数字
 */
+ (BOOL)isContinuityNumber:(NSString *)str;

@end
