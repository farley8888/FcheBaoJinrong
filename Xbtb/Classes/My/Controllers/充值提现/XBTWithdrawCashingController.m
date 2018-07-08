//
//  XBTWithdrawCashingController.m
//  CheBaoJinRong
//
//  Created by apple on 2018/5/21.
//  Copyright © 2018年 apple. All rights reserved.
//

#import "XBTWithdrawCashingController.h"

@interface XBTWithdrawCashingController ()

@property (nonatomic, assign) BOOL navTranslucent;
@end

@implementation XBTWithdrawCashingController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    self.navigationItem.title = @"提现中";
    self.navTranslucent = self.navigationController.navigationBar.translucent;
    [self.navigationController.navigationBar setTranslucent:NO];
}

- (void)viewWillDisappear:(BOOL)animated
{
    [super viewWillDisappear:animated];
    [self.navigationController.navigationBar setTranslucent:self.navTranslucent];
}


- (IBAction)finishButtonClick:(id)sender {
    [self.navigationController popViewControllerAnimated:YES];
}


@end
