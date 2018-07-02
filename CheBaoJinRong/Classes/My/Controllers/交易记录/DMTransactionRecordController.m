//
//  DMTransactionRecordController.m
//  CheBaoJinRong
//
//  Created by apple on 2018/5/15.
//  Copyright © 2018年 apple. All rights reserved.
//

#import "DMTransactionRecordController.h"
#import "DMSubstitutePaymentCell.h"
#import "DMTransactionRecordModel.h"
#import "DMScreenRecordController.h"

@interface DMTransactionRecordController ()<UITableViewDelegate, UITableViewDataSource>

@property (nonatomic, strong) NSMutableArray<DMTransactionRecordModel *> *dataArray;
@property (nonatomic, copy)NSString *type;
@property (nonatomic, assign) NSInteger page;
@property (nonatomic, strong) UITableView *tableView;

@end

@implementation DMTransactionRecordController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self setUI];
    [self loadData];
}

- (void)setUI
{
    self.type = @"0";
    self.navigationItem.title = @"交易记录";
    self.navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc]initWithTitle:@"筛选" style:UIBarButtonItemStylePlain target:self action:@selector(rightBarButtonClick)];
    UITableView *tableView = [[UITableView alloc]initWithFrame:CGRectMake(0, 0, kScreenW, kScreenH) style:UITableViewStyleGrouped];
    self.tableView = tableView;
    tableView.delegate = self;
    tableView.dataSource = self;
    UITableView_RegisterFormNib(tableView, @"DMSubstitutePaymentCell");
    UITableView_AutomaticDimension(tableView, 80);
    [self.view addSubview:tableView];
    [self.view loading:CGRectMake(0, 0, self.view.width, self.view.height)];
    WeakSelf
    kSetupRefreshNormalHeader
}

- (void)loadData
{
    NSDictionary *params = @{@"fundType":self.type,
                             @"curPage":@1
                             };
    WeakSelf
    [YBHttpTool postDataDifference:@"moneyFlow" params:params success:^(id  _Nullable obj) {
        kLoadDataHeaderEnd
        if (obj!=nil) {
            DMPageModel *pageModel = [DMPageModel mj_objectWithKeyValues:obj[@"page"]];
            DMStateModel *stateModel = [DMStateModel mj_objectWithKeyValues:obj[@"state"]];
            if (stateModel.status == ResultStatusSuccess) {
                
                NSMutableArray *arr = [DMTransactionRecordModel mj_objectArrayWithKeyValuesArray:obj[@"data"]];
                weakSelf.dataArray = arr;
                kSetupMJ_footer_loadData(loadMoreData);
                
            }else if(stateModel.status == ResultStatusNoData){
                [weakSelf.dataArray removeAllObjects];
                [weakSelf.tableView reloadData];
                [weakSelf.tableView notData:CGRectMake(0, 0, kScreenW, kScreenH - SafeAreaTopHeight)];
                
            }else{
               [MBProgressHUD showSuccess:stateModel.info];
            }

        }
    } failure:^(NSError * _Nullable error) {
        kLoadDataHeaderEnd
    }];
}

- (void)loadMoreData
{
    NSDictionary *params = @{@"fundType":self.type,
                             @"curPage":@(self.page)
                             };
    WeakSelf
    [YBHttpTool postDataDifference:@"moneyFlow" params:params success:^(id  _Nullable obj) {
        kloadDataFooterEnd
        if (obj!=nil) {
            DMPageModel *pageModel = [DMPageModel mj_objectWithKeyValues:obj[@"page"]];
            DMStateModel *stateModel = [DMStateModel mj_objectWithKeyValues:obj[@"state"]];
            if (stateModel.status == ResultStatusSuccess) {
                
                NSMutableArray *arr = [DMTransactionRecordModel mj_objectArrayWithKeyValuesArray:obj[@"data"]];
                [weakSelf.dataArray addObjectsFromArray:arr];
                kSetupMJ_footer_loadMoreData;
            }else if(stateModel.status == ResultStatusNoData){
                [weakSelf.tableView notData:CGRectMake(0, 0, kScreenW, kScreenH - SafeAreaTopHeight)];
                
            }else{
                [MBProgressHUD showSuccess:stateModel.info];
            }
        }
    } failure:^(NSError * _Nullable error) {
        kloadDataFooterEnd
    }];
}

- (void)rightBarButtonClick
{
    DMScreenRecordController *srVC = [DMScreenRecordController new];
    srVC.type = 1;
    WeakSelf
    [srVC setSelectBlock:^(NSString *type) {
        weakSelf.type = type;
        [weakSelf loadData];
    }];
    srVC.modalPresentationStyle = UIModalPresentationOverCurrentContext;
    [self.navigationController presentViewController:srVC animated:YES completion:nil];
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return self.dataArray.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    DMSubstitutePaymentCell *cell = [tableView dequeueReusableCellWithIdentifier:@"DMSubstitutePaymentCell" forIndexPath:indexPath];
    cell.cellTransaModel = self.dataArray[indexPath.row];
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
}

- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section
{
    return [UIView new];
}

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section
{
    return CGFLOAT_MIN;
}

- (UIView *)tableView:(UITableView *)tableView viewForFooterInSection:(NSInteger)section
{
    return [UIView new];
}

- (CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section
{
    return CGFLOAT_MIN;
}

@end
