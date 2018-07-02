//
//  AppDelegate.m
//  CheBaoJinRong
//
//  Created by ltyj on 2017/12/7.
//  Copyright © 2017年 ltyj. All rights reserved.
//

#import "AppDelegate.h"
#import "SelectVCTool.h"
#import "DMGesturePasswordController.h"
#import "DMNavigationController.h"
#import "DMUserTool.h"
#import <UMCommon/UMCommon.h> //友盟
#import <UMShare/UMShare.h>
#import <UMAnalytics/MobClick.h>

@interface AppDelegate ()

@property (nonatomic, assign) BOOL isGes;

@end

@implementation AppDelegate

- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions {

    [self initWindow];
    [self setUMShare];
    [self setCount];

    return YES;
}

- (void)setCount
{
    [MobClick setScenarioType:E_UM_GAME|E_UM_DPLUS];
}

- (void)setUMShare
{
    [UMConfigure setLogEnabled:YES];//设置打开日志
    [UMConfigure initWithAppkey:@"5b165b4ba40fa354ce0000b8" channel:@"App Store"];
    // UMConfigure 通用设置，请参考SDKs集成做统一初始化。
    // 以下仅列出U-Share初始化部分
    
    // U-Share 平台设置
    [self configUSharePlatforms];
}

- (void)configUSharePlatforms
{
    /* 设置微信的appKey和appSecret */
    [[UMSocialManager defaultManager] setPlaform:UMSocialPlatformType_WechatSession appKey:@"wx7e91f706808db432" appSecret:@"fcb4e308a82cbb9a6f080d560725c5b2" redirectURL:@"http://mobile.umeng.com/social"];
    /*
     * 移除相应平台的分享，如微信收藏
     */
    [[UMSocialManager defaultManager] removePlatformProviderWithPlatformTypes:@[@(UMSocialPlatformType_WechatFavorite)]];
    
    /* 设置分享到QQ互联的appID
     * U-Share SDK为了兼容大部分平台命名，统一用appKey和appSecret进行参数设置，而QQ平台仅需将appID作为U-Share的appKey参数传进即可。
     */
    [[UMSocialManager defaultManager] setPlaform:UMSocialPlatformType_QQ appKey:@"1106938486 "/*设置QQ平台的appID*/  appSecret:nil redirectURL:@"http://mobile.umeng.com/social"];
}

// 支持所有iOS系统
- (BOOL)application:(UIApplication *)application openURL:(NSURL *)url sourceApplication:(NSString *)sourceApplication annotation:(id)annotation
{
    //6.3的新的API调用，是为了兼容国外平台(例如:新版facebookSDK,VK等)的调用[如果用6.2的api调用会没有回调],对国内平台没有影响
    BOOL result = [[UMSocialManager defaultManager] handleOpenURL:url sourceApplication:sourceApplication annotation:annotation];
    if (!result) {
        // 其他如支付等SDK的回调
    }
    return result;
}

- (void)initWindow
{
    self.window = [[UIWindow alloc]initWithFrame:[UIScreen mainScreen].bounds];
    [self.window makeKeyAndVisible];
    [kNotificationCenter addObserver:self selector:@selector(logout) name:kLogoutNotification object:nil];
    [self setupLaunch];
    self.isGes = [self isGesturesPassword];
    //将手势密码保存进单利
    [self getGesStringAndOpen];
    if (self.isGes) {//
        
        DMNavigationController *nav = [[DMNavigationController alloc]initWithRootViewController:[DMGesturePasswordController new]];
        self.window.rootViewController = nav;
    }else{
        self.window.rootViewController = [[UIViewController alloc]init];
        [SelectVCTool selectVC];
    }
}

- (void)setupLaunch
{
    
}

- (void)getGesStringAndOpen
{
    [UserManager sharedManager].user = [DMUserTool getCurrentLoginUser];
    [UserManager sharedManager].gesString = [NSUserDefaults getObjectForKey:GesturesPassword];
    [UserManager sharedManager].isOpenGes = self.isGes;
    if(!self.isGes){
        [DMUserTool login:[UserManager sharedManager].user];
    }
}

- (BOOL)isGesturesPassword
{
    BOOL ges = [NSUserDefaults getBoolForKey:GesturesPasswordOpenOrClose];
    return ges;
}

- (void)logout
{
    UserManager *manager = [UserManager sharedManager];
    manager.user = nil;
    
    dispatch_async(dispatch_get_main_queue(), ^{
        [SelectVCTool selectVC];
    });
}


@end
