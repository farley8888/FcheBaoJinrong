//
//  UserTool.m
//  Wanyingjinrong
//
//  Created by Jason on 15/11/17.
//  Copyright © 2015年 www.jizhan.com. All rights reserved.
//

#import "DMUserTool.h"
#import "NSUserDefaults+Extension.h"
#import "DMAES.h"

NSString* const CurrentLoginUser = @"CurrentLoginUser";//保存当前登录用户的key
NSString* const PASSWORD = @"jd8123&&%sd23921hdasd";//对用户密码加密的密语

@implementation DMUserTool

+ (void)saveUser:(DMUser *)user
{
    [self encryptUser:user];
    NSData *data = [NSKeyedArchiver archivedDataWithRootObject:user];
    
    [NSUserDefaults saveObject:data key:CurrentLoginUser];
}

+ (DMUser *)getCurrentLoginUser
{
    NSData *data = [NSUserDefaults getObjectForKey:CurrentLoginUser];
    if (!data) return nil;
    DMUser *user = [NSKeyedUnarchiver unarchiveObjectWithData:data];
    [self decryptUser:user];
    return user;
}

//注销当前用户
+ (void)logoutCurrentUser
{
    NSData *data = [NSUserDefaults getObjectForKey:CurrentLoginUser];
    DMUser *user = [NSKeyedUnarchiver unarchiveObjectWithData:data];
    user.password = @"";
    user.token = @"";
    NSData *data2 = [NSKeyedArchiver archivedDataWithRootObject:user];
    
    [NSUserDefaults saveObject:data2 key:CurrentLoginUser];
}

//对user加密
+ (void)encryptUser:(DMUser *)user
{
    user.password = [DMAES encrypt:user.password password:PASSWORD];
}

//对user解密
+ (void)decryptUser:(DMUser *)user
{
    user.password = [DMAES decrypt:user.password password:PASSWORD];
}


@end
