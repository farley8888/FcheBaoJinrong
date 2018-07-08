//
//  PasswordRetrievalController.m
//  XYG
//
//  Created by 张殿明 on 2017/11/13.
//  Copyright © 2017年 Mac. All rights reserved.
//

#import "PasswordRetrievalController.h"
#import "XBTMatch.h"
#import "XBTCountdownButton.h"

@interface PasswordRetrievalController ()
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *viewTopLayout;
@property (weak, nonatomic) IBOutlet UITextField *phoneTF;
@property (weak, nonatomic) IBOutlet UIButton *getCodeButton;
@property (weak, nonatomic) IBOutlet UITextField *codeTextF;
@property (weak, nonatomic) IBOutlet UITextField *nPWTextF;

@end

@implementation PasswordRetrievalController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.navigationItem.title = @"忘记密码";
    self.viewTopLayout.constant = SafeAreaTopHeight;
    [self.phoneTF addTarget:self action:@selector(phoneTFChangeText:) forControlEvents:UIControlEventEditingChanged];
    [self.nPWTextF addTarget:self action:@selector(phoneTFChangeText:) forControlEvents:UIControlEventEditingChanged];
}
- (IBAction)sendCodeButtonClick:(XBTCountdownButton *)sender {
    if (![XBTMatch isPhoneNum:self.phoneTF.text]) {
        [MBProgressHUD showSuccess:@"请输入正确的手机号码"];
        return;
    }
    sender.enabled = NO;
    [YBHttpTool postDataDifference:@"getPhoneCode2" params:@{@"cellPhone":self.phoneTF.text} success:^(id  _Nullable obj) {
        if (obj!= nil) {
            sender.enabled = YES;
            [MBProgressHUD showSuccess:obj[@"state"][@"info"]];
            if ([obj[@"state"][@"status"] isEqualToString:@"y"] ) {
                sender.timeCount = 60;
                [sender start];
            }
        }
    } failure:^(NSError * _Nullable error) {
        sender.enabled = YES;
    }];
}

- (IBAction)nextCode:(id)sender {

    BOOL canPost = YES;
    NSString *title = @"";

    if (self.nPWTextF.text.length < 6 || self.nPWTextF.text.length > 16) {
        title = @"请输入6~16位密码组合";
        canPost = NO;
    }

    if (self.codeTextF.text.length == 0) {
        title = @"请输入短信验证码";
        canPost = NO;
    }
    if (![XBTMatch isPhoneNum:self.phoneTF.text]) {
        title = @"请输入手机号码";
        canPost = NO;
    }

    if (canPost) {
        DMLog(@"可以发送请求");
        [self changePassWord];
    }else{
        [MBProgressHUD showSuccess:title];
    }
}

- (void)changePassWord
{
    NSDictionary *params = @{@"phone":self.phoneTF.text,
                             @"telCode":self.codeTextF.text,
                             @"forGetpassword":self.nPWTextF.text
                             };
    WeakSelf
    [YBHttpTool postDataDifference:@"updateforGetPass" params:params success:^(id  _Nullable obj) {
        if (obj!= nil) {
            XBTStateModel *stateModel = [XBTStateModel mj_objectWithKeyValues:obj[@"state"]];
            if (stateModel.status == ResultStatusSuccess) {
                [MBProgressHUD showSuccess:stateModel.info];
                [weakSelf.navigationController popViewControllerAnimated:YES];
            }
        }
    } failure:^(NSError * _Nullable error) {
        
    }];
}

/**  验证手机号码是否注册  **/
- (void)verificationPhoneNumber:(NSString *)phoneNumber
{
    if (![XBTMatch isPhoneNum:phoneNumber]) {
        [MBProgressHUD showSuccess:@"请输入正确的手机号码"];
        return;
    }
    WeakSelf
    NSDictionary *params = @{@"param":phoneNumber};
    [YBHttpTool postDataDifference:@"forGetPassPhone" params:params success:^(id  _Nullable obj) {
        if (obj!=nil) {
            if ([obj[@"state"][@"status"] integerValue] == ResultStatusSuccess) {
                weakSelf.getCodeButton.userInteractionEnabled = YES;
                [weakSelf.getCodeButton setTitleColor:kColor(236, 128, 57) forState:UIControlStateNormal];
            }else{
                [MBProgressHUD showSuccess:@"请检查手机号码是否正确及注册"];
                weakSelf.getCodeButton.userInteractionEnabled = NO;
                [weakSelf.getCodeButton setTitleColor:[UIColor lightGrayColor] forState:UIControlStateNormal];
            }
        }
    } failure:^(NSError * _Nullable error) {
        
    }];
}

- (void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event
{
    [self.view endEditing:YES];
}

- (void)phoneTFChangeText:(UITextField *)textField
{
    if (textField.text.length >= 11 && textField == self.phoneTF) {
        textField.text = [textField.text substringToIndex:11];
        [self verificationPhoneNumber:textField.text];
    }else if (textField.text.length >= 16 && textField == self.nPWTextF ){
        
        textField.text = [textField.text substringToIndex:16];
    }
    DMLog(@"手机号码输入：%@",textField.text);
}


@end
