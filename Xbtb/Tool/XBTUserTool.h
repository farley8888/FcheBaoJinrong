//
//  UserTool.h
//  Wanyingjinrong
//
//  Created by Jason on 15/11/17.
//  Copyright © 2015年 www.jizhan.com. All rights reserved.
//

#import <Foundation/Foundation.h>

#import "XBTUser.h"

extern NSString* const PASSWORD;

@interface XBTUserTool : NSObject

//注销当前用户
+ (void)logoutCurrentUser;

+ (XBTUser *)getCurrentLoginUser;

+ (void)encryptUser:(XBTUser *)user;
+ (void)decryptUser:(XBTUser *)user;

+ (void)login:(XBTUser *)user;
+ (void)saveUser:(XBTUser *)user;

@end
