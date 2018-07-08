//
//  MyDidiBadyViewController.m
//  CheBaoJinRong
//
//  Created by apple on 2018/5/15.
//  Copyright © 2018年 apple. All rights reserved.
//

#import "MyDidiBadyViewController.h"
#import "MyHeadView.h"
#import "XBTMyDidiCell.h"
#import "XBTDetialCell.h"
#import "WithdrawCashController.h"
#import "DMNavigationBar.h"
#import "MyModel.h"
#import "XBTBuyDidiBaoController.h"
#import "XBTMyDidiRecordController.h"

@interface MyDidiBadyViewController ()<UITableViewDelegate,UITableViewDataSource>

@property (nonatomic, strong) UITableView *tableView;
@property (nonatomic, strong) MyHeadView *headView;
@property (nonatomic, assign) BOOL canSee;
@property (nonatomic, strong) NSArray<NSDictionary *> *dataArray;

@end

@implementation MyDidiBadyViewController

- (void)dealloc
{
    [kNotificationCenter removeObserver:self];
}

-(NSArray<NSDictionary *> *)dataArray
{
    if (_dataArray == nil) {
        _dataArray = @[@{@"title":@"计息规则",@"detial":@"1、存入当日即起息，次日结息\n2、次日结息后，利息发放到账户余额中"},
                       @{@"title":@"利息规则",@"detial":@"当天计息，次日结息，锁定期后可继续享有利息"},
                       @{@"title":@"赎回规则",@"detial":@"1、单笔赎回最低额度为0.01元，最大额度不超过对应滴滴宝额度\n2、工作日14：30前申请赎回当天16：00前回款至账户余额，工作日14：30后赎回的将在下一个工作日16：00前回款至账户余额\n3、如遇周末节假日，赎回到账时间顺延至下一工作日\n4、资金回款至账户余额后，您可选择在次购买理财产品"},
                        ];
    }
    return _dataArray;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    [self setNav];
    [self setUI];
    [self loadDta];
}

- (void)setNav
{
    self.navigationItem.title = @"我的滴滴宝";
    [self.navigationController.navigationBar setTranslucent:YES];
    [self dm_setStatusBarStyle:UIStatusBarStyleLightContent];
    [self dm_setNavBarBarTintColor:[UIColor clearColor]];
    [self dm_setNavBarShadowImageHidden:YES];
    [self dm_setNavBarTitleColor:[UIColor whiteColor]];
    [self dm_setNavBarTintColor:[UIColor whiteColor]];
    [self dm_setNavBarBackgroundAlpha:0];
    
    UIBarButtonItem *rightButton = [[UIBarButtonItem alloc]initWithTitle:@"记录" style:UIBarButtonItemStyleDone target:self action:@selector(rightButtonClick)];
    self.navigationItem.rightBarButtonItem = rightButton;
}

- (void)rightButtonClick
{
    XBTMyDidiRecordController *didiRecVC = [XBTMyDidiRecordController new];
    [self.navigationController pushViewController:didiRecVC animated:YES];
    
}

- (void)setUI
{
    BOOL myProfitVisual = [NSUserDefaults getBoolForKey:kMyDidiBaoVisual];
    self.canSee = myProfitVisual;
    MyHeadView *headView = [MyHeadView myHeadView];
    headView.isCanSee = myProfitVisual;
    headView.type = MyDiDiBaoHeadViewType;
    headView.frame = CGRectMake(0, 0, kScreenW, 280);
    headView.headImage.image = [UIImage imageNamed:@"bg_wodedidibao"];
    self.headView = headView;
    [self.view addSubview: headView];
    
    UITableView *tableView = [[UITableView alloc]initWithFrame:CGRectMake(0, CGRectGetMaxY(headView.frame), kScreenW, kScreenH - CGRectGetHeight(headView.frame) - SafeAreaBottomHeight) style:UITableViewStyleGrouped];
    self.tableView = tableView;
    tableView.delegate = self;
    tableView.dataSource = self;
    tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    UITableView_RegisterFormNib(tableView, @"XBTMyDidiCell");
    UITableView_RegisterFormNib(tableView, @"XBTDetialCell");
    UITableView_AutomaticDimension(tableView, 100);
    [self.view addSubview:tableView];

}

- (void)loadDta
{
    WeakSelf
    [YBHttpTool postDataDifference:@"userdidibao" params:nil success:^(id  _Nullable obj) {
        if (obj!= nil) {
            if ([obj[@"state"][@"status"] integerValue] == ResultStatusSuccess) {
                MyModel *model = [[MyModel alloc]init];

                model.total1 = [obj[@"zrsy"] floatValue];
                model.total2 = [obj[@"ljsy"] floatValue];
                model.total3 = [obj[@"gmze"] floatValue];
                weakSelf.headView.headModel = model;
            }
            
        }
    } failure:^(NSError * _Nullable error) {
//        13660627043
    }];
}

- (void)cellPushViewController:(NSInteger)tag
{
    if (tag == 0) {
        WithdrawCashController *wcVC = [WithdrawCashController new];
        wcVC.type = Redeem;
        [self.navigationController pushViewController:wcVC animated:YES];
    }else{
        XBTBuyDidiBaoController *buyVC = [XBTBuyDidiBaoController new];
        [self.navigationController pushViewController:buyVC animated:YES];
    }
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 2;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return  section == 0 ? 1:self.dataArray.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    WeakSelf
    UITableViewCell *cell = nil;
    if (indexPath.section == 0) {
        XBTMyDidiCell *cell1 = [tableView dequeueReusableCellWithIdentifier:@"XBTMyDidiCell" forIndexPath:indexPath];
        [cell1 setCellButtonClick:^(NSInteger tag) {
            [weakSelf cellPushViewController:tag];
        }];
        cell = cell1;
    }else{
        XBTDetialCell *cell2 = [tableView dequeueReusableCellWithIdentifier:@"XBTDetialCell" forIndexPath:indexPath];
        cell2.cellDict = self.dataArray[indexPath.row];
        cell = cell2;
    }
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    return cell;
}

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section
{
    return section == 0 ? CGFLOAT_MIN:kHeightForSection;
}

- (UIView *)tableView:(UITableView *)tableView viewForFooterInSection:(NSInteger)section
{
    return [UIView new];
}

- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section
{
    return [UIView new];
}

- (CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section
{
    return CGFLOAT_MIN;
}


@end
