//
//  SelectVCTool.m
//  CarLoan
//
//  Created by 张殿明 on 2017/9/25.
//  Copyright © 2017年 尚往文化. All rights reserved.
//

#import "SelectVCTool.h"
#import "NSUserDefaults+Extension.h"
#import "LonginController.h"
#import "XBTNavigationController.h"
#import "XBTMainController.h"
#import "XBTFirstTimeController.h"

@implementation SelectVCTool

+ (void)selectVC
{
    UIWindow *window = [UIApplication sharedApplication].keyWindow;
    [window makeKeyAndVisible];
//    BOOL firestStart = [NSUserDefaults getBoolForKey:kNOFirstTimeKey];
//    if (!firestStart) {
    
//        [NSUserDefaults saveBool:YES key:kNOFirstTimeKey];
//        window.rootViewController = [DMFirstTimeController new];
//    }else{
        //        判断是不是旧版本
//        NSString *version = kVersion;
//        NSString *oldVersion = [NSUserDefaults getObjectForKey:kVersionKey];
//        if ([version isEqualToString:oldVersion]) {//同一个版本
        
//            if ([self isLogin]) {
        
                XBTMainController *mainVC = [XBTMainController new];
                window.rootViewController = mainVC;
//            } else {
//                DMNavigationController *nav = [[DMNavigationController alloc] initWithRootViewController:[[LonginController alloc] init]];
//                window.rootViewController = nav;
//            }
//    } //else {//不是同一个版本

//    }
}

/**
 *  判断是否已经登录
 */
+ (BOOL)isLogin
{
    UserManager *manager = [UserManager sharedManager];
    XBTUser *user = manager.user;
    return user.token.length;
//    return 1;
}

@end
