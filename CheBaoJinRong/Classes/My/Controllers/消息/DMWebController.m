//
//  DMWebController.m
//  CheBaoJinRong
//
//  Created by apple on 2018/6/2.
//  Copyright © 2018年 apple. All rights reserved.
//

#import "DMWebController.h"

@interface DMWebController ()<UIWebViewDelegate>
@property (weak, nonatomic) IBOutlet UIWebView *webView;

@end

@implementation DMWebController

- (void)viewDidLoad {
    [super viewDidLoad];

    [self.webView loadHTMLString:self.webViewString baseURL:nil];
}


@end
