//
//  Define.h
//  Xunbao2
//
//  Created by Jason on 15/7/20.
//  Copyright (c) 2015年 Jason. All rights reserved.
//

#ifndef Xunbao2_Define_h
#define Xunbao2_Define_h

#import "UIView+Extension.h"
#import "Function.h"
#import "UIView+Loading.h"

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

//注册
#define kRegisterNib(nibName) [self.tableView registerNib:[UINib nibWithNibName:nibName bundle:nil] forCellReuseIdentifier:nibName]


#define kGetCellForNib(nibName) [[[NSBundle mainBundle] loadNibNamed:nibName owner:self options:nil] lastObject]



// 弱引用
#define WeakSelf __weak typeof(self) weakSelf = self;

/**
 *  沙盒Document路径
 */
#define kDocumentPath ([NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES) lastObject])

/**
 *  沙盒Cache路径
 */
#define kCachePath ([NSSearchPathForDirectoriesInDomains(NSCachesDirectory, NSUserDomainMask, YES) lastObject])
/**
 *  屏幕高度
 */
#define kScreenH ([UIScreen mainScreen].bounds.size.height)

/**
 *  屏幕宽度
 */
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

// 随机色
#define kRandomColor kColor(arc4random_uniform(256), arc4random_uniform(256), arc4random_uniform(256))

// 是否为iOS7
#define iOS7 ([[UIDevice currentDevice].systemVersion doubleValue] >= 7.0)

// 是否为4inch
#define FourInch ([UIScreen mainScreen].bounds.size.height >= 568.0)

//K线颜色
#define kCustomRedColor KColorFromRGB(0xe43337)
#define kCustomBlueColor KColorFromRGB(0x58ca69)
#define kCustomBlackColor KColorFromRGB(0x333333)
#define WH_SCALE(a) [Common setWidth:a]

#define kNotificationCenter [NSNotificationCenter defaultCenter]

#define kVersion [[NSBundle mainBundle] infoDictionary][@"CFBundleShortVersionString"]
#define kBundleIdentifier [[NSBundle mainBundle] infoDictionary][@"CFBundleIdentifier"]

//每一页的数据
#define kLimit @(10)

//停止加载数据动态图（CollectionView）
#define kLoadDataHeaderEndStopForCollectionView  if([weakSelf respondsToSelector:@selector(collectionView)]){[weakSelf.view stop];[weakSelf.collectionView stop]; [weakSelf.collectionView.mj_header endRefreshing];}

#define kLoadDataHeaderEnd if([weakSelf respondsToSelector:@selector(tableView)]){[weakSelf.view stop];[weakSelf.tableView stop]; [weakSelf.tableView.mj_header endRefreshing];}
#define kloadDataFooterEnd [weakSelf.tableView.mj_footer endRefreshing];

#define kSetupMJ_footer_loadData(selectorName) weakSelf.tableView.mj_footer = [MJRefreshAutoNormalFooter footerWithRefreshingBlock:^{\
[weakSelf selectorName];\
}];\
if (pageModel.hasNextPage != YES) {\
    [weakSelf.tableView.mj_footer endRefreshingWithNoMoreData];\
} else {\
    [weakSelf.tableView.mj_footer resetNoMoreData];\
}\
\
[weakSelf.tableView reloadData];\
weakSelf.page=2;


#define kSetupMJ_footer_loadMoreData if (pageModel.hasNextPage != YES) {\
[weakSelf.tableView.mj_footer endRefreshingWithNoMoreData];\
} else {\
    [weakSelf.tableView.mj_footer resetNoMoreData];\
}\
[weakSelf.tableView reloadData];\
weakSelf.page++;

//设置下拉刷新tableView
#define kSetupRefreshNormalHeader self.tableView.mj_header = [MJRefreshNormalHeader headerWithRefreshingBlock:^{\
    [weakSelf loadData];\
}];

//设置下拉刷新collectionView
#define kSetupRefreshNormalCollectionViewHeader self.collectionView.mj_header = [MJRefreshNormalHeader headerWithRefreshingBlock:^{\
[weakSelf loadData];\
}];

#define kLoadDataHeaderEndForCollection if([weakSelf respondsToSelector:@selector(collectionView)]){[weakSelf.view stop];[weakSelf.collectionView stop]; [weakSelf.collectionView.mj_header endRefreshing];}

//设置返回按钮
#define kSetupBackItem UIBarButtonItem *negativeSpacer = [[UIBarButtonItem alloc]initWithBarButtonSystemItem:UIBarButtonSystemItemFixedSpace target:nil action:nil];negativeSpacer.width = -5;self.navigationItem.leftBarButtonItems = @[negativeSpacer, [UIBarButtonItem backItemWithTarget:self action:@selector(back)]];
#define kSetupBackWhiteItem UIBarButtonItem *negativeSpacer = [[UIBarButtonItem alloc]initWithBarButtonSystemItem:UIBarButtonSystemItemFixedSpace target:nil action:nil];negativeSpacer.width = -5;self.navigationItem.leftBarButtonItems = @[negativeSpacer, [UIBarButtonItem backWhiteItemWithTarget:self action:@selector(back)]];

//判断是否是当前的控制器  如果不是就不执行后面的逻辑了
#define kIsTopViewController if (weakSelf.navigationController.topViewController != self) return;


#define kHeightForSection 5
#define KApiVersion  1


#define Device [[[UIDevice currentDevice] identifierForVendor] UUIDString]

#define LableFont [UIFont systemFontOfSize:16.0]
#define KButtonFillet (5)  //button 的圆角数字

//我的利息可见、不可见
#define kMyProfitVisual @"kMyProfitVisual"
//我的滴滴宝可见、不可见
#define kMyDidiBaoVisual @"kMyDidiBaoVisual"
//回款查询顶部通知
#define kSetRetuBackTopView @"kSetRetuBackTopView"
//我的红包立即使用
#define kNowUse @"kNowUse"

#define kLoginSuccessNotification @"kLoginSuccessNotification"//登录成功
#define kLogoutNotification @"kLogoutNotification"//登出
#define kReceiveRemoteNotification @"kReceiveRemoteNotification"//收到推送


#define kJPushRegistrationID @"kJPushRegistrationID"

#define kCustomer_Service_Phone @"400-8555-603" //客服电话

//#define kShareImageURL @"http://yy-img.iswcc.com/ysh/180x180.png"//分享的图片地址
#define kShareImageURL [UIImage imageNamed:@"share"]
#define kMorentouxiang [UIImage imageNamed:@"morentouxiang.jpeg"]
#define kMorentupian [UIImage imageNamed:@"morentupian"]

#define kAPPID @"1153938790"

#define kNOFirstTimeKey @"kNOFirstTimeKey"
#define kVersionKey @"kVersionKey"
#define kLoginBgImgUrl @"http://swimgs.iswcc.cn/tgimage/bg/loginbg.png"

#define SystemMessageSetUpSate 127
#define SystemMessageKey @"SystemMessageKey"

#define kLastSeeMessageTime @"kLastSeeMessageTime"//最后一次看消息的时间
#define kLastLocation @"kLastLocation"//最后一次的地址

#define kFirAutoCheckUpdateEnabel 0//1表示需要检测 0表示不需要检测内部更新   
#define VIEWSAFEAREAINSETS(view) ({UIEdgeInsets i; if(@available(iOS 11.0, *)) {i = view.safeAreaInsets;} else {i = UIEdgeInsetsZero;} i;})
#define SafeAreaTopHeight (kScreenH == 812.0 ? 88 : 64)
#define SafeAreaBottomHeight (kScreenH == 812.0 ? 34 : 0)
#define ISIphonX (kScreenH == 812.0 ? 1:0)
#define Tabbar_H 49
#define Suffix @".html"

#define GesturesPassword @"gesturespassword"
#define GesturesPasswordOpenOrClose @"GesturesPasswordOpenOrClose"


#if 1 //0表示测试环境 1表示正式环境

#define kAPI_APPURL @"http://www.chebaojr.com/app/"
#define kAPI_URL @"http://www.chebaojr.com/"   //接口
#define kAPI_BACK_URL @"http://swpay.iswcc.com/"//支付回调
#define kHTML_URL @"http://xwfstatic.jufengyigo.com/"   //html  wap页面

#else
//http://192.168.1.138:8080/
//#define kAPI_URL @"http://jzwjej.natappfree.cc/app-api/"  //外网接口
#define kAPI_APPURL @"http://192.168.1.171:8080/jp/app/"
#define kAPI_URL @"http://192.168.1.171:8080/jp/" //本地
#define kAPI_BACK_URL @"http://swpay.iswcc.cn/"//支付回调
#define kHTML_URL @"http:wwwtest.zjqxdzsw.com/app/view/"  //html WAP页面



#endif


//app配置
//主题颜色
#define kScareColor KColorFromRGB(0xfb500a)
//#define kGYMenuColor [UIColor colorWithString:[UserManager sharedManager].appConfig.navigationBarColor]
#define kMenuColor [UIColor orangeColor]

//文字颜色
#define kGYCharacterColor [UIColor colorWithString:[UserManager sharedManager].appConfig.characterColor]


#endif
