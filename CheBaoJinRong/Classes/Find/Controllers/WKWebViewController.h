//
//  WKWebViewController.h
//  XYG
//
//  Created by ltyj on 2017/12/2.
//  Copyright © 2017年 Mac. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface WKWebViewController : UIViewController

@property (nonatomic, assign) NSInteger type;
@property (nonatomic, assign) CGFloat webViewH;
@property (nonatomic, copy) NSString *url;
//重新刷新页面
- (void)reloadData;

@end
