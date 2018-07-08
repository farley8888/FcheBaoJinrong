//
//  DMGesturePasswordController.m
//  CheBaoJinRong
//
//  Created by apple on 2018/5/29.
//  Copyright © 2018年 apple. All rights reserved.
//

#import "XBTGesturePasswordController.h"
#import "GestureLockViewController.h"
#import "GestureLockView.h"
#import "GestureLockIndicator.h"
#import "SelectVCTool.h"
#import "XBTUserTool.h"
#import "RegisterController.h"
#import "DMNavigationBar.h"
#import "LonginController.h"
#import "UIAlertView+Block.h"
#import "XBTNavigationController.h"
#import "XBTMainController.h"
#import "UINavigationController+DM.h"
#import "XBTUserTool.h"

@interface XBTGesturePasswordController () <DMGestureLockDelegate, UIAlertViewDelegate>
// 手势状态栏提示label
@property (weak, nonatomic) UILabel *statusLabel;
//// 其他账户登录按钮
//@property (weak, nonatomic) UIButton *otherAcountBtn;

@property (strong, nonatomic) GestureLockView *gestureLockView;
@property (strong, nonatomic) GestureLockIndicator *gestureLockIndicator;
@property (nonatomic, strong) UIImageView *topImageView;
@property (nonatomic) DMUnlockType unlockType;

@end

@implementation XBTGesturePasswordController

- (void)dealloc
{
    DMLog(@"%s",__func__);
    [kNotificationCenter removeObserver:self];
}

- (void)viewDidLoad {
    [super viewDidLoad];

    self.unlockType = DMUnlockTypeValidatePsw;
    [self setUI];
    [self setupMainUI];
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

- (void)setUI
{
    UIBarButtonItem *rightButton = [[UIBarButtonItem alloc]initWithTitle:@"注册" style:UIBarButtonItemStyleDone target:self action:@selector(rightBarButtonClick)];
    self.navigationItem.rightBarButtonItem = rightButton;
    
    UIImageView *imageView = [[UIImageView alloc]init];
    self.topImageView = imageView;
    imageView.frame = CGRectMake(-5, 0, kScreenW+10, kScreenW/(75.0/47.0));
    imageView.image = [UIImage imageNamed:@"login_wode"];
    [self.view addSubview:imageView];
    [kNotificationCenter addObserver:self selector:@selector(loginSuccess) name:kLoginSuccessNotification object:nil];
}

// 创建界面
- (void)setupMainUI {
    
    self.view.backgroundColor = [UIColor whiteColor];
    CGFloat btnH = 30;
    
    // 手势状态栏提示label
    UILabel *statusLabel = [[UILabel alloc]initWithFrame:CGRectMake((self.view.frame.size.width - 200) * 0.5,CGRectGetMaxY(self.topImageView.frame)+20 , 200, 30)];
    statusLabel.textAlignment = NSTextAlignmentCenter;
    statusLabel.text = @"请绘制手势密码";
    statusLabel.font = [UIFont systemFontOfSize:12];
    statusLabel.textColor = [UIColor redColor];
    [self.view addSubview:statusLabel];
    self.statusLabel = statusLabel;
    
    // 九宫格 手势密码页面
    GestureLockView *gestureLockView = [[GestureLockView alloc]initWithFrame:CGRectMake(0,CGRectGetMaxY(statusLabel.frame)+5, kScreenW *0.8, kScreenW *0.8)];
    gestureLockView.centerX = self.view.centerX;
    gestureLockView.delegate = self;
    [self.view addSubview:gestureLockView];
    self.gestureLockView = gestureLockView;
    
    // 底部三个控件
    UIButton *forgetBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    forgetBtn.frame = CGRectMake((kScreenW *0.2)/2.0, CGRectGetMaxY(gestureLockView.frame), (kScreenW *0.8)/2-10, btnH);
    forgetBtn.backgroundColor = [UIColor clearColor];
    forgetBtn.contentHorizontalAlignment = UIControlContentHorizontalAlignmentRight;
    [forgetBtn setTitle:@"忘记手势密码" forState:UIControlStateNormal];
    forgetBtn.titleLabel.font = [UIFont systemFontOfSize:12];
    [forgetBtn setTitleColor:[UIColor colorWithRed:102/255.0 green:102/255.0 blue:102/255.0 alpha:1] forState:UIControlStateNormal];
    [forgetBtn addTarget:self action:@selector(otherAccountLogin:) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:forgetBtn];
    
    UIView *lineView = [[UIView alloc]initWithFrame:CGRectMake(0, CGRectGetMaxY(forgetBtn.frame), 1, 15)];
    lineView.centerX = self.view.centerX;
    lineView.centerY = forgetBtn.centerY;
    lineView.backgroundColor = [UIColor darkGrayColor];
    [self.view addSubview:lineView];
    
    UIButton *otherButton = [UIButton buttonWithType:UIButtonTypeCustom];
    otherButton.frame = CGRectMake(CGRectGetMaxX(lineView.frame)+10, CGRectGetMaxY(gestureLockView.frame), (kScreenW *0.8)/2-10, btnH);
    otherButton.backgroundColor = [UIColor clearColor];
    otherButton.contentHorizontalAlignment = UIControlContentHorizontalAlignmentLeft;
    [otherButton setTitle:@"用户名登录" forState:UIControlStateNormal];
    otherButton.titleLabel.font = [UIFont systemFontOfSize:12];
    [otherButton setTitleColor:[UIColor colorWithRed:102/255.0 green:102/255.0 blue:102/255.0 alpha:1] forState:UIControlStateNormal];
    [otherButton addTarget:self action:@selector(userNameLogin) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:otherButton];
}

#pragma mark - 点击事件
//用户名登录
- (void)userNameLogin
{
    DMLog(@"%s",__FUNCTION__);
//    [self gotoLoginVC];
    LonginController *logVC = [LonginController new];
    logVC.isGesLockGetin = 1;
    [self.navigationController pushViewController:logVC animated:YES];
}

// 点击忘记手势密码
- (void)otherAccountLogin:(id)sender {
    DMLog(@"%s",__FUNCTION__);
//    [self gotoLoginVC];
    LonginController *logVC = [LonginController new];
    logVC.isGesLockGetin = 1;
    [self.navigationController pushViewController:logVC animated:YES];
}

- (void)rightBarButtonClick
{
    RegisterController *rgVC = [RegisterController new];
    [self.navigationController pushViewController:rgVC animated:YES];
}

- (void)loginSuccess
{
    [SelectVCTool selectVC];
}

// 验证手势密码
- (void)validateGesturesPassword:(NSMutableString *)gesturesPassword {
    
    static NSInteger errorCount = 5;
    DMLog(@"手势密码：%@",[GestureLockViewController gesturesPassword]);
    if ([gesturesPassword isEqualToString:[GestureLockViewController gesturesPassword]]) {
        errorCount = 5;
        [XBTUserTool login:[XBTUserTool getCurrentLoginUser]];  //自动登录
    } else {
        if (errorCount - 1 == 0) { // 你已经输错五次了！ 退出重新登陆！
            UIAlertView *alertView = [[UIAlertView alloc] initWithTitle:@"手势密码已失效" message:@"请重新登陆" delegate:self cancelButtonTitle:nil otherButtonTitles:@"重新登陆", nil];
            [alertView show];
            errorCount = 5;
            return;
        }
        self.statusLabel.text = [NSString stringWithFormat:@"密码错误，还可以再输入%ld次",--errorCount];
        [self shakeAnimationForView:self.statusLabel];
    }
}

- (void)alertView:(UIAlertView *)alertView clickedButtonAtIndex:(NSInteger)buttonIndex
{
    [self gotoLoginVC];
}

- (void)gotoLoginVC
{
    LonginController *logVC = [LonginController new];
    logVC.isGesLockGetin = 1;
    [self.navigationController DM_pushViewController:logVC animated:YES];
}

// 抖动动画
- (void)shakeAnimationForView:(UIView *)view {
    
    CALayer *viewLayer = view.layer;
    CGPoint position = viewLayer.position;
    CGPoint left = CGPointMake(position.x - 10, position.y);
    CGPoint right = CGPointMake(position.x + 10, position.y);
    
    CABasicAnimation *animation = [CABasicAnimation animationWithKeyPath:@"position"];
    [animation setTimingFunction:[CAMediaTimingFunction functionWithName:kCAMediaTimingFunctionEaseInEaseOut]];
    [animation setFromValue:[NSValue valueWithCGPoint:left]];
    [animation setToValue:[NSValue valueWithCGPoint:right]];
    [animation setAutoreverses:YES]; // 平滑结束
    [animation setDuration:0.08];
    [animation setRepeatCount:3];
    
    [viewLayer addAnimation:animation forKey:nil];
}

#pragma mark - DMgestureLockViewDelegate

- (void)gestureLockView:(GestureLockView *)lockView drawRectFinished:(NSMutableString *)gesturePassword {
    
    [self validateGesturesPassword:gesturePassword];
}

@end
