//
//  UserTool.m
//  Wanyingjinrong
//
//  Created by Jason on 15/11/17.
//  Copyright © 2015年 www.jizhan.com. All rights reserved.
//

#import "XBTUserTool.h"
#import "NSUserDefaults+Extension.h"
#import "XBTAES.h"
#import "XBTDefine.h"
#import "SelectVCTool.h"

NSString* const CurrentLoginUser = @"CurrentLoginUser";//保存当前登录用户的key
NSString* const PASSWORD = @"jd8123&&%sd23921hdasd";//对用户密码加密的密语
#define Device [[[UIDevice currentDevice] identifierForVendor] UUIDString]

@implementation XBTUserTool


+ (void)login:(XBTUser *)user
{
    if (user.password.length==0||user.userName.length==0||user.token.length==0) return;
    NSString *password =  user.password;
    NSDictionary *params = @{@"userName":user.userName,
                             @"pwd":password,
                             };
    DMWeakSelf
    [YBHttpTool postDataDifference:@"login" params:params success:^(id  _Nullable obj) {
        [XBTProgressHUD hideHUD];
        if (obj != nil) {
            XBTStateModel *model = [XBTStateModel mj_objectWithKeyValues:obj[@"state"]];
            
            if (model.status == ResultStatusSuccess) {
                [XBTProgressHUD showSuccess:@"登录成功"];
                XBTUser *userModel = [XBTUser mj_objectWithKeyValues:obj];
                UserManager *userManager = [UserManager sharedManager];
                userManager.user = userModel;
                userManager.user.password = password;
                //把user保存到本地
                [XBTUserTool saveUser:user];
                 [SelectVCTool selectVC];
//                [kNotificationCenter postNotificationName:@"" object:nil];
            }
                //else if (obj.result==108) {//手机号或者密码错误
//            [[UIAlertView alertWithTitle:@"请重新登陆" message:nil buttonIndex:^(NSInteger index) {
//                if (index==0) {
//                    [kNotificationCenter postNotificationName:kLogoutNotification object:nil];
//                }
//            } cancelButtonTitle:@"好" otherButtonTitles:nil] show];
//        } else if (obj.result==119 || obj.result == 123) {//用户被锁定
//            [[UIAlertView alertWithTitle:@"请重新登陆" message:nil buttonIndex:^(NSInteger index) {
//                if (index==0) {
//                    [kNotificationCenter postNotificationName:kLogoutNotification object:nil];
//                }
//            } cancelButtonTitle:@"好" otherButtonTitles:nil] show];
//        }else{
//
//            dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(1 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
//                [weakSelf login:user];
//            });
        }
//        [kNotificationCenter postNotificationName:@"autoLoginNotification" object:nil];
        
    } failure:^(NSError *error) {
    }];
}


+ (void)saveUser:(XBTUser *)user
{
    [self encryptUser:user];
    NSData *data = [NSKeyedArchiver archivedDataWithRootObject:user];
    
    [NSUserDefaults saveObject:data key:CurrentLoginUser];
}

+ (XBTUser *)getCurrentLoginUser
{
    NSData *data = [NSUserDefaults getObjectForKey:CurrentLoginUser];
    if (!data) return nil;
    XBTUser *user = [NSKeyedUnarchiver unarchiveObjectWithData:data];
    [self decryptUser:user];
    return user;
}

//注销当前用户
+ (void)logoutCurrentUser
{
    NSData *data = [NSUserDefaults getObjectForKey:CurrentLoginUser];
    XBTUser *user = [NSKeyedUnarchiver unarchiveObjectWithData:data];
    user.password = @"";
    user.token = @"";
    NSData *data2 = [NSKeyedArchiver archivedDataWithRootObject:user];
    
    [NSUserDefaults saveObject:data2 key:CurrentLoginUser];
}

//对user加密
+ (void)encryptUser:(XBTUser *)user
{
    user.password = [XBTAES encrypt:user.password password:PASSWORD];
}

//对user解密
+ (void)decryptUser:(XBTUser *)user
{
    user.password = [XBTAES decrypt:user.password password:PASSWORD];
}


@end