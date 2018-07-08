//
//  DMwithdrawCashController.m
//  CheBaoJinRong
//
//  Created by apple on 2018/5/16.
//  Copyright © 2018年 apple. All rights reserved.
//

#import "WithdrawCashController.h"
#import "XBTWithdrawCashModel.h"
#import "XBTMatch.h"
#import "UINavigationController+XBT.h"
#import "XBTWithdrawCashingController.h"  //提现中

@interface WithdrawCashController ()

@property (weak, nonatomic) IBOutlet NSLayoutConstraint *bkViewTopLay;
@property (weak, nonatomic) IBOutlet UILabel *bankCardNameAndNuber;
@property (weak, nonatomic) IBOutlet UILabel *canUseLabel;
@property (weak, nonatomic) IBOutlet UITextField *amoutTF;
@property (weak, nonatomic) IBOutlet UITextField *pwTF;
@property (weak, nonatomic) IBOutlet UIButton *sureButton;
@property (weak, nonatomic) IBOutlet UILabel *messageLab;
@property (weak, nonatomic) IBOutlet UILabel *redeemOrWithdrawCashLabel;
@property (nonatomic, assign) BOOL navTranslucent;
@property (nonatomic, copy)NSString *canUseAmout;
@property (weak, nonatomic) IBOutlet UIButton *allWithdrawButton;
@property (weak, nonatomic) IBOutlet UILabel *quotaLabel;

@end

@implementation WithdrawCashController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self setUI];
}

- (void)viewWillDisappear:(BOOL)animated
{
    [super viewWillDisappear:animated];
    [self.navigationController.navigationBar setTranslucent:self.navTranslucent];
}
    
    
- (void)setUI
{
    self.navTranslucent = self.navigationController.navigationBar.translucent;
    [self.navigationController.navigationBar setTranslucent:NO];
    if (self.type == Redeem) {
        self.bkViewTopLay.constant = 0;
        self.navigationItem.title = @"赎回";
        self.redeemOrWithdrawCashLabel.text = @"赎回金额";
        self.allWithdrawButton.hidden = YES;
        self.quotaLabel.hidden = YES;
        [self.sureButton setTitle:@"确认赎回" forState:UIControlStateNormal];
        self.messageLab.text = @"1.工作日14:30前申请赎回当天16:00前回款至账户余额；\n2.工作日14:30后赎回的将在下一个工作日16:00前回款至账户余额";
    }else{
        self.navigationItem.title = @"提现";
        self.redeemOrWithdrawCashLabel.text = @"提现金额";
        [self.sureButton setTitle:@"确认提现" forState:UIControlStateNormal];
        self.allWithdrawButton.hidden = NO;
        self.quotaLabel.hidden = NO;
        self.messageLab.text = @"1. 提现手续费2元/笔;\n2. 到账时间说明：工作日15:00之前申请提现的，预计T+0个工作日到账；工作日16:00之后申请提现的，预计T+1个工作日到账(节假日时间顺延）。\n3. 单笔提现范围：100~50000元，单日不限笔数，不限金额。             （注：“T日”指工作日）";
        [self loadBankCard];
    }
}

- (void)loadBankCard
{
    WeakSelf
    [YBHttpTool postDataDifference:@"userWithdraw" params:nil success:^(id  _Nullable obj) {
        if (obj != nil) {
            XBTStateModel *stateModel = [XBTStateModel mj_objectWithKeyValues:obj[@"state"]];
            if (stateModel.status == ResultStatusSuccess) {
                NSString *number = obj[@"data2"][@"bankCardNo"];
                number = [number substringFromIndex:number.length - 4];
                weakSelf.bankCardNameAndNuber.text = [NSString stringWithFormat:@"(尾号%@)",number];
                weakSelf.canUseLabel.text = [NSString stringWithFormat:@"%@",obj[@"data1"][@"usableAmount"]];
                weakSelf.canUseAmout = [NSString stringWithFormat:@"%@",obj[@"data1"][@"usableAmount"]];
            }
        }
    } failure:^(NSError * _Nullable error) {
    }];
}

- (IBAction)allWithdrawCashButtonClick:(UIButton *)sender {
    self.amoutTF.text = self.canUseAmout;
}


- (IBAction)applyWithdrawCash:(UIButton *)sender {

    if (![XBTMatch isMoney:self.amoutTF.text] ) {
        [XBTProgressHUD showSuccess:@"请输入正确的金额"];
        return;
    }
    if (![XBTMatch isInteger:self.pwTF.text]) {
        [XBTProgressHUD showSuccess:@"请检查交易密码"];
        return;
    }
    if (self.type == WithdrawCash) {
        
        [self applyWithdrawCashPOST];   //提现
    }else{
        [self myDidiBaoRedeemPOST];     //赎回
    }
}

- (void)alertMessage
{
//    UIAlertView *alert = [UIAlertView alloc]initWithTitle:@"提现" message:"" delegate:<#(nullable id)#> cancelButtonTitle:<#(nullable NSString *)#> otherButtonTitles:<#(nullable NSString *), ...#>, nil
}



- (void)myDidiBaoRedeemPOST
{
    [self.navigationController popViewControllerAnimated:YES];
//    NSDictionary *params = @{@"shmoney":self.amoutTF.text,
//                             @"tradingPassword":self.pwTF.text
//                             };
//    WeakSelf
//    [YBHttpTool postDataDifference:@"applyRedeem" params:params success:^(id  _Nullable obj) {
//        if (obj!= nil) {
//            XBTStateModel *model = [XBTStateModel mj_objectWithKeyValues:obj[@"state"]];
//            [MBProgressHUD showSuccess:model.info];
//            if (model.status == ResultStatusSuccess) {
//
//            }
//        }
//    } failure:^(NSError * _Nullable error) {
//    }];
}

- (void)applyWithdrawCashPOST
{
//    [self scuessPushVC];
//    if ([self.amoutTF.text floatValue] < 100) {
//        [MBProgressHUD showSuccess:@"单笔提现最小额度为100元"];
//        return;
//    }
    NSDictionary *params = @{@"withdrawAmount":self.amoutTF.text,
                             @"pwd":self.pwTF.text
                             };
    WeakSelf
    [YBHttpTool postDataDifference:@"tongLianUserWithdraw" params:params success:^(id  _Nullable obj) {
        if (obj!=nil) {
            XBTStateModel *stateModel = [XBTStateModel mj_objectWithKeyValues:obj[@"state"]];
            [XBTProgressHUD showSuccess:stateModel.info];
            if (stateModel.status == ResultStatusSuccess) {
                [weakSelf scuessPushVC];
            }
        }
    } failure:^(NSError * _Nullable error) {
    }];
}

- (void)scuessPushVC
{
    XBTWithdrawCashingController *ingVC = [XBTWithdrawCashingController new];
    ingVC.amoutLabel.text = [NSString stringWithFormat:@"%@元",self.amoutTF.text];
    [self.navigationController DM_pushViewController:ingVC animated:YES];
}

@end
