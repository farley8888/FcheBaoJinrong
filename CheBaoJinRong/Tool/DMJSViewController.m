//
//  DMJSViewController.m
//  CheBaoJinRong
//
//  Created by apple on 2018/6/1.
//  Copyright © 2018年 apple. All rights reserved.
//

#import "DMJSViewController.h"
#import "DMInvestmentController.h"
#import "UIAlertView+Block.h"

@interface DMJSViewController ()

@end

@implementation DMJSViewController

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
    DMInvestmentController *itVC = [DMInvestmentController new];
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
