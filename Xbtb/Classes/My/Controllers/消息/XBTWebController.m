//
//  DMWebController.m
//  CheBaoJinRong
//
//  Created by apple on 2018/6/2.
//  Copyright © 2018年 apple. All rights reserved.
//

#import "XBTWebController.h"

@interface XBTWebController ()<UIWebViewDelegate>
@property (weak, nonatomic) IBOutlet UIWebView *webView;

@end

@implementation XBTWebController

- (void)viewDidLoad {
    [super viewDidLoad];

    [self.webView loadHTMLString:self.webViewString baseURL:nil];
}


@end
