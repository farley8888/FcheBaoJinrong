//
//  UserManager.h
//  Wanyingjinrong
//
//  Created by Jason on 15/11/13.
//  Copyright © 2015年 www.jizhan.com. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "XBTUser.h"

@interface UserManager : NSObject

@property (nonatomic, strong) XBTUser *user;

@property (nonatomic, assign, class, readonly) BOOL isLogin;
@property (nonatomic, assign, class, readonly) BOOL giveUpLongin;

@property (nonatomic, copy) NSString *gesString;    //手势密码

@property (nonatomic, assign) BOOL isOpenGes;       //是否开启手势密码

+ (UserManager *)sharedManager;

@end
