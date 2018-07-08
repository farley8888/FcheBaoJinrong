//
//  DMMyControllerCollection.m
//  CheBaoJinRong
//
//  Created by apple on 2018/6/25.
//  Copyright © 2018年 apple. All rights reserved.
//

#import "XBTMyControllerCollection.h"
#import "MyModel.h"
#import "MyHeadView.h"
#import "SecionFooterView.h"
#import "XBTMyControllerCollectionCell.h"
#import "XBTNavigationBar.h"

#import "LonginController.h"
#import "XBTNavigationController.h"
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
#import "XBTShareRecordController.h"         //邀请好友记录


@interface XBTMyControllerCollection ()<UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout>

@property (nonatomic,strong) NSMutableArray<NSDictionary*> *titleArr;
@property (nonatomic, strong) MyHeadView *headView;
@property (nonatomic, strong) UICollectionView *collectionView;
@property (nonatomic, strong) MyModel *dataModel;
@property (nonatomic, assign) BOOL canSee;

@end

@implementation XBTMyControllerCollection

- (void)dealloc
{
    DMLog(@"%s",__func__);
    [kNotificationCenter removeObserver:self];
}

- (NSMutableArray<NSDictionary *> *)titleArr
{
    if (_titleArr == nil) {
        
        NSArray *arr = @[
                         @{@"title":@"回款查询",@"img":@"huikuan_wode",@"subtitle":@"查看回款明细"},
                         @{@"title":@"交易记录",@"img":@"jiaoyi_wode",@"subtitle":@"查看交易明细"},
                         @{@"title":@"出借记录",@"img":@"touzi_wode",@"subtitle":@"查看出借明细"},
                         @{@"title":@"我的红包",@"img":@"hongbao_wode",@"subtitle":@"还剩0张"},
                         @{@"title":@"实名认证",@"img":@"shimingzhi",@"subtitle":@"让账户更安全"},
                         @{@"title":@"邀请好友",@"img":@"share",@"subtitle":@"返利加息"},
                         @{@"title":@"邀请记录",@"img":@"yqjl",@"subtitle":@"月月加薪"},
                         @{@"title":@"更多",@"img":@"more",@"subtitle":@"敬请期待"}];
        
        _titleArr = [NSMutableArray arrayWithArray:arr];
    }
    return _titleArr;
}

- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    [self.navigationController.navigationBar setTranslucent:YES];
}

- (void)viewDidLoad {
    [super viewDidLoad];
    [self setNavButton];
    [self setUI];
    [self setCollectionHeadView];
    [self loadData];
}

- (void)setUI
{
    UICollectionViewFlowLayout *flowLay = [[UICollectionViewFlowLayout alloc]init];
    flowLay.minimumLineSpacing = 1;
    flowLay.minimumInteritemSpacing = 1;
    flowLay.itemSize = CGSizeMake((kScreenW - 1)/2.0, 70);
    flowLay.headerReferenceSize = CGSizeMake(kScreenW, 200+SafeAreaTopHeight+90);
    flowLay.footerReferenceSize = CGSizeMake(kScreenW, 70);
    
    UICollectionView *collectionView = [[UICollectionView alloc]initWithFrame:CGRectMake(0, -SafeAreaTopHeight, kScreenW, kScreenH+20) collectionViewLayout:flowLay];
    collectionView.backgroundColor = [UIColor groupTableViewBackgroundColor];
    collectionView.showsVerticalScrollIndicator = NO;
    collectionView.alwaysBounceVertical = YES;
    collectionView.delegate = self;
    collectionView.dataSource = self;
    [collectionView registerNib:[UINib nibWithNibName:@"MyControllerCollectionCell" bundle:[NSBundle mainBundle]] forCellWithReuseIdentifier:@"MyControllerCollectionCell"];
    [collectionView registerNib:[UINib nibWithNibName:@"MyHeadView" bundle:[NSBundle mainBundle]] forSupplementaryViewOfKind:UICollectionElementKindSectionHeader withReuseIdentifier:@"MyHeadView"];
    [collectionView registerNib:[UINib nibWithNibName:@"SecionFooterView" bundle:[NSBundle mainBundle]] forSupplementaryViewOfKind:UICollectionElementKindSectionFooter withReuseIdentifier:@"SecionFooterView"];
    self.collectionView = collectionView;
    [self.view addSubview:collectionView];
}

- (void)setCollectionHeadView
{
    WeakSelf
    kSetupRefreshNormalCollectionViewHeader
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


- (void)loadData
{
    WeakSelf
    [YBHttpTool postDataDifference:@"selectUserIndex" params:nil success:^(id  _Nullable obj) {
        kLoadDataHeaderEndForCollection
        if (obj != nil) {
            
            MyModel *model = [MyModel mj_objectWithKeyValues:obj];
            if (model.state.status == ResultStatusSuccess) {
                
                weakSelf.headView.headModel = model;
                weakSelf.dataModel = model;
                [weakSelf.collectionView reloadData];
                
            }else{
                if ([model.state.info isEqualToString:@"未登录"]) {
                    [weakSelf loginViewPresend];
                }else{
                    [XBTProgressHUD showSuccess:model.state.info];
                }
            }
        }
    } failure:^(NSError * _Nullable error) {
        kLoadDataHeaderEndForCollection
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

#pragma mark -- UICollectionViewDelegate
- (NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView
{
    return 1;
}

- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section
{
    return self.titleArr.count;
}

- (__kindof UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath
{
    XBTMyControllerCollectionCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:@"MyControllerCollectionCell" forIndexPath:indexPath];
    cell.imgView.image = [UIImage imageNamed:self.titleArr[indexPath.row][@"img"]];
    cell.titleLabel.text = self.titleArr[indexPath.row][@"title"];
    cell.subTitleLabel.text = self.titleArr[indexPath.row][@"subtitle"];
    if (indexPath.row == 3) {
        cell.subTitleLabel.text = [NSString stringWithFormat:@"还剩%@张",self.dataModel.sumhb];
    }
    return cell;
}

- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath
{
    [collectionView deselectItemAtIndexPath:indexPath animated:YES];
    if ([UserManager sharedManager].user.token.length == 0) {
        [self loginViewPresend];
        return;
    }
    UIViewController *comVC = nil;
    if(indexPath.row == 0){
        ReturnMoneyController *returenVC = [ReturnMoneyController new];
        comVC = returenVC;
        
    }else if (indexPath.row == 1){
        TransactionRecordController *trVC = [TransactionRecordController new];
        comVC = trVC;
    }else if (indexPath.row == 2) {

        XBTInvestmentRecordsController *irVC = [XBTInvestmentRecordsController  new];
        comVC = irVC;
    }else if (indexPath.row == 3){
        
        MyHongBaoController *hbVC = [MyHongBaoController new];
        comVC = hbVC;
        
    }else if (indexPath.row == 4){

        SettingController *raVC = [SettingController new];
        comVC = raVC;
    }else if (indexPath.row == 5){
        ShareFriendController *shareVC = [ShareFriendController new];
        comVC = shareVC;
    }else if (indexPath.row == 6){
        XBTShareRecordController *srvc = [XBTShareRecordController new];
        comVC = srvc;
    }
    [self pushVC:comVC];
}

- (UICollectionReusableView *)collectionView:(UICollectionView *)collectionView viewForSupplementaryElementOfKind:(NSString *)kind atIndexPath:(NSIndexPath *)indexPath
{
    UICollectionReusableView *reusableview = nil;
    DMLog(@"kind = %@", kind);
    WeakSelf
    if (kind == UICollectionElementKindSectionHeader){
        
        MyHeadView *headerV = (MyHeadView *)[collectionView dequeueReusableSupplementaryViewOfKind:UICollectionElementKindSectionHeader withReuseIdentifier:@"MyHeadView" forIndexPath:indexPath];
        [headerV setWithdrawAndRechBlock:^(NSInteger num) {
            [weakSelf verificationIDAndBankCard:num];
        }];
        self.headView = headerV;
        reusableview = headerV;
    }else if (kind == UICollectionElementKindSectionFooter){
        SecionFooterView *footView = [collectionView dequeueReusableSupplementaryViewOfKind:UICollectionElementKindSectionFooter withReuseIdentifier:@"SecionFooterView" forIndexPath:indexPath];
        [footView setCallPhone:^{
            [weakSelf callPhoneCode:@"400-0651520"];
        }];
        reusableview = footView;
    }
    return reusableview;
}

- (UIEdgeInsets)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout insetForSectionAtIndex:(NSInteger)section
{
    return UIEdgeInsetsMake(2, 0, 1, 0);
}

@end