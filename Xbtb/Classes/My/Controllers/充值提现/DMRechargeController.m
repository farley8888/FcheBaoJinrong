//
//  DMRechargeController.m
//  CheBaoJinRong
//
//  Created by apple on 2018/5/16.
//  Copyright © 2018年 apple. All rights reserved.
//

#import "DMRechargeController.h"
#import "XBTMatch.h"
#import "XBTJSController.h"
#import "DMWebRechargeController.h"
#import "UIAlertView+Block.h"
#import "DMRealNameAuthenticationVController.h"
#import "DMBankCardController.h"

@interface DMRechargeController ()
@property (weak, nonatomic) IBOutlet UITextField *rechargeTF;
@property (weak, nonatomic) IBOutlet UILabel *bankNameLabel;
@property (nonatomic, assign) BOOL navTranslucent;
    
@end

@implementation DMRechargeController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.navigationItem.title = @"充值";
    self.navTranslucent = self.navigationController.navigationBar.translucent;
    [self.navigationController.navigationBar setTranslucent:NO];
    UserManager *manger = [UserManager sharedManager];
    if (manger.user.bankCardNo.length > 0) {
        NSString *bankNumber = [manger.user.bankCardNo substringFromIndex:(manger.user.bankCardNo.length - 4)];
        self.bankNameLabel.text = [NSString stringWithFormat:@"(尾号%@)",bankNumber];
    }
}

- (void)viewWillDisappear:(BOOL)animated
{
    [super viewWillDisappear:animated];
    [self.navigationController.navigationBar setTranslucent:self.navTranslucent];
}
    
- (void)viewDidAppear:(BOOL)animated
{
    [super viewDidAppear:animated];
    [self verificationIDAndBankCard];
}

- (void)verificationIDAndBankCard
{
    UserManager *manger = [UserManager sharedManager];
    NSString *singString = @"";
    NSString *goString = @"";
    if (manger.user.realName.length == 0) {
        singString = @"您还未实名认证";
        goString = @"去实名";
    }else if(manger.user.bankCardNo.length == 0){
        singString = @"您还未绑定银行卡";
        goString = @"去绑卡";
    }
    
    if (singString.length != 0) {
        [self alertMessage:singString goString:goString];
    }
}

- (void)alertMessage:(NSString *)singString goString:(NSString *)goString
{
    WeakSelf
    UIAlertView *alertview = [UIAlertView alertWithTitle:@"温馨提示" message:singString buttonIndex:^(NSInteger index) {
        if (index == 1) {
            if ([singString isEqualToString:@"您还未实名认证"]) {
                DMRealNameAuthenticationVController *raVC = [DMRealNameAuthenticationVController new];
                [weakSelf pushVC:raVC];
                
            }else{
                DMBankCardController *bcVC = [DMBankCardController new];
                [weakSelf pushVC:bcVC];
            }
        }
    } cancelButtonTitle:@"取消" otherButtonTitles:goString];
    [alertview  show];
}
- (void)pushVC:(UIViewController *)vc
{
    [self.navigationController pushViewController:vc animated:YES];
}


- (IBAction)rechargeVuttonClick:(UIButton *)sender {
    
    if (![XBTMatch isMoney:self.rechargeTF.text]) {
        [MBProgressHUD showSuccess:@"请输入正确的金额"];
        return;
    }
    if ([self.rechargeTF.text floatValue] < 100) {
        [MBProgressHUD showSuccess:@"最小充值金额为100元"];
        return;
    }
    
    NSString *urlString = @"http://www.chebaojr.com/fyPay.html";
    NSURL *url = [NSURL URLWithString:urlString];

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
    NSString *param = [NSString stringWithFormat:@"rechargeAmount=%@",self.rechargeTF.text];
    request.HTTPBody= [param dataUsingEncoding:NSUTF8StringEncoding];
    request.HTTPMethod = @"POST";
    WeakSelf
    [NSURLConnection sendAsynchronousRequest:request queue:[NSOperationQueue mainQueue] completionHandler:^(NSURLResponse * _Nullable response, NSData * _Nullable data, NSError * _Nullable connectionError) {
        if (connectionError == nil) {

            DMWebRechargeController *rcVC = [DMWebRechargeController new];
            rcVC.titleString = @"充值";
            rcVC.htmlData = data;
            [weakSelf pushVC:rcVC];
        }
    }];
}

@end
