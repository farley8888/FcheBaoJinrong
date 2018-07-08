//
//  XBTChangeLonginPWController.m
//  CheBaoJinRong
//
//  Created by apple on 2018/5/16.
//  Copyright © 2018年 apple. All rights reserved.
//

#import "XBTChangeLonginPWController.h"

@interface XBTChangeLonginPWController ()
@property (weak, nonatomic) IBOutlet UITextField *oldPassWordTF;
@property (weak, nonatomic) IBOutlet UITextField *nPassWordTextF;
@property (weak, nonatomic) IBOutlet UITextField *repeatPSTF;
@property (nonatomic, assign) BOOL navTranslucent;
@end

@implementation XBTChangeLonginPWController

- (void)viewDidLoad {
    [super viewDidLoad];

    self.navigationItem.title =  self.type == 1 ? @"修改登录密码":@"修改交易密码";
    self.navTranslucent = self.navigationController.navigationBar.translucent;
    [self.navigationController.navigationBar setTranslucent:NO];
    if (self.type !=1) {
        self.oldPassWordTF.keyboardType = UIKeyboardTypeNumberPad;
        self.nPassWordTextF.keyboardType = UIKeyboardTypeNumberPad;
        self.repeatPSTF.keyboardType = UIKeyboardTypeNumberPad;
    }
}

- (void)viewWillDisappear:(BOOL)animated
{
    [super viewWillDisappear:animated];
    [self.navigationController.navigationBar setTranslucent:self.navTranslucent];
}
    
- (void)verificationInformation
{
    if (self.oldPassWordTF.text.length == 0) {
        [MBProgressHUD showSuccess:@"请输入原密码"];
        return;
    }
    
    if (self.nPassWordTextF.text.length == 0) {
        [MBProgressHUD showSuccess:@"请输入新密码"];
        return;
    }
    
    if (![self.nPassWordTextF.text isEqualToString: self.repeatPSTF.text]) {
        [MBProgressHUD showSuccess:@"两次密码不一致，请重新输入"];
        return;
    }
    
    if (self.type == 1) {
        [self postInformation];
    }else{
        [self changeTransactionPSW];
    }
}

- (void)changeTransactionPSW
{
    if (self.oldPassWordTF.text.length != 6 || self.nPassWordTextF.text.length !=6) {
        [MBProgressHUD showSuccess:@"请输入6位交易密码"];
        return;
    }
    
    
    NSDictionary *params = @{@"address":self.oldPassWordTF.text,
                             @"reAddress":self.repeatPSTF.text
                             };
    WeakSelf
    [YBHttpTool postDataDifference:@"setUserPayPwd" params:params success:^(id  _Nullable obj) {
        if (obj!=nil) {
            XBTStateModel *sate = [XBTStateModel mj_objectWithKeyValues:obj[@"state"]];
            if (sate.status == ResultStatusSuccess) {
                [MBProgressHUD showSuccess:sate.info];
                [weakSelf.navigationController popViewControllerAnimated:YES];
            }else{
                [MBProgressHUD showSuccess:sate.info];
            }
        }
    } failure:^(NSError * _Nullable error) {
        
    }];
}

-(void)postInformation
{
    
//    if (self.oldPassWordTF.text.length < 6 || self.nPassWordTextF.text.length < 6) {
//        [MBProgressHUD showSuccess:@"请输入6~16位登录密码"];
//        return;
//    }
    
    if (self.oldPassWordTF.text.length > 16 || self.nPassWordTextF.text.length >16 || self.oldPassWordTF.text.length < 6 || self.nPassWordTextF.text.length < 6) {
        [MBProgressHUD showSuccess:@"请输入6~16位登录密码"];
        return;
    }
    NSDictionary *params = @{@"oldPass":self.oldPassWordTF.text,
                             @"newPass":self.repeatPSTF.text
                             };
    WeakSelf
    [YBHttpTool postDataDifference:@"updateUserPass" params:params success:^(id  _Nullable obj) {
        if (obj!= nil) {
            XBTStateModel *sate = [XBTStateModel mj_objectWithKeyValues:obj[@"state"]];
            if (sate.status == ResultStatusSuccess) {
                [MBProgressHUD showSuccess:sate.info];
                [weakSelf.navigationController popViewControllerAnimated:YES];
            }else{
                [MBProgressHUD showSuccess:sate.info];
            }
        }
    } failure:^(NSError * _Nullable error) {
        
    }];
}

- (IBAction)saveButton:(UIButton *)sender {
    [self verificationInformation];
}


@end
