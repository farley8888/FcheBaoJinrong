//
//  DMInvestmentController.m
//  CheBaoJinRong
//
//  Created by apple on 2018/5/14.
//  Copyright © 2018年 apple. All rights reserved.
//

#import "XBTInvestmentController.h"
#import "XBTInvestmentCell.h"
#import "XBTHomePageCell.h"
#import "InvestmentModel.h"
#import "XBTSellOutController.h"
#import "XBTDidiDetialController.h"
#import "RegularController.h"
#import "XBTNavigationController.h"
#import "LonginController.h"
#import "WKWebViewController.h"

@interface XBTInvestmentController ()<UITableViewDelegate, UITableViewDataSource>

@property (nonatomic, assign) NSInteger page;
@property (nonatomic, strong) NSMutableArray<Data1 *> *dataArray;
@property (nonatomic, strong) InvestmentModel *dataModel;

@end

@implementation XBTInvestmentController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    DMLog(@"---%.2f",kScreenW);
    [self setUI];
    [self setRightBarButtonItem];
    [self loadData];
}

- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    if (self.isHongbaoJoin) {
        DMLog(@"子控制器数量：%ld",self.navigationController.childViewControllers.count);
        if (self.navigationController.childViewControllers.count == 2) {
            [self.navigationController.navigationBar setTranslucent:NO];
        }else{
            [self.navigationController.navigationBar setTranslucent:YES];
        }
    }
}

- (void)viewWillDisappear:(BOOL)animated
{
    [super viewWillDisappear:animated];
    if (self.isHongbaoJoin) {
        DMLog(@"子控制器数量：%ld",self.navigationController.childViewControllers.count);
        if (self.navigationController.childViewControllers.count >= 2) {
            [self.navigationController.navigationBar setTranslucent:NO];
        }else{
            [self.navigationController.navigationBar setTranslucent:YES];
        }
    }
}

- (void)setUI
{
    self.navigationItem.title = @"出借";
//    self.view.backgroundColor = [UIColor whiteColor];
    self.tableView.backgroundColor = [UIColor groupTableViewBackgroundColor];
    self.tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    UITableView_RegisterFormNib(self.tableView, @"XBTInvestmentCell");
//    UITableView_RegisterFormNib(self.tableView, @"XBTHomePageCell");
    WeakSelf
    kSetupRefreshNormalHeader;
}

- (void)loadData
{
    NSDictionary *params = @{@"curPage":@1,
                             @"pageSize":kLimit
                             };
    WeakSelf
    [YBHttpTool postDataDifference:@"selectNoviceBorrowList" params:params success:^(id  _Nullable obj) {
        kLoadDataHeaderEnd
        if (obj != nil) {
            InvestmentModel *model = [InvestmentModel mj_objectWithKeyValues:obj];
            XBTPageModel *pageModel = model.page;
            if (model.state.status == ResultStatusSuccess) {
                weakSelf.dataModel = model;
                weakSelf.dataArray = model.data;
                kSetupMJ_footer_loadData(loadMoreData);
            }else{
                if (![model.state.info isEqualToString:@"数据为空"]) {
                    [XBTProgressHUD showSuccess:model.state.info];
                }
            }
        }
    } failure:^(NSError * _Nullable error) {
        kLoadDataHeaderEnd
    }];
}

- (void)loadMoreData
{
    NSDictionary *params = @{@"curPage":@(self.page),
                             @"pageSize":kLimit
                             };
    WeakSelf
    [YBHttpTool postDataDifference:@"selectNoviceBorrowList" params:params success:^(id  _Nullable obj) {
        kLoadDataHeaderEnd
        if (obj != nil) {
            InvestmentModel *model = [InvestmentModel mj_objectWithKeyValues:obj];
            XBTPageModel *pageModel = model.page;
            if (model.state.status == ResultStatusSuccess) {
                weakSelf.dataModel = model;
                [weakSelf.dataArray addObjectsFromArray: model.data];
                kSetupMJ_footer_loadMoreData
            }else{
                if (![model.state.info isEqualToString:@"数据为空"]) {
                    [XBTProgressHUD showSuccess:model.state.info];
                }
            }
        }
    } failure:^(NSError * _Nullable error) {
        kLoadDataHeaderEnd
    }];
}

- (void)setRightBarButtonItem
{
    UIBarButtonItem *barItem = [[UIBarButtonItem alloc]initWithTitle:@"售罄" style:UIBarButtonItemStylePlain target:self action:@selector(rightBarButtonClick)];
    self.navigationItem.rightBarButtonItem = barItem;
}

- (void)rightBarButtonClick
{
    XBTSellOutController *soVC = [XBTSellOutController new];
    [self.navigationController pushViewController:soVC animated:YES];
//    WKWebViewController *wkVC = [WKWebViewController new];
//    wkVC.webViewH = kScreenH - 20;
//    wkVC.url = [NSString stringWithFormat:@"&Cookie=%@",[UserManager sharedManager].user.token];
//    [self.navigationController pushViewController:wkVC animated:YES];
}


- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return self.dataArray.count;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return 1;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
//    UITableViewCell *cell = nil;
//    if (indexPath.section == 0) {
//        XBTHomePageCell *cell1 = [tableView dequeueReusableCellWithIdentifier:@"XBTHomePageCell" forIndexPath:indexPath];
////        cell1.interestRateLabel.text = [NSString stringWithFormat:@"%.1f%%+2%%",(self.dataModel.borrowhqll - 2.0)];
//        cell1.interestRateLabel.text = [NSString stringWithFormat:@"7.8%%+2%%"];
//        cell = cell1;
//    }else{
        XBTInvestmentCell *cell2 = [tableView dequeueReusableCellWithIdentifier:@"XBTInvestmentCell" forIndexPath:indexPath];
        cell2.cellData = self.dataArray[indexPath.section];
//        cell = cell2;
//    }
    cell2.selectionStyle = UITableViewCellSelectionStyleNone;
    return cell2;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    [tableView deselectRowAtIndexPath:indexPath animated:NO];
//    if (indexPath.section == 0) {
//        XBTDidiDetialController *didiVC = [XBTDidiDetialController new];
//        [self.navigationController pushViewController:didiVC animated:YES];
//    }else{
//        if ([UserManager sharedManager].user.token.length) {
            RegularController *regVC = [RegularController new];
            regVC.titleString = self.dataArray[indexPath.section].borrowTitle;
            regVC.prdID = self.dataArray[indexPath.section].id;
            [self.navigationController pushViewController:regVC animated:YES];
//        }else{
//            DMNavigationController *nav = [[DMNavigationController alloc] initWithRootViewController:[[LonginController alloc] init]];
//            [self.navigationController presentViewController:nav animated:YES completion:nil];
//        }
//    }
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
//    if (indexPath.section == 0) {
//        CGFloat score = 400.0/230;
//        return kScreenW/score;
//    }
    CGFloat scare = 525.0/290;
    return kScreenW/scare;
}

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section
{
    return kHeightForSection;
}

- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section
{
    UIView *view = [UIView new];
    view.backgroundColor = [UIColor groupTableViewBackgroundColor];
    return view;
}


@end
