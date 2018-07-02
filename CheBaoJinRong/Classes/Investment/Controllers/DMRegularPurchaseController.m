//
//  DMRegularPurchaseController.m
//  CheBaoJinRong
//
//  Created by apple on 2018/5/28.
//  Copyright © 2018年 apple. All rights reserved.
//

#import "DMRegularPurchaseController.h"
#import "DMMyCouponController.h"        //我的优惠券
#import "DMMatch.h"
#import "DMInputPSWController.h"
#import "DMJSController.h"
#import "DMRechargeController.h"        //充值

@interface DMRegularPurchaseController ()
/**  标题  **/
@property (weak, nonatomic) IBOutlet UILabel *titleLabel;
/**  年化利率率  **/
@property (weak, nonatomic) IBOutlet UILabel *profitScareLabel;
/**  出借期限  **/
@property (weak, nonatomic) IBOutlet UILabel *investmentTimeLabel;
/**  剩余可投  **/
@property (weak, nonatomic) IBOutlet UILabel *surplusLabel;
/**  出借金额TF  **/
@property (weak, nonatomic) IBOutlet UITextField *moneyTF;
/**  账户余额  **/
@property (weak, nonatomic) IBOutlet UILabel *balanceLabel;
/**  预期利息  **/
@property (weak, nonatomic) IBOutlet UILabel *expectedEarningsLabel;
@property (weak, nonatomic) IBOutlet UIScrollView *scrollerView;
@property (weak, nonatomic) IBOutlet UIButton *selectCoupButton;
@property (weak, nonatomic) IBOutlet UIButton *agreeButton;
@property (weak, nonatomic) IBOutlet UIButton *sureBrowButton;


@property (weak, nonatomic) IBOutlet UISlider *slider;
@property (nonatomic, assign) CGFloat canuseMoney;
@property (nonatomic, assign) NSInteger coupontype;  //优惠券类型
@property (nonatomic, assign) NSInteger couponid;    //优惠券id
@property (nonatomic, copy) NSString *psw;

@property (nonatomic, assign) BOOL navTranslucent;
    
@end

@implementation DMRegularPurchaseController

- (void)dealloc
{
    DMLog(@"%s",__func__);
}

- (void)viewDidLoad {
    [super viewDidLoad];
    [self setUI];
    [self loadData];
}
    
- (void)viewWillDisappear:(BOOL)animated
{
    [super viewWillDisappear:animated];
    [self.navigationController.navigationBar setTranslucent:self.navTranslucent];
}

- (void)setUI
{
    self.navigationItem.title = @"购买";
    self.navTranslucent = self.navigationController.navigationBar.translucent;
    [self.navigationController.navigationBar setTranslucent:NO];
    UITapGestureRecognizer *gesture = [[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(hideKeyBoard)];
    gesture.cancelsTouchesInView = NO;
    [self.scrollerView addGestureRecognizer:gesture];
    
    self.titleLabel.text = self.regModel.borrowTitle;
    self.profitScareLabel.text = [NSString stringWithFormat:@"%.1f%%+1%%",(self.regModel.annualRate - 1)] ;
//    [self.sureBrowButton setBackgroundColor:[UIColor lightGrayColor]];
//    self.sureBrowButton.userInteractionEnabled = NO;
    
    if ([self.regModel.borrowTitle containsString:@"新手标"]) {
        self.profitScareLabel.text = [NSString stringWithFormat:@"%.1f%%+3%%",(self.regModel.annualRate - 3.0)];
    }else{
        self.profitScareLabel.text = [NSString stringWithFormat:@"%.1f%%+1%%",(self.regModel.annualRate - 1.0)];
    }
    
    if (self.regModel.deadlineType == 1) {
        self.investmentTimeLabel.text = [NSString stringWithFormat:@"出借期限:%ld天",(long)self.regModel.deadline];
    }else{
        self.investmentTimeLabel.text = [NSString stringWithFormat:@"出借期限:%ld月",(long)self.regModel.deadline];
    }
    self.surplusLabel.text = [NSString stringWithFormat:@"剩余可投:%.2f",self.regModel.borrowAmount - self.regModel.hasBorrowAmount];
    [self.slider setThumbImage:[UIImage imageNamed:@"dangqianjindu"] forState:UIControlStateNormal];
    self.slider.userInteractionEnabled = NO;
    self.slider.value = self.regModel.hasBorrowAmount/self.regModel.borrowAmount;
    [self.moneyTF addTarget:self action:@selector(textFieldEditing:) forControlEvents:UIControlEventEditingChanged];
}

- (void)loadData
{
    WeakSelf
    [YBHttpTool postDataDifference:@"didiPurchaseInfo" params:nil success:^(id  _Nullable obj) {
        if (obj!=nil) {
            DMStateModel *stateModel = [DMStateModel mj_objectWithKeyValues:obj[@"state"]];
            if (stateModel.status == ResultStatusSuccess) {
                weakSelf.balanceLabel.text = [NSString stringWithFormat:@"%@元",obj[@"usermoney"]];
                weakSelf.canuseMoney = [obj[@"usermoney"] floatValue];
//                weakSelf.balanceLabel.text = @"100000.0";
//                weakSelf.canuseMoney = 100000.0;
            }
        }
    } failure:^(NSError * _Nullable error) {
        
    }];
}
- (IBAction)agreeXieyiButtonClick:(id)sender {
    
    DMJSController  *jsVC = [DMJSController  new];
    jsVC.url = [NSString stringWithFormat:@"%@/wechat/showAgreementAPP.html",kAPI_URL];
    jsVC.title = @"鑫贝通宝点对点借款合同";
    [self.navigationController pushViewController:jsVC animated:YES];
    
}

- (void)hideKeyBoard
{
    [self.view endEditing:YES];
}

- (BOOL)canPost
{
    if (![DMMatch isMoney:self.moneyTF.text]) {[MBProgressHUD showSuccess:@"请检查输入金额"]; return NO;};
    if ([self.moneyTF.text floatValue] < 100) {[MBProgressHUD showSuccess:@"最小投资金额为100元"]; return NO;};
    if (self.agreeButton.selected == NO) {[MBProgressHUD showSuccess:@"请勾选服务协议"]; return NO;}
    return YES;
}

- (IBAction)sureButtonClick:(id)sender {
    
    if (![self canPost]) {
        return;
    }
    if ([self.moneyTF.text floatValue] > self.canuseMoney) {

        [self aletMessage];
        return;
    }
    DMInputPSWController *inputVC = [[DMInputPSWController alloc]initWithNibName:@"DMInputPSWController" bundle:[NSBundle mainBundle]];
    inputVC.payMoneyString = self.moneyTF.text;
    inputVC.modalPresentationStyle = UIModalPresentationOverCurrentContext;
    WeakSelf
    [inputVC setPassWordBlock:^(NSString *psw) {
        weakSelf.psw = psw;
        [weakSelf buyPost];
    }];
    [self.navigationController presentViewController:inputVC animated:YES completion:nil];
    
//    [self buyPost];
}
- (IBAction)allinButtonclick:(id)sender {
    self.moneyTF.text = [NSString stringWithFormat:@"%.2f",self.canuseMoney];
    CGFloat todayProfitMoney = [self.moneyTF.text floatValue] * (self.regModel.annualRate / (self.regModel.deadlineType ==1 ? 365:12)) * 0.01 * self.regModel.deadline;
    self.expectedEarningsLabel.text = [NSString stringWithFormat:@"%.2f元",todayProfitMoney];
}

- (IBAction)agreeButtonClick:(UIButton *)sender {
    sender.selected = !sender.selected;
}

#pragma mark - 选择优惠券
- (IBAction)selectCouponButtonclick:(id)sender {
    
    if (![DMMatch isMoney:self.moneyTF.text]) {
        [MBProgressHUD showSuccess:@"请输入正确的金额"];
        return;
    }
    DMMyCouponController *cpVC = [DMMyCouponController new];
    cpVC.deadlineType = [NSString stringWithFormat:@"%ld",(long)self.regModel.deadlineType];
    cpVC.deadlin = [NSString stringWithFormat:@"%ld",(long)self.regModel.deadline];
    cpVC.moneyAmout = self.moneyTF.text;
    WeakSelf
    [cpVC setSelsctCouponBlock:^(NSInteger coupID, NSInteger coupType, NSString *coupAmout) {
        weakSelf.couponid = coupID;
        weakSelf.coupontype = coupType;
        if (coupAmout.length == 0) {
            [weakSelf.selectCoupButton setTitle:@"暂无卡券" forState:UIControlStateNormal];
        }else{
            [weakSelf.selectCoupButton setTitle:[NSString stringWithFormat:@"%@元卡券",coupAmout] forState:UIControlStateNormal];
        }
    }];
    [self.navigationController pushViewController:cpVC animated:YES];
}

#pragma mark - 购买请求
- (void)buyPost
{
    
    NSMutableDictionary *params = [NSMutableDictionary dictionaryWithDictionary:@{@"tradingPassword":self.psw,
                                                                                  @"investAmount":self.moneyTF.text,
                                                                                  @"borrowId":self.regModel.id
                                                                                  }];
    if (self.couponid != 0 && self.coupontype != 0) {
        [params setValue:@(self.coupontype) forKey:@"coupontype"];
        [params setValue:@(self.couponid) forKey:@"couponId"];
    }
    WeakSelf
    [YBHttpTool postDataDifference:@"bfpay/investAjaxBorrow" params:params success:^(id  _Nullable obj) {
        if (obj!=nil) {
            DMLog(@"投资结果：%@",obj[@"info"]);
            DMStateModel *stateModel = [DMStateModel mj_objectWithKeyValues:obj[@"state"]];
            if (stateModel.status == ResultStatusSuccess) {
                [weakSelf.navigationController popViewControllerAnimated:YES];
            }
            [MBProgressHUD showSuccess:stateModel.info];
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

- (void)textFieldEditing:(UITextField *)tf
{
    if (![DMMatch isMoney:tf.text] && tf.text.length > 0) {
        [MBProgressHUD showSuccess:@"请检查输入金额"];
        return;
    }
    
//    if ([tf.text floatValue] <= self.canuseMoney && [tf.text floatValue] >= 100) {
//        [self.sureBrowButton setBackgroundColor:kColor(242, 177, 67)];
//        self.sureBrowButton.userInteractionEnabled = YES;
//    }else{
//        [self.sureBrowButton setBackgroundColor:[UIColor lightGrayColor]];
//        self.sureBrowButton.userInteractionEnabled = NO;
//    }
//    NSInteger type = 0;         // 区分月份和天数
//
//    if (self.regModel.deadlineType == 1) {
//        type = 365;
//        ;
//    }else if (self.regModel.deadlineType == 2){
//        type = 12;
//    }
    
    CGFloat todayProfitMoney = [self.moneyTF.text floatValue] * (self.regModel.annualRate / (self.regModel.deadlineType ==1 ? 365:12)) * 0.01 * self.regModel.deadline;
    self.expectedEarningsLabel.text = [NSString stringWithFormat:@"%.2f元",todayProfitMoney];
}

@end
