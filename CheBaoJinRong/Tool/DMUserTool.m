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
#import "DMDefine.h"
#import "SelectVCTool.h"

NSString* const CurrentLoginUser = @"CurrentLoginUser";//保存当前登录用户的key
NSString* const PASSWORD = @"jd8123&&%sd23921hdasd";//对用户密码加密的密语
#define Device [[[UIDevice currentDevice] identifierForVendor] UUIDString]

@implementation DMUserTool


+ (void)login:(DMUser *)user
{
    if (user.password.length==0||user.userName.length==0||user.token.length==0) return;
    NSString *password =  user.password;
    NSDictionary *params = @{@"userName":user.userName,
                             @"pwd":password,
                             };
    DMWeakSelf
    [YBHttpTool postDataDifference:@"login" params:params success:^(id  _Nullable obj) {
        [MBProgressHUD hideHUD];
        if (obj != nil) {
            DMStateModel *model = [DMStateModel mj_objectWithKeyValues:obj[@"state"]];
            
            if (model.status == ResultStatusSuccess) {
                [MBProgressHUD showSuccess:@"登录成功"];
                DMUser *userModel = [DMUser mj_objectWithKeyValues:obj];
                UserManager *userManager = [UserManager sharedManager];
                userManager.user = userModel;
                userManager.user.password = password;
                //把user保存到本地
                [DMUserTool saveUser:user];
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
