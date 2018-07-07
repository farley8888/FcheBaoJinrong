//
//  DMDidiDetialController.m
//  CheBaoJinRong
//
//  Created by apple on 2018/5/22.
//  Copyright © 2018年 apple. All rights reserved.
//

#import "DMDidiDetialController.h"
#import "XBTDidiDetialCell.h"
#import "XBTDetialCell.h"
#import "XBTBuyDidiBaoController.h"
#import "XBTDidiDetialHeadView.h"
#import "XBTNavigationController.h"
#import "LonginController.h"

@interface DMDidiDetialController ()<UITableViewDelegate, UITableViewDataSource>

@property (nonatomic, strong) NSArray *dataArray;
@property (nonatomic, strong) UITableView *tableView;

@end

@implementation DMDidiDetialController

- (NSArray *)dataArray
{
    if (_dataArray == nil) {
        _dataArray = @[@{@"title":@"产品特点",@"detial":@"锁定期后随时赎回、随时加入，当日计息、抵押物足额抵押借款信息"},
                       @{@"title":@"计息规则",@"detial":@"1、存入当日起息，次日结息\n2、次日结息后，利息发放到账户余额中"},
                       @{@"title":@"利息规则",@"detial":@"当天计息，次日结息，锁定期后可继续享受利息"},
                       @{@"title":@"赎回规则",@"detial":@"1.单笔赎回最低额度为0.01元，最大额度不超过对应滴滴宝额度\n2、工作日14：30前申请赎回当天16：00前回款至账户余额，工作日14：30后赎回的将在下一个工作日16：00前回款至账户余额\n3、如遇周末节假日，赎回到账时间顺延至下一工作日"},
                       @{@"title":@"产品介绍",@"detial":@"产品名称：滴滴宝\n起投金额：100元\n基础利率：7.8%"}];
    }
    return _dataArray;
}

- (void)dealloc
{
    DMLog(@"%s",__func__);
}

- (void)viewDidLoad {
    [super viewDidLoad];
    [self setupUI];
}

- (void)setupUI
{
    self.navigationItem.title = @"滴滴宝";
    UITableView *tableView = [[UITableView alloc]initWithFrame:CGRectMake(0, 0, kScreenW, kScreenH- SafeAreaTopHeight - 50 - SafeAreaBottomHeight) style:UITableViewStyleGrouped];
    tableView.delegate = self;
    tableView.dataSource = self;
    UITableView_RegisterFormNib(tableView, @"DMDidiDetialCell");
    UITableView_RegisterFormNib(tableView, @"DMDetialCell");
    UITableView_AutomaticDimension(tableView, 100);
    tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
//    self.view.backgroundColor = [UIColor redColor];
    self.tableView = tableView;
    [self.view addSubview:tableView];
    
    UIButton *button = [UIButton buttonWithType:UIButtonTypeCustom];
    button.frame = CGRectMake(0, CGRectGetMaxY(tableView.frame), kScreenW, 50);
    [button addTarget:self action:@selector(buttonClick) forControlEvents:UIControlEventTouchUpInside];
    [button setTitle:@"立即存入" forState:UIControlStateNormal];
    [button setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    [button setBackgroundColor:kColor(242, 177, 67)];
    [self.view addSubview:button];
    
    XBTDidiDetialHeadView *headView = [XBTDidiDetialHeadView headView];
    headView.frame = CGRectMake(0, 0, kScreenW, 290);
    self.tableView.tableHeaderView = headView ;
    [kNotificationCenter addObserver:self selector:@selector(pushBuyDidiBaoVC) name:kLoginSuccessNotification object:nil];
}

- (void)buttonClick
{
    if ([UserManager sharedManager].user.token.length) {
        [self pushBuyDidiBaoVC];
    }else{
        XBTNavigationController *nav = [[XBTNavigationController alloc] initWithRootViewController:[[LonginController alloc] init]];
        [self.navigationController presentViewController:nav animated:YES completion:nil];
    }
}

- (void)pushBuyDidiBaoVC
{
    XBTBuyDidiBaoController *buyVC = [XBTBuyDidiBaoController new];
    [self.navigationController pushViewController:buyVC animated:YES];
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return 5;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (indexPath.row == 0) {
        XBTDidiDetialCell *cell = [tableView dequeueReusableCellWithIdentifier:@"DMDidiDetialCell" forIndexPath:indexPath];
        cell.titelLabel.text = self.dataArray[indexPath.row][@"title"];
        cell.detialLabel.text = self.dataArray[indexPath.row][@"detial"];
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
        return cell;
    }else{
        XBTDetialCell *detialCell = [tableView dequeueReusableCellWithIdentifier:@"DMDetialCell" forIndexPath:indexPath];
        detialCell.detialBKView.backgroundColor = kColor(254, 251, 247);
        detialCell.cellDict = self.dataArray[indexPath.row];
        detialCell.selectionStyle = UITableViewCellSelectionStyleNone;
        return detialCell;
    }
}
- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section
{
    return [UIView new];
}

- (UIView *)tableView:(UITableView *)tableView viewForFooterInSection:(NSInteger)section
{
    return [UIView new];
}

- (CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section
{
    return CGFLOAT_MIN;
}

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section
{
    return CGFLOAT_MIN;
}

@end
