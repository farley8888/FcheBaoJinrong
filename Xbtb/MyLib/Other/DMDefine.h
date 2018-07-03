//
//  YBDMDefine.h
//  DMUnits
//
//  Created by 尚往文化 on 17/6/20.
//  Copyright © 2017年 DMing. All rights reserved.
//

#ifndef DMDefine_h
#define DMDefine_h

#ifdef DEBUG // 调试状态, 打开LOG功能
#define DMLog(...) NSLog(__VA_ARGS__)
#else // 发布状态, 关闭LOG功能
#define DMLog(...)
#endif

#if TARGET_IPHONE_SIMULATOR
#define kSIMULATOR 1
#elif TARGET_OS_IPHONE
#define kSIMULATOR 0
#endif

#define DMWeakSelf __weak typeof(self) weakSelf = self;
#define DMStrongSelf __strong typeof(self) self = weakSelf;

#define kDocumentPath ([NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES) lastObject])
#define kCachePath ([NSSearchPathForDirectoriesInDomains(NSCachesDirectory, NSUserDomainMask, YES) lastObject])


#define kScreenH ([UIScreen mainScreen].bounds.size.height)
#define kScreenW ([UIScreen mainScreen].bounds.size.width)


/**
 *  弧度转角度
 */
#define kRADIANS_TO_DEGREES(radians) ((radians) * (180.0 / M_PI))
/**
 *  角度转弧度
 */
#define kDEGREES_TO_RADIANS(angle) ((angle) / 180.0 * M_PI)

// 颜色
#define kColor(r, g, b) [UIColor colorWithRed:(r)/255.0 green:(g)/255.0 blue:(b)/255.0 alpha:1.0]
#define KColorFromRGB(rgbValue) [UIColor colorWithRed:((float)((rgbValue & 0xFF0000) >> 16))/255.0 green:((float)((rgbValue & 0xFF00) >> 8))/255.0 blue:((float)(rgbValue & 0xFF))/255.0 alpha:1.0]
#define kRandomColor kColor(arc4random_uniform(256), arc4random_uniform(256), arc4random_uniform(256))

#define kNotificationCenter [NSNotificationCenter defaultCenter]

#define kVersion [[NSBundle mainBundle] infoDictionary][@"CFBundleShortVersionString"]
#define kBundleIdentifier [[NSBundle mainBundle] infoDictionary][@"CFBundleIdentifier"]



//#define kLoadDataHeaderEnd if([weakSelf respondsToSelector:@selector(tableView)]){[weakSelf.view stop];[weakSelf.tableView stop]; [weakSelf.tableView.mj_header endRefreshing];}
//#define kloadDataFooterEnd [weakSelf.tableView.mj_footer endRefreshing];
//
//#define kSetupMJ_footer_loadData(selectorName) weakSelf.tableView.mj_footer = [MJRefreshAutoNormalFooter footerWithRefreshingBlock:^{\
//[weakSelf selectorName];\
//}];\
//if (arr.count<kLimit.integerValue) {\
//[weakSelf.tableView.mj_footer endRefreshingWithNoMoreData];\
//} else {\
//[weakSelf.tableView.mj_footer resetNoMoreData];\
//}\
//\
//[weakSelf.tableView reloadData];\
//weakSelf.page=2;
//
//
//#define kSetupMJ_footer_loadMoreData if (arr.count<kLimit.integerValue) {\
//[weakSelf.tableView.mj_footer endRefreshingWithNoMoreData];\
//} else {\
//[weakSelf.tableView.mj_footer resetNoMoreData];\
//}\
//[weakSelf.tableView reloadData];\
//weakSelf.page++;
//
////设置下拉刷新
//#define kSetupRefreshNormalHeader self.tableView.mj_header = [MJRefreshNormalHeader headerWithRefreshingBlock:^{\
//[weakSelf loadData];\
//}];

#define kIsIPhoneX (kScreenH==812?YES:NO)
#define kScreenStatusBarH (kIsIPhoneX?44:20)
#define kScreenNavigationBarH 44
#define kScreenTabbarBottom (kIsIPhoneX?34:0)
#define kScreenTabbarH 49

#define kScreenTop (kScreenStatusBarH+kScreenNavigationBarH)
#define kScreenBottom (kScreenTabbarBottom+kScreenTabbarH)

#define kGetViewForXib(nibbName) [[[NSBundle mainBundle] loadNibNamed:nibbName owner:nil options:nil] lastObject]

//判断是否是当前的控制器  如果不是就不执行后面的逻辑了
#define kIsTopViewController if (self.navigationController.topViewController != self) return;

#define kHeightForSection 9


#define kAliPaySuccessNotification @"kPaySuccessNotification"//支付宝支付成功
#define kAliPayFailureNotification @"kPayFailureNotification"//支付宝支付失败
#define kAliPayCancelNotification @"kPayCancelNotification"//支付宝支付取消
#define kLoginSuccessNotification @"kLoginSuccessNotification"//登录成功
#define kLogoutNotification @"kLogoutNotification"//登出
#define kReceiveRemoteNotification @"kReceiveRemoteNotification"//收到推送


#define kNOFirstTimeKey @"kNOFirstTimeKey"
#define kVersionKey @"kVersionKey"

#endif /* DMDefine_h */
