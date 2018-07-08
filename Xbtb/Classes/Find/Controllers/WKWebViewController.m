//
//  WKWebViewController.m
//  XYG
//
//  Created by ltyj on 2017/12/2.
//  Copyright © 2017年 Mac. All rights reserved.
//

#import "WKWebViewController.h"
#import "WKDelegateController.h"
#import <WebKit/WebKit.h>
#import "UserManager.h"
#import "UIAlertView+Block.h"
#import "NSUserDefaults+Extension.h"
#import "XBTInvestmentController.h"


@interface WKWebViewController ()<WKUIDelegate,WKNavigationDelegate,WKScriptMessageHandler>
{
    WKUserContentController* userContentController;
}

@property (nonatomic, strong) WKWebView *wkWebView;

@end

@implementation WKWebViewController

- (void)dealloc{
    //这里需要注意，前面增加过的方法一定要remove掉。
    [userContentController removeScriptMessageHandlerForName:@"XYG_IOS_SDK_callPhoneCode"];
    [userContentController removeScriptMessageHandlerForName:@"XYG_IOS_SDK_goto_settlement"];
    [userContentController removeScriptMessageHandlerForName:@"XYG_IOS_SDK_getVersion"];
    [userContentController removeScriptMessageHandlerForName:@"XYG_IOS_NSLog"];
    [userContentController removeScriptMessageHandlerForName:@"XYG_IOS_SDK_push"];
    [userContentController removeScriptMessageHandlerForName:@"XYG_IOS_SDK_quit_push"];
    [userContentController removeScriptMessageHandlerForName:@"XYG_IOS_SDK_push_index"];
    [userContentController removeScriptMessageHandlerForName:@"XYG_IOS_SDK_get_userid"];
    [userContentController removeScriptMessageHandlerForName:@"XYG_IOS_SDK_get_token"];
    [userContentController removeScriptMessageHandlerForName:@"XYG_IOS_SDK_show"];
    [userContentController removeScriptMessageHandlerForName:@"XYG_IOS_SDK_get_AppAPI"];
    [userContentController removeScriptMessageHandlerForName:@"XYG_IOS_SDK_goto_settlement"];
    [userContentController removeScriptMessageHandlerForName:@"XYG_IOS_SDK_goto_showMessage"];
    [userContentController removeScriptMessageHandlerForName:@"XYG_IOS_SDK_goto_shopDetial"];
 
    DMLog(@"%s",__func__);
}

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    [self setUI];
}

-(void)setUI
{
    self.view.backgroundColor = [UIColor redColor];
    //配置环境
    WKWebViewConfiguration * configuration = [[WKWebViewConfiguration alloc]init];
    userContentController = [[WKUserContentController alloc]init];
    configuration.userContentController = userContentController;

    WKWebView *wkwebView = [[WKWebView alloc]initWithFrame:CGRectMake(0, -44, kScreenW, self.webViewH == 0?(kScreenH - 20):self.webViewH) configuration:configuration];

    self.wkWebView = wkwebView;
    /**  注册方法  **/
    [self setRegistrationMethod];
    /**  与webview UI交互代理  **/
    wkwebView.UIDelegate = self;
    /**  导航代理  **/
    wkwebView.navigationDelegate = self;
    
    NSURLRequest *request = [NSURLRequest requestWithURL:[NSURL URLWithString:self.url]];
    [self.wkWebView loadRequest:request];
    [self.view addSubview:wkwebView];
    [self.view loading:CGRectMake(0, SafeAreaTopHeight, kScreenW, self.wkWebView.mj_h)];
}

- (void)setRegistrationMethod
{
    //注册方法
    WKDelegateController * delegateController = [[WKDelegateController alloc]init];
    delegateController.delegate = self;
    //拨打电话号码
    [userContentController addScriptMessageHandler:delegateController  name:@"XBTB_IOS_SDK_callPhoneCode"];

    [userContentController addScriptMessageHandler:delegateController  name:@"XBTB_IOS_SDK_goto_settlement"];
    //获取版本信息
    [userContentController addScriptMessageHandler:delegateController  name:@"XBTB_IOS_SDK_getVersion"];
    //web 打印输出
    [userContentController addScriptMessageHandler:delegateController  name:@"XBTB_IOS_NSLog"];
    //跳转页面
    [userContentController addScriptMessageHandler:delegateController  name:@"XBTB_IOS_SDK_push"];
    [userContentController addScriptMessageHandler:delegateController  name:@"XBTB_IOS_SDK_quit_push"];
    [userContentController addScriptMessageHandler:delegateController  name:@"XBTB_IOS_SDK_push_index"];
    //获取userid
    [userContentController addScriptMessageHandler:delegateController  name:@"XBTB_IOS_SDK_get_userid"];
    //获取token
    [userContentController addScriptMessageHandler:delegateController  name:@"XBTB_IOS_SDK_get_token"];
    //提示
    [userContentController addScriptMessageHandler:delegateController  name:@"XBTB_IOS_SDK_show"];
    //获取h5 URL地址
    [userContentController addScriptMessageHandler:delegateController  name:@"XBTB_IOS_SDK_get_AppAPI"];
    //去结算
//    [userContentController addScriptMessageHandler:delegateController  name:@"XBTB_IOS_SDK_goto_settlement"];
    //我要合作
    [userContentController addScriptMessageHandler:delegateController  name:@"XBTB_IOS_SDK_goto_showMessage"];
    //进店铺
    [userContentController addScriptMessageHandler:delegateController  name:@"XBTB_IOS_SDK_goto_shopDetial"];
    
}

- (void)setEvaluateJavaScript
{
    [self.wkWebView evaluateJavaScript:@"XBTB_IOS_SDK_goto_settlement" completionHandler:^(id _Nullable result, NSError * _Nullable error) {
        if (error != nil) {

        }
    }];
}

#pragma mark - WKScriptMessageHandler
- (void)userContentController:(WKUserContentController *)userContentController didReceiveScriptMessage:(WKScriptMessage *)message{
    DMLog(@"name:%@\\\\n body:%@\\\\n frameInfo:%@\\\\n",message.name,message.body,message.frameInfo);
}

- (void)webView:(WKWebView *)webView decidePolicyForNavigationAction:(WKNavigationAction *)navigationAction decisionHandler:(void (^)(WKNavigationActionPolicy))decisionHandler
{
    NSURL *URL = navigationAction.request.URL;
    NSString *urlString = [URL absoluteString];
    if ([urlString isEqualToString:@"http://www.chebaojr.com/wechat/borrowList.html"]) {
        [self handleCustomAction:1];
        decisionHandler(WKNavigationActionPolicyCancel);
        return;
    }
    decisionHandler(WKNavigationActionPolicyAllow);
}

- (void)handleCustomAction:(NSInteger)num
{
    if (num == 1) {
        XBTInvestmentController *listVC = [XBTInvestmentController new];
        [self.navigationController pushViewController:listVC animated:YES];
    }
}

- (void)webView:(WKWebView *)webView didStartProvisionalNavigation:(WKNavigation *)navigation
{
    DMLog(@"网页开始加载...");
}

- (void)webView:(WKWebView *)webView didFinishNavigation:(WKNavigation *)navigation
{
    [self.view stop];
    if (self.navigationItem.title == nil) {
       self.navigationItem.title = self.wkWebView.title;
    }
    DMLog(@"加载完成...");
}

- (void)webView:(WKWebView *)webView didFailProvisionalNavigation:(WKNavigation *)navigation withError:(NSError *)error
{
    [self.view stop];
    DMLog(@"加载失败...");
}

- (void)gotoShopDetial:(NSString *)shopUrl goodsUrl:(NSString *)goodsUrl
{

}

- (NSString *)getAppAPI
{
    return kAPI_URL;
}

- (void)gotoShowMessage
{

}

- (void)gotoSettlement:(NSString *)orderNum group:(NSString *)group
{

}

- (void)webNslogTest:(NSString *)log
{
    DMLog(@"WebViewLog:>>>>>>>>%@<<<<<<<<",log);
}

- (void)goto_orderdetail:(NSString *)orderno
{
    NSMutableArray *vcs = [self.navigationController.childViewControllers mutableCopy];
    if (vcs.count > 1) {
//        WeakSelf
        dispatch_async(dispatch_get_main_queue(), ^{

        });
    }
}

- (void)goto_mallhome
{
//    NSMutableArray *vcs = [self.navigationController.childViewControllers mutableCopy];
}

//活体检测
- (void)faceDetector:(NSString *)url
{
    dispatch_async(dispatch_get_main_queue(), ^{

    });
}

- (void)faceDetector2:(NSString *)callback bankid:(NSString *)bankid ids:(NSString *)ids
{

}

- (void)faceDetector2Success:(NSString *)callback bankid:(NSString *)bankid ids:(NSString *)ids
{
    if (callback.length) {

    }
}

- (void)doVerify:(NSString* )url {
  
}

- (NSString *)URLEncodedStringWithUrl:(NSString *)url {
    NSString *encodedString = (NSString *)CFBridgingRelease(CFURLCreateStringByAddingPercentEscapes(NULL,(CFStringRef)url,NULL,(CFStringRef) @"!'();:@&=+$,%#[]|",kCFStringEncodingUTF8));
    return encodedString;
}

- (void)alertView:(UIAlertView *)alertView clickedButtonAtIndex:(NSInteger)buttonIndex {
    if (buttonIndex == 1) {
        NSString *appstoreUrl = @"itms-apps://itunes.apple.com/app/id333206289";
        [[UIApplication sharedApplication] openURL:[NSURL URLWithString:appstoreUrl] options:@{} completionHandler:nil];
    }
}

- (BOOL)canOpenAlipay {
    return [[UIApplication sharedApplication] canOpenURL:[NSURL URLWithString:@"alipays://"]];
}

- (void)back
{
    if (self.wkWebView.canGoBack) {
        [self.wkWebView goBack];
    } else {
        [self.navigationController popViewControllerAnimated:YES];
    }
}

- (void)alert:(NSString *)title message:(NSString *)message  buttonIndex:(NSString *)buttonIndex cancelButtonTitle:(NSString *)cancelButtonTitle otherButtonTitle:(NSString *)otherButtonTitle
{
    WeakSelf
    dispatch_async(dispatch_get_main_queue(), ^{
        UIAlertView *alertView = [UIAlertView alertWithTitle:title message:message buttonIndex:^(NSInteger index) {
//            [weakSelf.context evaluateScript:[NSString stringWithFormat:@"%@(%zi)", buttonIndex, index]];
        } cancelButtonTitle:cancelButtonTitle otherButtonTitles:otherButtonTitle];
        [alertView show];
    });
}

- (void)showMessage:(NSString *)message
{
    dispatch_async(dispatch_get_main_queue(), ^{
        [XBTProgressHUD showSuccess:message];
    });
}

- (NSString *)get_token
{
    UserManager *um = [UserManager sharedManager];
    return um.user.token;
}


- (void)push_userMsg
{

}

- (void)callPhoneCode:(NSString *)phone
{
    DMLog(@"%@",phone);
    
    dispatch_async(dispatch_get_main_queue(), ^{
        [[UIAlertView alertWithTitle:nil message:[NSString stringWithFormat:@"是否拨打电话%@", phone] buttonIndex:^(NSInteger index) {
            if (index == 1) {
                [[UIApplication sharedApplication] openURL:[NSURL URLWithString:[NSString stringWithFormat:@"tel:%@", phone]]];
            }
        } cancelButtonTitle:@"取消" otherButtonTitles:@"确定"] show];
    });
}

- (void)push:(NSString *)url
{
    WeakSelf

}

- (void)quit_push:(NSString *)url
{
    WeakSelf
    WKWebViewController *jsVC = [[WKWebViewController alloc] init];
    jsVC.url = url;
    dispatch_async(dispatch_get_main_queue(), ^{
    });
}

//index表示   push之后的控制器 back返回到第几个控制器  index == 1的时候为跟控制器
- (void)push_index:(NSString *)url index:(NSInteger)index
{
//    YCJSController *jsVC = [[YCJSController alloc] init];
//    jsVC.url = url;
//    WeakSelf
//    dispatch_async(dispatch_get_main_queue(), ^{
//
//        NSMutableArray *vcs = [weakSelf.navigationController.viewControllers mutableCopy];
//        if (vcs.count-index>0) {
//            [vcs removeObjectsInRange:NSMakeRange(index, vcs.count-index)];
//        }
//        [vcs addObject:jsVC];
//        [weakSelf.navigationController setViewControllers:vcs animated:YES];
//    });
}

- (void)setBuyBackfirst:(NSInteger)buyBackfirst
{
}

- (void)setNavBgColor:(NSString *)color
{
//    NSUInteger outValue = 0;
//    [[NSScanner scannerWithString:color]scanHexInt:&outValue];
//
//    [self.navigationController.navigationBar setBackgroundImage:[UIImage imageFromContextWithColor:KColorFromRGB(outValue)] forBarMetrics:UIBarMetricsDefault];
//    [self.navigationController.navigationBar setShadowImage:[UIImage new]];
//    self.navigationController.navigationBar.alpha = .98;
//
//    [self.navigationController.navigationBar setBarTintColor:[UIColor whiteColor]];
//    [self.navigationController.navigationBar setTintColor:[UIColor whiteColor]];
//    self.navigationController.navigationBar.titleTextAttributes = @{UITextAttributeTextColor: [UIColor whiteColor]};
}

-  (NSString *)getVersion
{
    return kVersion;
}

- (void)push_pay_detail:(NSInteger)type orderno:(NSString *)orderno
{
    //1账单(转账)  2特价商品订单列表详情
    UIViewController *detailVC = nil;
    if (type==1) {
        //          detailVC = [YSBillDetialController new];
    } else if (type==2) {
        //          detailVC = [YCOrderDetailController new];
    }else if (type == 6){
        //          detailVC = [AllOrderDetialController new];
    }
    [detailVC setValue:orderno forKey:@"orderno"];
    [detailVC setValue:@(YES) forKey:@"isCustomBack"];
    WeakSelf
    dispatch_async(dispatch_get_main_queue(), ^{
        [weakSelf.navigationController pushViewController:detailVC animated:YES];
    });
}

- (void)scanQCode:(NSString *)orderno callback:(NSString *)callback
{
 
}


@end
