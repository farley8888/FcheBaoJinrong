//
//  DMJSViewController.m
//  CheBaoJinRong
//
//  Created by apple on 2018/6/1.
//  Copyright © 2018年 apple. All rights reserved.
//

#import "XBTJSViewController.h"
#import "XBTInvestmentController.h"
#import "UIAlertView+Block.h"

@interface XBTJSViewController ()

@end

@implementation XBTJSViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    [self setUI];
    DMLog(@"子类输出");
}

- (void)setUI
{
    WeakSelf
    //跳转投资页面
    self.context[@"DMUnits_IOS_SDK_gotoInvestment"] = (id)^(){
        [weakSelf gotoInvestment];
    };
    //邀请好友
    self.context[@"DMUnits_IOS_SDK_invitingFriends"] = (id)^(NSString *url){
        [weakSelf invitingFriends:url];
    };
    
}

- (void)gotoInvestment
{
    XBTInvestmentController *itVC = [XBTInvestmentController new];
    [self.navigationController pushViewController:itVC animated:YES];
}

- (void)invitingFriends:(NSString *)url
{
    NSString *messageString = [NSString stringWithFormat:@"网址为:%@\n复制链接成功",url];
    UIPasteboard *pasteboard = [UIPasteboard generalPasteboard];
    pasteboard.string = url;

    [UIAlertView alertWithTitle:@"温馨提示" message:messageString buttonIndex:^(NSInteger index) {
        
    } cancelButtonTitle:@"取消" otherButtonTitles:@""];
}


@end
