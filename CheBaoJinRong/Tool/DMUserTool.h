//
//  UserTool.h
//  Wanyingjinrong
//
//  Created by Jason on 15/11/17.
//  Copyright © 2015年 www.jizhan.com. All rights reserved.
//

#import <Foundation/Foundation.h>

#import "DMUser.h"

extern NSString* const PASSWORD;

@interface DMUserTool : NSObject

//注销当前用户
+ (void)logoutCurrentUser;

+ (DMUser *)getCurrentLoginUser;

+ (void)encryptUser:(DMUser *)user;
+ (void)decryptUser:(DMUser *)user;

+ (void)login:(DMUser *)user;
+ (void)saveUser:(DMUser *)user;

@end
