//
//  DMBuyDidiBaoController.m
//  CheBaoJinRong
//
//  Created by apple on 2018/5/22.
//  Copyright © 2018年 apple. All rights reserved.
//

#import "DMBuyDidiBaoController.h"
#import "XBTMatch.h"
#import "XBTJSController.h"
#import "UIAlertView+Block.h"
#import "DMRechargeController.h"

@interface DMBuyDidiBaoController ()
@property (weak, nonatomic) IBOutlet UIScrollView *scrollerView;
@property (weak, nonatomic) IBOutlet UITextField *moneyTF;
@property (weak, nonatomic) IBOutlet UILabel *canUseMoneyLabel;
@property (weak, nonatomic) IBOutlet UILabel *profitMoneyLabel;
@property (nonatomic, assign) CGFloat canuseMoney;
@property (nonatomic, assign) BOOL isAgree;

@end

@implementation DMBuyDidiBaoController

- (void)viewDidLoad {
    [super viewDidLoad];

    [self setUI];
    [self loadData];
}

- (void)setUI
{
    self.navigationItem.title = @"购买";
    UITapGestureRecognizer *gesture = [[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(hideKeyBoard)];
    gesture.cancelsTouchesInView = NO;
    [self.scrollerView addGestureRecognizer:gesture];
    [self.moneyTF addTarget:self action:@selector(textFieldEditing:) forControlEvents:UIControlEventEditingChanged];
}

- (void)textFieldEditing:(UITextField *)tf
{
    if (![XBTMatch isMoney:tf.text]) {
        [MBProgressHUD showSuccess:@"请检查输入金额"];
        return;
    }
    
    CGFloat todayProfitMoney = [self.moneyTF.text floatValue] * 0.098 / 365.0;
    self.profitMoneyLabel.text = [NSString stringWithFormat:@"%.2f元",todayProfitMoney];
}

- (IBAction)allInButtonclick:(id)sender {
    
    self.moneyTF.text = [NSString stringWithFormat:@"%.2f",self.canuseMoney];
    CGFloat todayProfitMoney = [self.moneyTF.text floatValue] * 0.098 / 365.0;
    self.profitMoneyLabel.text = [NSString stringWithFormat:@"%.2f元",todayProfitMoney];
}

- (void)hideKeyBoard
{
    [self.view endEditing:YES];
}

- (IBAction)ageerButton:(UIButton *)sender {
    sender.selected = !sender.selected;
    self.isAgree = sender.selected;
}

- (IBAction)agreementButtonClick:(id)sender {
    
    XBTJSController  *jsVC = [XBTJSController  new];
    jsVC.title = @"鑫贝通宝点对点借款合同";
    jsVC.url = [NSString stringWithFormat:@"%@/wechat/showAgreementAPP.html",kAPI_URL];
    [self.navigationController pushViewController:jsVC animated:YES];
}

- (IBAction)sureInvestmentClick:(UIButton *)sender {
    
    if (![XBTMatch isMoney:self.moneyTF.text]) {
        [MBProgressHUD showSuccess:@"请检查输入金额"];
        return;
    }
    if ([self.moneyTF.text floatValue] < 100) {
        [MBProgressHUD showSuccess:@"最小投资金额为100"];
        return;
    }
    if (!self.isAgree) {
        [MBProgressHUD showSuccess:@"请勾选服务协议"];
        return;
    }
    if ([self.moneyTF.text floatValue] > self.canuseMoney) {
        
        [self aletMessage];
        return;
    }
    
    [self investmentPOST];
}

- (void)loadData
{
    WeakSelf
    [YBHttpTool postDataDifference:@"didiPurchaseInfo" params:nil success:^(id  _Nullable obj) {
        if (obj!=nil) {
            DMStateModel *stateModel = [DMStateModel mj_objectWithKeyValues:obj[@"state"]];
            if (stateModel.status == ResultStatusSuccess) {
                weakSelf.canUseMoneyLabel.text = [NSString stringWithFormat:@"%@元",obj[@"usermoney"]];
                weakSelf.canuseMoney = [obj[@"usermoney"] floatValue];
                
            }
        }
    } failure:^(NSError * _Nullable error) {
        
    }];
}

- (void)aletMessage
{
    UIAlertController *alert = [UIAlertController alertControllerWithTitle:@"温馨提示" message:@"账户可用余额不足，是否充值？" preferredStyle:UIAlertControllerStyleAlert];
    UIAlertAction *cancelAction = [UIAlertAction actionWithTitle:@"取消" style:UIAlertActionStyleCancel handler:^(UIAlertAction * _Nonnull action) {
    }];
    WeakSelf
    UIAlertAction *confirmAction = [UIAlertAction actionWithTitle:@"去充值" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
        
        DMRechargeController *repVC = [DMRechargeController new];
        [weakSelf.navigationController pushViewController:repVC animated:YES];
        
    }];
    
    [alert addAction:cancelAction];
    [alert addAction:confirmAction];
    [self.navigationController presentViewController:alert animated:YES completion:nil];
}

- (void)investmentPOST
{
    NSDictionary *params = @{@"investmoney":self.moneyTF.text,
                             @"tradingPassword":@"123456"
                             };
    WeakSelf
    [YBHttpTool postDataDifference:@"applicationForm" params:params success:^(id  _Nullable obj) {
        if (obj!=nil) {
            DMStateModel *model = [DMStateModel mj_objectWithKeyValues:obj[@"state"]];
            [MBProgressHUD showSuccess:model.info];
            if ([model.info isEqualToString:@"出借成功"]) {
                [weakSelf.navigationController popViewControllerAnimated:YES];
            }
        }
    } failure:^(NSError * _Nullable error) {
        
    }];
}


@end
