//
//  XBTWebRechargeController.m
//  CheBaoJinRong
//
//  Created by apple on 2018/5/21.
//  Copyright © 2018年 apple. All rights reserved.
//

#import "XBTWebRechargeController.h"
#import "WKDelegateController.h"
#import "XBTInvestmentController.h"
#import "TransactionRecordController.h"
#import <WebKit/WebKit.h>
#import "UIAlertView+Block.h"

@interface XBTWebRechargeController ()<WKUIDelegate,WKNavigationDelegate,WKScriptMessageHandler>
{
    WKUserContentController* userContentController;
}
@property (nonatomic, strong) WKWebView *webView;

    
@end

@implementation XBTWebRechargeController

- (void)dealloc
{
    DMLog(@"%s",__func__);
//    [userContentController removeScriptMessageHandlerForName:@"XBTB_IOS_SDK_goAjax"];
//    [userContentController removeScriptMessageHandlerForName:@"XYG_IOS_SDK_get_token"];
}
    
- (void)viewDidLoad {
    [super viewDidLoad];
    
    
    self.navigationItem.title = self.titleString;
    //配置环境
    WKWebViewConfiguration * configuration = [[WKWebViewConfiguration alloc]init];
    userContentController = [[WKUserContentController alloc]init];
    configuration.userContentController = userContentController;

    WKWebView *webView = [[WKWebView alloc]initWithFrame:CGRectMake(0, 0, kScreenW, kScreenH)];
    [webView loadData:self.htmlData MIMEType:@"application/octet-stream" characterEncodingName:@"UTF-8" baseURL:nil];
    [self setRegistrationMethod];
    
    webView.UIDelegate = self;
    webView.navigationDelegate = self;
    self.webView = webView;
    [self.view addSubview:webView];
    [self.view loading:CGRectMake(0, 0, kScreenW, kScreenH)];
}
    
- (void)setRegistrationMethod
{
    WKDelegateController * delegateController = [[WKDelegateController alloc]init];
    delegateController.delegate = self;
    //注册js调用方法
//    [userContentController addScriptMessageHandler:delegateController  name:@"XBTB_IOS_SDK_goAjax"];
    //获取token
//    [userContentController addScriptMessageHandler:self name:@"XYG_IOS_SDK_get_token"];
}

//oc调用js
- (void)setEvaluateJavaScript
{
    
}
    
#pragma mark - WKScriptMessageHandler
- (void)userContentController:(WKUserContentController *)userContentController didReceiveScriptMessage:(WKScriptMessage *)message{
    DMLog(@"name:%@\\\\n body:%@\\\\n frameInfo:%@\\\\n",message.name,message.body,message.frameInfo);
}

- (void)webView:(WKWebView *)webView didFinishNavigation:(WKNavigation *)navigation
{
    [self.view stop];
}

//alert弹窗 必须实现 completionHandler();
- (void)webView:(WKWebView *)webView runJavaScriptAlertPanelWithMessage:(NSString *)message initiatedByFrame:(WKFrameInfo *)frame completionHandler:(void (^)(void))completionHandler
{
    DMLog(@"message == %@",message);
    completionHandler();
}
    
- (void)webView:(WKWebView *)webView decidePolicyForNavigationAction:(WKNavigationAction *)navigationAction decisionHandler:(void (^)(WKNavigationActionPolicy))decisionHandler
{
    NSURL *URL = navigationAction.request.URL;
    NSString *urlString = [URL absoluteString];
    if ([urlString containsString:@"borrowList.html"]) {
        /**  拦截跳转出借页面  **/
        [self handleCustomAction:1 url:urlString];
        decisionHandler(WKNavigationActionPolicyCancel);
        return;
    }else if ([urlString  containsString:@"duanwuNextActive.html"]){
        /**  拦截领粽子  **/
        [self handleCustomAction:2 url:urlString];
        decisionHandler(WKNavigationActionPolicyCancel);
        
        return;
    }else if ([urlString containsString:@"moneyFlow.html"]){
        /**  拦截跳转交易记录  **/
        [self handleCustomAction:3 url:urlString];
        decisionHandler(WKNavigationActionPolicyCancel);
        return;
    }
    decisionHandler(WKNavigationActionPolicyAllow);
}

- (void)handleCustomAction:(NSInteger)num url:(NSString *)urlstr
{
    if (num == 1) {
        XBTInvestmentController *listVC = [XBTInvestmentController new];
        [self.navigationController pushViewController:listVC animated:YES];
    }else if (num == 2){
        DMLog(@"领粽子");
        [self pushGetGiftPost:urlstr];
    }else if (num == 3){

        TransactionRecordController  *transactionVC = [TransactionRecordController new];
        [self.navigationController pushViewController:transactionVC animated:YES];
    }
}
  
- (void)pushGetGiftPost:(NSString *)urlStr
{
    NSURL *url = [NSURL URLWithString:urlStr];
    
    NSMutableURLRequest *request = [NSMutableURLRequest requestWithURL:url];
    UserManager *manager = [UserManager sharedManager];
    if (manager.user.token.length) {
        
        NSString *token = [NSString stringWithFormat:@"_ed_token_=%@",manager.user.token];
        NSString *name = [NSString stringWithFormat:@"_ed_name_=%@",manager.user.userName];
        NSString *phone = [NSString stringWithFormat:@"_ed_phone_=%@",manager.user.userName];
        
        NSString *cookie = [NSString stringWithFormat:@"%@;%@;%@",token,name,phone];
        cookie = [cookie stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding];
        [request setValue:cookie forHTTPHeaderField:@"Cookie"];
    }
    //    NSString *param = [NSString stringWithFormat:@"rechargeAmount=%@",self.rechargeTF.text];
    //    request.HTTPBody= [param dataUsingEncoding:NSUTF8StringEncoding];
    request.HTTPMethod = @"POST";
    WeakSelf
    [NSURLConnection sendAsynchronousRequest:request queue:[NSOperationQueue mainQueue] completionHandler:^(NSURLResponse * _Nullable response, NSData * _Nullable data, NSError * _Nullable connectionError) {
        if (connectionError == nil) {
            
            if(weakSelf.notPush){
                [weakSelf.webView loadData:data MIMEType:@"application/octet-stream" characterEncodingName:@"UTF-8" baseURL:nil];
            }else{
                XBTWebRechargeController *rcVC = [XBTWebRechargeController new];
                rcVC.htmlData = data;
                rcVC.titleString = @"端午节活动";
                rcVC.notPush = YES;
                [weakSelf.navigationController pushViewController:rcVC animated:YES];
            }
        }
    }];
}
    
    
@end
