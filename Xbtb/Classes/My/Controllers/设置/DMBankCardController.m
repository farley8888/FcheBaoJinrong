//
//  DMBankCardController.m
//  CheBaoJinRong
//
//  Created by apple on 2018/5/16.
//  Copyright © 2018年 apple. All rights reserved.
//

#import "DMBankCardController.h"
#import "XBTMatch.h"
#import "DMUserTool.h"

@interface DMBankCardController ()
@property (weak, nonatomic) IBOutlet UILabel *realNameLabel;
@property (weak, nonatomic) IBOutlet UITextField *cardTextF;
@property (weak, nonatomic) IBOutlet UITextField *phoneTextF;
@property (weak, nonatomic) IBOutlet UITextField *cityTF;
@property (weak, nonatomic) IBOutlet UITextField *subbranchTF;
@property (nonatomic, assign) BOOL navTranslucent;

@end

@implementation DMBankCardController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.navigationItem.title = @"绑定银行卡";
    self.realNameLabel.text = [UserManager  sharedManager].user.realName;
    self.navTranslucent = self.navigationController.navigationBar.translucent;
    //
    [self.navigationController.navigationBar setTranslucent:NO];
    
}
    
- (void)viewWillDisappear:(BOOL)animated
{
    [super viewWillDisappear:animated];
    [self.navigationController.navigationBar setTranslucent:self.navTranslucent];
}
    
- (IBAction)bindingBankButtonClick:(UIButton *)sender {
    [self verificationInformation];
}

- (void)verificationInformation
{
    if (self.cardTextF.text.length < 16) {
        [MBProgressHUD showSuccess:@"请输入正确的银行卡号"];
        return;
    }
    if (![XBTMatch isPhoneNum:self.phoneTextF.text]) {
        [MBProgressHUD showSuccess:@"请输入正确的手机号码"];
        return;
    }
    if (self.cityTF.text.length == 0) {
        [MBProgressHUD showSuccess:@"请输入所属市/县"];
        return;
    }
    if (self.subbranchTF.text.length == 0) {
        [MBProgressHUD showSuccess:@"请输入开户行名称"];
        return;
    }
    
    [self bindingBankCard];
}

- (void)bindingBankCard
{
    
    NSDictionary *params = @{@"phone":self.phoneTextF.text,
                             @"bankCardNo":self.cardTextF.text,
                             @"citycode":self.cityTF.text,
                             @"subBankName":self.subbranchTF.text
                             };
//    bandBank   url不需要app
    WeakSelf
    [YBHttpTool postDataDifference:@"bandBank2" params:params success:^(id  _Nullable obj) {
        if (obj!= nil) {
            DMStateModel *model = [DMStateModel mj_objectWithKeyValues:obj[@"state"]];
            if (model.status == ResultStatusSuccess) {
                [UserManager sharedManager].user.bankCardNo = weakSelf.phoneTextF.text;
                [DMUserTool saveUser:[UserManager sharedManager].user];
                [weakSelf.navigationController popViewControllerAnimated:YES];
            }
            [MBProgressHUD showSuccess:model.info];
        }
    } failure:^(NSError * _Nullable error) {
        
    }];
}




@end
