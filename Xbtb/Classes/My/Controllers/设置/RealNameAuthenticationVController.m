//
//  RealNameAuthenticationVController.m
//  CheBaoJinRong
//
//  Created by apple on 2018/5/16.
//  Copyright © 2018年 apple. All rights reserved.
//

#import "RealNameAuthenticationVController.h"
#import "XBTRealNameModel.h"
#import "XBTUserTool.h"

@interface RealNameAuthenticationVController ()

@property (weak, nonatomic) IBOutlet UILabel *nameLabel;
@property (weak, nonatomic) IBOutlet UITextField *nameTextF;
@property (weak, nonatomic) IBOutlet UILabel *cardLabel;
@property (weak, nonatomic) IBOutlet UITextField *cardTextF;
@property (weak, nonatomic) IBOutlet UIButton *sureButton;
@property (nonatomic, assign) BOOL navTranslucent;

@end

@implementation RealNameAuthenticationVController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self setUI];
    if (self.type == RealNameAuthentication) {
        [self loadAccountData];
    }
}
    
- (void)viewWillDisappear:(BOOL)animated
{
    [super viewWillDisappear:animated];
    [self.navigationController.navigationBar setTranslucent:self.navTranslucent];
}
    
- (void)setUI
{
    self.navTranslucent = self.navigationController.navigationBar.translucent;
//
    [self.navigationController.navigationBar setTranslucent:NO];

    self.navigationItem.title = self.type == 0?@"实名认证":@"修改交易密码";
    if (self.type == TransactionPassWord) {
        self.nameLabel.text = @"新密码";
        self.nameTextF.placeholder = @"请输入新交易密码";
        self.cardLabel.text = @"确认新密码";
        self.cardTextF.placeholder = @"请输入新交易密码";
        [self.sureButton setTitle:@"保存" forState:UIControlStateNormal];
    }
}

- (void)loadAccountData
{
    WeakSelf
    [YBHttpTool postDataDifference:@"userPerson" params:nil success:^(id  _Nullable obj) {
        
        if (obj!= nil) {
            XBTStateModel *stateModel = [XBTStateModel mj_objectWithKeyValues:obj[@"state"]];
            if (stateModel.status == ResultStatusSuccess) {
                XBTRealNameModel *realModel = [XBTRealNameModel mj_objectWithKeyValues:obj[@"tPerson"]];
                if (realModel.cardNo.length != 0 && realModel.realName.length != 0) {
                    weakSelf.nameTextF.text = [realModel.realName stringByReplacingCharactersInRange:NSMakeRange(1, realModel.realName.length-1) withString:@"**"];
                    weakSelf.nameTextF.userInteractionEnabled = NO;
                    weakSelf.cardTextF.text = [realModel.cardNo stringByReplacingCharactersInRange:NSMakeRange(4, realModel.cardNo.length - 8) withString:@"**** **** ****"];
                    weakSelf.cardTextF.userInteractionEnabled = NO;
                    [weakSelf.sureButton setTitle:@"已认证" forState:UIControlStateNormal];
                    weakSelf.sureButton.userInteractionEnabled = NO;
                }
            }
        }
    } failure:^(NSError * _Nullable error) {
        
    }];
    
}


- (IBAction)buttonClick:(UIButton *)sender {
    
    [self verificationInformation];
}

- (void)verificationInformation
{
    NSString *str = nil;
    NSString *str1 = nil;
    
    if (self.type == TransactionPassWord) {
        str = @"请输入正确的密码";
        str1 = @"两次密码输入不一致";
    }else{
        str = @"请输入正确的姓名";
        str1 = @"请输入正确的身份证号码";
    }
    
    if (self.nameTextF.text.length == 0 || self.nameTextF.text.length == 1 ) {
        [XBTProgressHUD showSuccess:str];
        return;
    }
    if (self.type != TransactionPassWord) {
        if (self.cardTextF.text.length != 18) {
            [XBTProgressHUD showSuccess:str1];
            return;
        }
    }else{
        if (self.nameTextF.text.length != 6 || self.cardTextF.text.length != 6) {
            [XBTProgressHUD showSuccess:@"请输入6位交易密码"];
            return;
        }
        
        if(self.nameTextF.text != self.cardTextF.text){
            [XBTProgressHUD showSuccess:str1];
            return;
        }
    }
    if (self.type == TransactionPassWord) {
        [self changeTransaction];
    }else{
        [self realNamePost];
    }
    
}

- (void)changeTransaction
{
    NSDictionary *params = @{@"address":self.nameTextF.text,
                             @"reAddress":self.cardTextF.text
                             };
    WeakSelf
    [YBHttpTool postDataDifference:@"setUserPayPwd" params:params success:^(id  _Nullable obj) {
        if (obj!=nil) {
            XBTStateModel *stateModel = [XBTStateModel mj_objectWithKeyValues:obj[@"state"]];
            [XBTProgressHUD showSuccess:stateModel.info];
            if (stateModel.status == ResultStatusSuccess) {
                [weakSelf.navigationController popViewControllerAnimated:YES];
            }
        }
    } failure:^(NSError * _Nullable error) {
        
    }];
}

- (void)realNamePost
{
    NSDictionary *params = @{@"name":self.nameTextF.text,
                             @"idCard":self.cardTextF.text
                             };
    WeakSelf
    [YBHttpTool postDataDifference:@"center/smrz2" params:params success:^(id  _Nullable obj) {
        if (obj!=nil) {
//            XBTStateModel *stateModel = [XBTStateModel mj_objectWithKeyValues:obj[@"state"]];
            NSString *state = obj[@"status"];
            if ([state isEqualToString:@"y"]) {
                
                [UserManager sharedManager].user.realName = self.nameTextF.text;
                [XBTUserTool saveUser:[UserManager sharedManager].user];
                
                [weakSelf.navigationController popViewControllerAnimated:YES];
            }
                [XBTProgressHUD showSuccess:obj[@"info"]];
        }
    } failure:^(NSError * _Nullable error) {
        
    }];
}

@end
