//
//  YCJSController.h
//  SWWH
//
//  Created by 尚往文化 on 17/2/15.
//  Copyright © 2017年 cy. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <JavaScriptCore/JavaScriptCore.h>

@interface DMJSController : UIViewController<UIWebViewDelegate>

@property (nonatomic, strong, readonly) UIWebView *webView;
@property (strong, nonatomic, readonly) JSContext *context;
@property (nonatomic, copy) NSString *url;

//重新刷新页面
- (void)reloadData;


/**
 注册方法  给JS调用

 @param funcName 方法名
 @param handle 实现的block 必须是block
 */
- (void)registFuncationWithName:(NSString *)funcName handle:(id)handle;

/**
 调用JS方法

 @param js js语句
 @return 结果
 */
- (JSValue *)runJS:(NSString *)js;

@end
