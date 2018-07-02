//
//  RegisterController.m
//  XYG
//
//  Created by 张殿明 on 2017/11/22.
//  Copyright © 2017年 Mac. All rights reserved.
//

#import "RegisterController.h"
#import "DMMatch.h"
#import "DMCountdownButton.h"
#import "MQVerCodeImageView.h"
#import "DMJSController.h"


@interface RegisterController ()<UITextFieldDelegate>

/**手机号码TF**/
@property (weak, nonatomic) IBOutlet UITextField *phoneNumberTF;
/**图片验证码TF**/
@property (weak, nonatomic) IBOutlet UITextField *verificationCodeTF;
/**图片验证码**/
@property (weak, nonatomic) IBOutlet UIView  *verificationCodeImageView;
/**短信验证码TF**/
@property (weak, nonatomic) IBOutlet UITextField *messageVerificationCodeTF;
/**获取短信验证码Button**/
@property (weak, nonatomic) IBOutlet DMCountdownButton *getMessageCodeButton;
/**等录密码TF**/
@property (weak, nonatomic) IBOutlet UITextField *loginTF;
/**推荐码TF**/
@property (weak, nonatomic) IBOutlet UITextField *recommendCode;
/**注册按钮**/
@property (weak, nonatomic) IBOutlet UIButton *nextButton;
@property (weak, nonatomic) IBOutlet UIButton *agreeButton;
@property (weak, nonatomic) IBOutlet UIScrollView *scrollerView;

@property (nonatomic, strong) MQVerCodeImageView *imageView;

@end

@implementation RegisterController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.navigationItem.title = @"注册";
    [self loadImage];
    [self.phoneNumberTF addTarget:self action:@selector(textFieldTextChange:) forControlEvents:UIControlEventEditingChanged];
    [self.loginTF addTarget:self action:@selector(recommendCodeTextFieldChange:) forControlEvents:UIControlEventEditingChanged];
    [self.recommendCode addTarget:self action:@selector(recommendCodeTextFieldChange:) forControlEvents:UIControlEventEditingChanged];
    
    MQVerCodeImageView *imageView = [[MQVerCodeImageView alloc]initWithFrame:self.verificationCodeImageView.bounds];
    imageView.isRotation = NO;
    self.imageView = imageView;

    //点击刷新
    UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(tapClick:)];
    [imageView addGestureRecognizer:tap];
    [self.verificationCodeImageView addSubview: imageView];
    UITapGestureRecognizer *gesture = [[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(hideKeyBoard)];
    gesture.cancelsTouchesInView = NO;
    [self.scrollerView addGestureRecognizer:gesture];

}

- (void)hideKeyBoard
{
    [self.view endEditing:YES];
}

- (void)tapClick:(UITapGestureRecognizer*)tap
{
    [self loadImage];
}

- (void)loadImage
{
    NSString *noncestr = [Device stringByReplacingOccurrencesOfString:@"-" withString:@""];
    DMLog(@"去除-的udid--%@",noncestr);
    NSDictionary *params = @{@"noncestr":noncestr};
    WeakSelf
    [YBHttpTool postDataDifference:@"getImageCode" params:params success:^(id  _Nullable obj) {
        if (obj!=nil) {
            DMLog(@"图片验证码--%@",obj[@"checkcode"]);
            weakSelf.imageView.imageCodeStr = [NSString stringWithFormat:@"%@",obj[@"checkcode"]];
            [weakSelf.imageView freshVerCode];
        }
    } failure:^(NSError * _Nullable error) {
        
    }];
    
}

- (IBAction)getButtonClick:(DMCountdownButton *)sender {
    
    if (![DMMatch isPhoneNum:self.phoneNumberTF.text]) {
        [MBProgressHUD showSuccess:@"请输入正确的手机号码"];
        return;
    }
    if (self.verificationCodeTF.text.length == 0) {
        [MBProgressHUD showSuccess:@"请输入正确的图片验证码"];
        return;
    }
    [self sendVerifCode];
}

/** 发送短信验证码 **/
- (void)sendVerifCode
{
    DMCountdownButton  *btn = self.getMessageCodeButton;
    btn.enabled = NO;
    NSString *noncestr = [Device stringByReplacingOccurrencesOfString:@"-" withString:@""];
    NSDictionary *dict = @{@"cellPhone":self.phoneNumberTF.text,
                           @"imgCode":self.verificationCodeTF.text,
                           @"noncestr":noncestr
                           };
    
    [YBHttpTool postDataDifference:@"getPhoneCodeByImageCode" params:dict success:^(id  _Nullable obj) {
        btn.enabled = YES;
        if (obj!=nil) {
            if ([obj[@"status"] isEqualToString:@"y"]) {
                btn.timeCount = 60;
                [btn start];
            }else{
                [MBProgressHUD showSuccess:obj[@"info"]];
            }
        }
    } failure:^(NSError * _Nullable error) {
         btn.enabled = YES;
    }];

}
/**  验证手机号码是否可以注册  **/
- (void)verificationPhoneCanUse:(NSString *)phoneNum
{
    if (![DMMatch isPhoneNum:phoneNum]) {
        [MBProgressHUD showSuccess:@"请输入正确的手机号码"];
        return;
    }
    [YBHttpTool postDataDifference:@"verificationNewUserPhone" params:@{@"userPhone":phoneNum} success:^(id  _Nullable obj) {
        if (obj!=nil) {
            if ([obj[@"state"][@"status"] integerValue] != ResultStatusSuccess) {
                [MBProgressHUD showSuccess:obj[@"state"][@"info"]];
            }
            DMLog(@"是否可用--%@",obj[@"state"][@"info"]);
        }
    } failure:^(NSError * _Nullable error) {
        
    }];
}

/**  验证推荐码是否可用  **/
- (void)verificationRecommendCode:(NSString *)recommendCode
{
    [YBHttpTool postDataDifference:@"chackRefereeUser" params:@{@"regReferee":recommendCode} success:^(id  _Nullable obj) {
        if (obj!= nil) {
            if ([obj[@"state"][@"status"] integerValue] == ResultStatusSuccess) {
                DMLog(@"推荐码：%@",obj[@"info"]);
            }else{
                [MBProgressHUD showSuccess:obj[@"info"]];
            }
        }
    } failure:^(NSError * _Nullable error) {
        
    }];
}

- (void)registUser
{
    NSDictionary *params = @{@"cellPhone":self.phoneNumberTF.text,
                             @"pwd":self.loginTF.text,
                             @"RegCode":self.messageVerificationCodeTF.text,
                             @"referee":self.recommendCode.text
                             };
    WeakSelf
    [YBHttpTool postDataDifference:@"regist" params:params success:^(id  _Nullable obj) {
        if (obj!= nil) {
            DMStateModel *model = [DMStateModel mj_objectWithKeyValues:obj[@"state"]];
            [MBProgressHUD showSuccess:model.info];
            if (model.status == ResultStatusSuccess) {
                [weakSelf.navigationController popViewControllerAnimated:YES];
            }
        }
    } failure:^(NSError * _Nullable error) {
        
    }];
}


- (IBAction)nextButtonClick:(UIButton *)sender {
    
    BOOL canPost = YES;
    NSString *title = @"";
    if (![DMMatch isPhoneNum:self.recommendCode.text] && self.recommendCode.text.length !=0) {
        title = @"请输入正确的推荐码";
        canPost = NO;
    }
    if (self.loginTF.text.length < 6 || self.loginTF.text.length > 16) {
        title = @"请输入6~16位密码组合";
        canPost = NO;
    }
    if (!self.agreeButton.selected) {
        title = @"请勾选服务协议";
        canPost = NO;
    }
    if (self.messageVerificationCodeTF.text.length == 0) {
        title = @"请输入短信验证码";
        canPost = NO;
    }
    if (![DMMatch isPhoneNum:self.phoneNumberTF.text]) {
        title = @"请输入手机号码";
        canPost = NO;
    }
    if (self.verificationCodeTF.text.length == 0) {
        title = @"请输入图形验证码";
        canPost = NO;
    }
    if (canPost) {
        DMLog(@"可以发送请求");
        [self registUser];
    }else{
        [MBProgressHUD showSuccess:title];
    }
}
- (IBAction)xieyiButtonClick:(id)sender {
    DMJSController  *jsVC = [DMJSController  new];
    jsVC.title = @"注册协议";
    jsVC.url = [NSString stringWithFormat:@"%@/wechat/regagreement.html",kAPI_URL];
    [self.navigationController pushViewController:jsVC animated:YES];
}

- (IBAction)argeeButtonClick:(UIButton *)sender {
    sender.selected =!sender.selected;
}

- (void)textFieldTextChange:(UITextField *)tf
{
    if (tf.text.length >= 11) {
        self.phoneNumberTF.text = [tf.text substringToIndex:11];
        [self verificationPhoneCanUse:tf.text];
    }
    DMLog(@"输入信息：%@",tf.text);
}

- (void)recommendCodeTextFieldChange:(UITextField *)textF
{
    if (textF.text.length >= 11 && textF == self.recommendCode) {
        textF.text = [textF.text substringToIndex:11];
    }else if (textF.text.length >= 16 && textF == self.loginTF){
        
        textF.text = [textF.text substringToIndex:16];
    }
    DMLog(@"输入信息：%@",textF.text);
}


@end
