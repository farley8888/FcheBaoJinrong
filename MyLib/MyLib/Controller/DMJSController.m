//
//  YCJSController.m
//  SWWH
//
//  Created by 尚往文化 on 17/2/15.
//  Copyright © 2017年 cy. All rights reserved.
//

#import "DMJSController.h"

#import "UINavigationController+DM.h"
#import "NSUserDefaults+Extension.h"
#import <WebKit/WebKit.h>
#import "UIView+DMLoading.h"

#define SafeAreaTopHeight (kScreenH == 812.0 ? 88 : 64)
#define SafeAreaBottomHeight (kScreenH == 812.0 ? 34 : 0)

@interface DMJSController ()



@end

@implementation DMJSController

+ (void)load
{
    // UserAgent应该包含iPhone字段 不然会导致支付宝H5支付加载不出css
    NSDictionary *dictionnary = [[NSDictionary alloc] initWithObjectsAndKeys:@"CBJR_iPhone_CLIENT", @"UserAgent", nil];
    [[NSUserDefaults standardUserDefaults] registerDefaults:dictionnary];
}

- (void)dealloc
{
     NSLog(@"%s", __FUNCTION__);
}

- (void)viewDidLoad {
    [super viewDidLoad];
    self.edgesForExtendedLayout = UIRectEdgeNone;
    [self setupUI];
}

- (void)reloadData
{
     [self setupUI];
}

- (void)setupUI
{
     _context = nil;
     [self.webView removeFromSuperview];
     _webView = nil;
     
    _webView = [[UIWebView alloc] initWithFrame:CGRectMake(0, -SafeAreaTopHeight+20-5, kScreenW, kScreenH)];
    self.webView.scrollView.backgroundColor = [UIColor groupTableViewBackgroundColor];
    self.webView.delegate = self;
    self.webView.scrollView.bounces = NO;
        
    _context = [self.webView valueForKeyPath:@"documentView.webView.mainFrame.javaScriptContext"];
    
     [self setupContext];
     
    NSURLRequest *request = [NSURLRequest requestWithURL:[NSURL URLWithString:self.url]];
    [self.webView loadRequest:request];
    [self.view addSubview:self.webView];
}

- (void)setupContext
{
     WeakSelf
     //获取版本信息
     self.context[@"DMUnits_IOS_SDK_getVersion"] = (NSString *)^() {
          return [weakSelf getVersion];
     };
    
     //跳转页面
     self.context[@"DMUnits_IOS_SDK_push"] = (id)^(NSString *url) {
          [weakSelf push:url];
     };
     self.context[@"DMUnits_IOS_SDK_quit_push"] = (id)^(NSString *url) {
          [weakSelf quit_push:url];
     };
     self.context[@"DMUnits_IOS_SDK_push_index"] = (id)^(NSString *url, NSInteger index) {
          [weakSelf push_index:url index:index];
     };
     
     //拨打电话号码
     self.context[@"DMUnits_IOS_SDK_callPhoneCode"] = (id)^(NSString *phone) {
          [weakSelf callPhoneCode:phone];
     };
    
}

- (void)registFuncationWithName:(NSString *)funcName handle:(id)handle
{
    self.context[funcName] = handle;
}

- (JSValue *)runJS:(NSString *)js
{
    return [self.context evaluateScript:js];
}

- (void)setUrl:(NSString *)url
{
    _url = [url copy];
    NSURLRequest *request = [NSURLRequest requestWithURL:[NSURL URLWithString:url]];
    [self.webView loadRequest:request];
}

- (void)webViewDidStartLoad:(UIWebView *)webView
{
    [self.view stop];
    [self.view loading:CGRectMake(0, 0, kScreenW, kScreenH-64)];
}

- (void)webViewDidFinishLoad:(UIWebView *)webView
{
    [self.view stop];

    NSString *str = [webView stringByEvaluatingJavaScriptFromString:@"navigator.userAgent"];
    NSLog(@"UserAgent = %@", str);
    //禁止长按弹出图片的地址等
    [self.webView stringByEvaluatingJavaScriptFromString:@"document.body.style.webkitTouchCallout='none';"];
    //禁止长按复制
    [self.webView stringByEvaluatingJavaScriptFromString:@"document.documentElement.style.webkitUserSelect='none';"];
    NSString *title = [self.context evaluateScript:@"document.title"].toString;
    self.navigationItem.title = title;
}

- (void)webView:(UIWebView *)webView didFailLoadWithError:(NSError *)error
{
    [self.view stop];
    NSLog(@"%@", error.localizedDescription);
}

- (void)callPhoneCode:(NSString *)phone
{
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
    DMJSController *jsVC = [[DMJSController alloc] init];
    jsVC.url = url;
    dispatch_async(dispatch_get_main_queue(), ^{
        [self.navigationController pushViewController:jsVC animated:YES];
    });
}

- (void)quit_push:(NSString *)url
{
    DMJSController *jsVC = [[DMJSController alloc] init];
    jsVC.url = url;
    dispatch_async(dispatch_get_main_queue(), ^{
        [self.navigationController DM_pushViewController:jsVC animated:YES];
    });
}

//index表示   push之后的控制器 back返回到第几个控制器
- (void)push_index:(NSString *)url index:(NSInteger)index
{
     DMJSController *jsVC = [[DMJSController alloc] init];
     jsVC.url = url;
     dispatch_async(dispatch_get_main_queue(), ^{
          
          NSMutableArray *vcs = [self.navigationController.viewControllers mutableCopy];
          if (vcs.count-index>0) {
               [vcs removeObjectsInRange:NSMakeRange(index, vcs.count-index)];
          }
          [vcs addObject:jsVC];
          [self.navigationController setViewControllers:vcs animated:YES];
     });
}

-  (NSString *)getVersion
{
    return kVersion;
}


@end
