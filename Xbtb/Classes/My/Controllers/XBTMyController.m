//
//  MyController.m
//  CheBaoJinRong
//
//  Created by ltyj on 2017/12/7.
//  Copyright © 2017年 ltyj. All rights reserved.
//

#import "XBTMyController.h"
#import "MyCell.h"
#import "MyHeadView.h"
#import "UIImage+DMIconFont.h"
#import "UIAlertView+Block.h"
#import "MyModel.h"
#import "SecionFooterView.h"
#import "DMNavigationBar.h"

#import "ReturnMoneyController.h"         //回款查询
#import "TransactionRecordController.h"   //交易记录
#import "XBTInvestmentRecordsController.h"   //出借记录
#import "MyDidiBadyViewController.h"      //我的滴滴宝
#import "SettingController.h"             //设置
#import "XBTRechargeController.h"            //充值
#import "WithdrawCashController.h"        //提现
#import "MyHongBaoController.h"           //我的红包
#import "XBTBankCardController.h"            //银行卡绑定
#import "RealNameAuthenticationVController.h"  //实名认证
#import "MessageController.h"             //消息
#import "ShareFriendController.h"         //分享好友
#import "LonginController.h"
#import "XBTNavigationController.h"


@interface XBTMyController ()<UITableViewDelegate,UITableViewDataSource>

@property (nonatomic,strong) NSMutableArray<NSDictionary*> *titleArr;
@property (nonatomic, strong) MyHeadView *headView;
@property (nonatomic, strong) UITableView *tableView;
@property (nonatomic, strong) MyModel *dataModel;
@property (nonatomic, assign) BOOL canSee;


@end

@implementation XBTMyController

- (void)dealloc
{
    DMLog(@"%s",__func__);
    [kNotificationCenter removeObserver:self];
}

- (NSMutableArray<NSDictionary *> *)titleArr
{
    if (_titleArr == nil) {

        NSArray *arr = @[ @{@"title":@"实名认证",@"img":@"shimingzhi"},
                          @{@"title":@"我的红包",@"img":@"hongbao_wode"},
                          @{@"title":@"回款查询",@"img":@"huikuan_wode"},
                          @{@"title":@"交易记录",@"img":@"jiaoyi_wode"},
                          @{@"title":@"出借记录",@"img":@"touzi_wode"},
                          @{@"title":@"邀请好友",@"img":@"share"}];
        _titleArr = [NSMutableArray arrayWithArray:arr];
    }
    return _titleArr;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    [self setNavButton];
    [self setUI];
    [self setTableViewHeadView];
    [self loadData];
    
}

- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    [self.navigationController.navigationBar setTranslucent:YES];
}

- (void)setUI
{
    UITableView *tableView = [[UITableView alloc]initWithFrame:CGRectMake(0, -SafeAreaTopHeight, kScreenW, kScreenH+20) style:UITableViewStyleGrouped];
    tableView.delegate = self;
    tableView.dataSource = self;
    self.tableView = tableView;
    UITableView_RegisterFormNib(tableView, @"MyCell");
//    UITableView_RegisterFormClass(tableView, @"UITableViewCell");
    UITableView_AutomaticDimension(tableView, 44);
    [self.view addSubview:tableView];
    WeakSelf
    kSetupRefreshNormalHeader
}

- (void)setNavButton
{
    
    [self dm_setStatusBarStyle:UIStatusBarStyleLightContent];
    [self dm_setNavBarBarTintColor:[UIColor clearColor]];
    [self dm_setNavBarShadowImageHidden:YES];
    [self dm_setNavBarTitleColor:[UIColor whiteColor]];
    [self dm_setNavBarTintColor:[UIColor whiteColor]];
    [self dm_setNavBarBackgroundAlpha:0];
    UIBarButtonItem *leftButton = [[UIBarButtonItem alloc]initWithImage:[UIImage imageNamed:@"shezhi_wode"] style:UIBarButtonItemStylePlain target:self action:@selector(leftButtonClick)];
    self.navigationItem.leftBarButtonItem = leftButton;
    
    UIBarButtonItem *rightButton = [[UIBarButtonItem alloc]initWithImage:[UIImage imageNamed:@"xiaoxi_wode"]  style:UIBarButtonItemStylePlain target:self action:@selector(rightButtonClick)];
    self.navigationItem.rightBarButtonItem = rightButton;
    [kNotificationCenter addObserver:self selector:@selector(loadData) name:kLoginSuccessNotification object:nil];
}

- (void)setTableViewHeadView
{
    BOOL myProfitVisual = [NSUserDefaults getBoolForKey:kMyProfitVisual];
    self.canSee = myProfitVisual;
    MyHeadView *headView = [MyHeadView myHeadView];
    headView.isCanSee = myProfitVisual;
    headView.frame = CGRectMake(0, 0, kScreenW, 200+SafeAreaTopHeight);
    self.headView = headView;
    WeakSelf
//    [headView setHeadHomeButtonClick:^(NSInteger btnTag) {
//
//        weakSelf.canSee = btnTag;
//
//        MyCell *cell1 = [weakSelf.tableView cellForRowAtIndexPath:[NSIndexPath indexPathForRow:0 inSection:0]];
//        NSString *amout = self.dataModel.usableAmount == nil?@"0.0":self.dataModel.usableAmount;
//        amout = btnTag ? @"＊＊＊":amout;
//        cell1.canUseLabel.text = amout;
//
//    }];
    self.tableView.tableHeaderView = headView;
}

- (void)loadData
{
    WeakSelf
    [YBHttpTool postDataDifference:@"selectUserIndex" params:nil success:^(id  _Nullable obj) {
        kLoadDataHeaderEnd
        if (obj != nil) {
            
            MyModel *model = [MyModel mj_objectWithKeyValues:obj];
            if (model.state.status == ResultStatusSuccess) {
                
                weakSelf.headView.headModel = model;
                weakSelf.dataModel = model;
                [weakSelf.tableView reloadData];
                
            }else{
                if ([model.state.info isEqualToString:@"未登录"]) {
                    [weakSelf loginViewPresend];
                }else{
                    [XBTProgressHUD showSuccess:model.state.info];
                }
            }
        }
    } failure:^(NSError * _Nullable error) {
        kLoadDataHeaderEnd
    }];
}

#pragma mark - 事件
- (void)loginViewPresend
{
    XBTNavigationController *nav = [[XBTNavigationController alloc] initWithRootViewController:[[LonginController alloc] init]];
    [self.navigationController presentViewController:nav animated:YES completion:nil];
}

- (void)leftButtonClick
{
    if ([UserManager sharedManager].user.token == 0) {
        [self loginViewPresend];
        return;
    }
    SettingController *stVC = [SettingController new];
    [self.navigationController pushViewController:stVC animated:YES];
}

- (void)rightButtonClick
{
    MessageController *msVC = [MessageController new];
    [self.navigationController pushViewController:msVC animated:YES];
}

- (void)verificationIDAndBankCard:(NSInteger)tag
{
    UserManager *manger = [UserManager sharedManager];
    NSString *singString = @"";
    NSString *goString = @"";
    if (manger.user.realName.length == 0) {
        singString = @"您还未实名认证";
        goString = @"去实名";
    }else if(manger.user.bankCardNo.length == 0){
        singString = @"您还未绑定银行卡";
        goString = @"去绑卡";
    }
    if ([UserManager sharedManager].user.token == 0) {
        [self loginViewPresend];
        return;
    }
    if (singString.length != 0) {
        [self alertMessage:singString goString:goString];
    }else{
        if (tag == 1) {
            XBTRechargeController *reVC = [XBTRechargeController  new]; //充值
            [self pushVC:reVC];
        }else{
            WithdrawCashController *wcVC = [WithdrawCashController new];  //提现
            [self pushVC:wcVC];
        }
    }
}

- (void)alertMessage:(NSString *)singString goString:(NSString *)goString
{
    WeakSelf
    UIAlertView *alertview = [UIAlertView alertWithTitle:@"温馨提示" message:singString buttonIndex:^(NSInteger index) {
        if (index == 1) {
            if ([goString isEqualToString:@"去绑卡"]) {
                XBTBankCardController *bcVC = [XBTBankCardController new];
                [weakSelf pushVC:bcVC];
            }else{
                RealNameAuthenticationVController *raVC = [RealNameAuthenticationVController new];
                [weakSelf pushVC:raVC];
            }
        }
    } cancelButtonTitle:@"取消" otherButtonTitles:goString];
    [alertview  show];
}

- (void)callPhoneCode:(NSString *)phone
{
    DMLog(@"%@",phone);
    
    dispatch_async(dispatch_get_main_queue(), ^{
//        [[UIAlertView alertWithTitle:nil message:[NSString stringWithFormat:@"是否拨打电话%@", phone] buttonIndex:^(NSInteger index) {
//            if (index == 1) {
                [[UIApplication sharedApplication] openURL:[NSURL URLWithString:[NSString stringWithFormat:@"tel:%@", phone]]];
//            }
//        } cancelButtonTitle:@"取消" otherButtonTitles:@"确定"] show];
    });
}

- (void)pushVC:(UIViewController *)vc
{
    [self.navigationController pushViewController:vc animated:YES];
}

#pragma mark - UITableViewDelegate
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 2;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    if (section == 0) {
        return 1;
    }else{
        return self.titleArr.count;
    }
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (indexPath.section == 0) {
        WeakSelf
        MyCell *cell = [tableView dequeueReusableCellWithIdentifier:@"MyCell" forIndexPath:indexPath];
        
        NSString *amout = self.dataModel.usableAmount == nil?@"0.0":self.dataModel.usableAmount;
        amout = self.canSee ? @"＊＊＊＊":amout;
        cell.canUseLabel.text = amout;
        [cell setButtonClickBlock:^(NSInteger tag) {
            [weakSelf verificationIDAndBankCard:tag];
        }];
        return cell;
    }else{
        
        static NSString *cellSing = @"UITableViewCell";
        UITableViewCell *cell =[tableView dequeueReusableCellWithIdentifier:cellSing];
        if (cell == nil) {
            cell = [[UITableViewCell alloc]initWithStyle:UITableViewCellStyleSubtitle reuseIdentifier:cellSing];
        }
        cell.textLabel.text = self.titleArr[indexPath.row][@"title"];
        cell.textLabel.font =[UIFont systemFontOfSize:14.0f];
        cell.imageView.image = [UIImage imageNamed:self.titleArr[indexPath.row][@"img"]];
        return cell;
    }
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    if ([UserManager sharedManager].user.token.length == 0) {
        [self loginViewPresend];
        return;
    }
    if (indexPath.section == 0) {
        return;
    }
    UIViewController *comVC = nil;
    if(indexPath.row == 0){
        SettingController *raVC = [SettingController new];
        comVC = raVC;

    }else if (indexPath.row == 1){
        MyHongBaoController *hbVC = [MyHongBaoController new];
        comVC = hbVC;
    }else if (indexPath.row == 2) {
        ReturnMoneyController *returenVC = [ReturnMoneyController new];
        comVC = returenVC;
    }else if (indexPath.row == 3){
       
        TransactionRecordController *trVC = [TransactionRecordController new];
        comVC = trVC;
        
    }else if (indexPath.row == 4){
        XBTInvestmentRecordsController *irVC = [XBTInvestmentRecordsController  new];
        comVC = irVC;
    }else if (indexPath.row == 5){
        ShareFriendController *shareVC = [ShareFriendController new];
        comVC = shareVC;
    }
    [self pushVC:comVC];
}

- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section
{
    return [UIView new];
}

- (UIView *) tableView:(UITableView *)tableView viewForFooterInSection:(NSInteger)section
{
    if (section == 1) {
        SecionFooterView *sectionView = [SecionFooterView sectionFooterView];
        WeakSelf
        [sectionView setCallPhone:^{
            [weakSelf callPhoneCode:@"400-0651520"];
        }];
        return sectionView;
    }else{
        return [UIView new];
    }
}

- (CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section
{
    if (section == 1) {
        return 70;
    }
    return CGFLOAT_MIN;
}

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section
{
    if (section == 0) {
        return CGFLOAT_MIN;
    }
    return kHeightForSection;
}

@end
