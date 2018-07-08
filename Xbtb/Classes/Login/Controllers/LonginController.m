//
//  LonginController.m
//  XYG
//
//  Created by 张殿明 on 2017/11/13.
//  Copyright © 2017年 Mac. All rights reserved.
//

#import "LonginController.h"
#import "NSUserDefaults+Extension.h"
#import "XBTUserTool.h"
#import "XBTMatch.h"
#import "SelectVCTool.h"
#import "RegisterController.h"
#import "PasswordRetrievalController.h"
#import "UIButton+SD.h"
#import "UIImage+XBTIconFont.h"
#import "UIView+GradientColor.h"
#import "XBTNavigationBar.h"
#import "XBTAES.h"

#define Device [[[UIDevice currentDevice] identifierForVendor] UUIDString]

@interface LonginController ()
@property (weak, nonatomic) IBOutlet UITextField *phoneTF;  //手机号码
@property (weak, nonatomic) IBOutlet UITextField *passwordTF; //密码
@property (weak, nonatomic) IBOutlet UIButton *longinButton; //登陆按钮
@property (weak, nonatomic) IBOutlet UIImageView *passWordImageView; //密码图标
@property (weak, nonatomic) IBOutlet UIImageView *userImageIcon; //用户图标
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *loginTopLayout; //安全区域约束
@property (nonatomic, assign) NSInteger count; // 密码输错次数

@end

@implementation LonginController

- (void)viewDidLoad {
    [super viewDidLoad];

    [self setUpUI];
}

- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    [self.navigationController.navigationBar setTranslucent:YES];
    [self dm_setStatusBarStyle:UIStatusBarStyleLightContent];
    [self dm_setNavBarBarTintColor:[UIColor clearColor]];
    [self dm_setNavBarShadowImageHidden:YES];
    [self dm_setNavBarTitleColor:[UIColor whiteColor]];
    [self dm_setNavBarTintColor:[UIColor whiteColor]];
    [self dm_setNavBarBackgroundAlpha:0];
}

- (void)setUpUI
{

    UIBarButtonItem *rightButton = [[UIBarButtonItem alloc]initWithTitle:@"注册" style:UIBarButtonItemStyleDone target:self action:@selector(rightBarButtonClick)];
    self.navigationItem.rightBarButtonItem = rightButton;
    
    if (!self.isGesLockGetin) {
        UIBarButtonItem *leftButton = [[UIBarButtonItem alloc]initWithImage:[UIImage imageNamed:@"fh"] style:UIBarButtonItemStyleDone target:self action:@selector(leftBarButtonClick)];
        self.navigationItem.leftBarButtonItem = leftButton;
    }

    UIButton *passwordClean = [self.passwordTF valueForKey:@"_clearButton"]; //key是固定的
    [passwordClean setImage:[UIImage imageNamed:@"clear"] forState:UIControlStateNormal];
    UIButton *phoneClean = [self.phoneTF valueForKey:@"_clearButton"]; //key是固定的
    [phoneClean setImage:[UIImage imageNamed:@"clear"] forState:UIControlStateNormal];
    
    [self.phoneTF addTarget:self action:@selector(phoneTextFieldChange:) forControlEvents:UIControlEventEditingChanged];
    [self.passwordTF addTarget:self action:@selector(phoneTextFieldChange:) forControlEvents:UIControlEventEditingChanged];
    XBTUser *userDisk = [XBTUserTool getCurrentLoginUser];
    if (userDisk.userName != 0) {
        self.phoneTF.text = userDisk.userName;
    }
}

- (IBAction)bottomButtonClick:(id)sender {
    
    [self rightBarButtonClick];
}


- (void)rightBarButtonClick
{
    RegisterController *rgVC = [RegisterController new];
    [self.navigationController pushViewController:rgVC animated:YES];
}

- (void)leftBarButtonClick
{
    [UserManager sharedManager].user.isGiveUpLogin = YES;
    [self dismissViewControllerAnimated:YES completion:nil];
}

- (IBAction)loginButtonClick:(id)sender {
    [self.view endEditing:YES];
    NSString *phone = self.phoneTF.text;
    NSString *password = self.passwordTF.text;
    if (![XBTMatch isPhoneNum:phone]) {
        [MBProgressHUD showError:@"请输入正确的手机号码"];
        return;
    }
    if (password.length == 0) {
        [MBProgressHUD showSuccess:@"请输入密码"];
        return;
    }

    NSDictionary *params = @{@"userName":phone,
                             @"pwd":password,
                             };
    [MBProgressHUD showMessage:@"登录中..."];
    WeakSelf
    [YBHttpTool postDataDifference:@"login" params:params success:^(id  _Nullable obj) {
        [MBProgressHUD hideHUD];
        if (obj != nil) {
            XBTStateModel *model = [XBTStateModel mj_objectWithKeyValues:obj[@"state"]];
            
            if (model.status == ResultStatusSuccess) {
                [MBProgressHUD showSuccess:@"登录成功"];
                XBTUser *user = [XBTUser mj_objectWithKeyValues:obj];
                user.password = password;
                UserManager *userManager = [UserManager sharedManager];
                userManager.user = user;
                //把user保存到本地
                [XBTUserTool saveUser:user];
                //把登录记录保存到数据库中
                //[[YBDataBaseTool shareInstance] insertUser:user];
                [weakSelf dismissViewControllerAnimated:YES completion:^{
                    [kNotificationCenter postNotificationName:kLoginSuccessNotification object:nil];
                }];
                if(weakSelf.isGesLockGetin){
                    [SelectVCTool selectVC];
                }
            }else{
               [MBProgressHUD showSuccess:model.info];
            }
        }
    } failure:^(NSError * _Nullable error) {
        [MBProgressHUD hideHUD];
    }];
}

- (IBAction)registrButtonClick:(id)sender {
    
    RegisterController *regVC = [RegisterController new];
    [self.navigationController pushViewController:regVC animated:YES];
}

- (IBAction)forgetBUttoncliack:(id)sender {
    
    PasswordRetrievalController *passWordVC = [PasswordRetrievalController new];
    [self.navigationController pushViewController:passWordVC animated:YES];
}

- (void)keyboardWillShow:(NSNotification *)notification
{
    if (kScreenH > 568) {
        return;
    }
    NSDictionary *info = notification.userInfo;
    CGFloat keyboardH = [info[UIKeyboardFrameEndUserInfoKey] CGRectValue].size.height;
    [UIView animateWithDuration:[info[UIKeyboardAnimationDurationUserInfoKey] floatValue] animations:^{
        //        self.view.y = -(keyboardH-129+(!self.boottom.constant*20)+5);
        self.view.y = -100;
    }];
    
}
- (void)keyboardWillHide:(NSNotification *)notification
{
    if (kScreenH > 568) {
        return;
    }
    NSDictionary *info = notification.userInfo;
    CGFloat keyboardH = [info[UIKeyboardFrameEndUserInfoKey] CGRectValue].size.height;
    [UIView animateWithDuration:[info[UIKeyboardAnimationDurationUserInfoKey] floatValue] animations:^{
        self.view.y = 0;
    }];
}

- (void)phoneTextFieldChange:(UITextField *)textF
{
    if (textF.text.length >= 11 && textF == self.phoneTF) {
        textF.text = [textF.text substringToIndex:11];
    }else if (textF.text.length >= 16 && textF == self.passwordTF){
        
        textF.text = [textF.text substringToIndex:16];
    }
    DMLog(@"输入信息：%@",textF.text);
}


@end
