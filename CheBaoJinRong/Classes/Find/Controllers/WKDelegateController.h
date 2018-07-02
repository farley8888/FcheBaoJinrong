//
//  WKDelegateController.h
//  XYG
//
//  Created by ltyj on 2018/2/2.
//  Copyright © 2018年 Mac. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <WebKit/WebKit.h>

@protocol WKDelegate <NSObject>

- (void)userContentController:(WKUserContentController *)userContentController didReceiveScriptMessage:(WKScriptMessage *)message;

@end

@interface WKDelegateController : UIViewController <WKScriptMessageHandler>

@property (weak , nonatomic) id<WKDelegate> delegate;

@end
