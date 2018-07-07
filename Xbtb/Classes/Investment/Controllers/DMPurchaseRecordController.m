//
//  DMPurchaseRecordController.m
//  CheBaoJinRong
//
//  Created by apple on 2018/5/28.
//  Copyright © 2018年 apple. All rights reserved.
//

#import "DMPurchaseRecordController.h"
#import "XBTPurchaseRecordCell.h"
#import "XBTPurchaseRecordModel.h"



@interface DMPurchaseRecordController ()<UITableViewDelegate, UITableViewDataSource>

@property (nonatomic, strong) NSMutableArray<XBTPurchaseRecordModel *> *dataArray;
@property (nonatomic, assign) NSInteger page;
@property (nonatomic, strong) UITableView *tableView;

@end

@implementation DMPurchaseRecordController

- (void)dealloc
{
    DMLog(@"%s",__func__);
}

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    [self setUI];

}

- (void)setUI
{
    UITableView *tableView = [[UITableView alloc]initWithFrame:CGRectMake(0, 0, kScreenW, kScreenH -60 - SafeAreaTopHeight - SafeAreaBottomHeight - 50) style:UITableViewStyleGrouped];
    self.tableView = tableView;
    tableView.delegate = self;
    tableView.dataSource = self;
    UITableView_RegisterFormNib(tableView, @"DMPurchaseRecordCell");
    UITableView_AutomaticDimension(tableView, 120);
    [self.view addSubview:tableView];
    [tableView loading:CGRectMake(0, 0, tableView.width, tableView.height)];
    WeakSelf
    kSetupRefreshNormalHeader
}

- (void)loadData
{
    NSDictionary *params = @{@"borrowId":self.prdID,
                             @"curPage":@1,
                             @"pageSize":kLimit,
                             @"result":@(self.result),
                             };
    WeakSelf
    [YBHttpTool postDataDifference:@"borrowInvestList" params:params success:^(id  _Nullable obj) {
        kLoadDataHeaderEnd
        if (obj!=nil) {
            DMStateModel *stateModel = [DMStateModel mj_objectWithKeyValues:obj[@"state"]];
            DMPageModel *pageModel = [DMPageModel mj_objectWithKeyValues:obj[@"page"]];
            if (stateModel.status == ResultStatusSuccess) {
                NSMutableArray *arr = [XBTPurchaseRecordModel mj_objectArrayWithKeyValuesArray:obj[@"data"]];
                weakSelf.dataArray = arr;
                kSetupMJ_footer_loadData(loadMoreData)
            }else if (stateModel.status == ResultStatusNoData){
                
                [weakSelf.tableView notData:weakSelf.tableView.frame];
            }
        }
    } failure:^(NSError * _Nullable error) {
        kLoadDataHeaderEnd
    }];
    self.isLoadData = YES;
}

- (void)loadMoreData
{
    NSDictionary *params = @{@"borrowId":self.prdID,
                             @"curPage":@(self.page),
                             @"pageSize":kLimit
                             };
    WeakSelf
    [YBHttpTool postDataDifference:@"borrowInvestList" params:params success:^(id  _Nullable obj) {
        kloadDataFooterEnd
        if (obj!=nil) {
            DMStateModel *stateModel = [DMStateModel mj_objectWithKeyValues:obj[@"state"]];
            DMPageModel *pageModel = [DMPageModel mj_objectWithKeyValues:obj[@"page"]];
            if (stateModel.status == ResultStatusSuccess) {
                NSMutableArray *arr = [XBTPurchaseRecordModel mj_objectArrayWithKeyValuesArray:obj[@"data"]];
                [weakSelf.dataArray addObjectsFromArray: arr];
                kSetupMJ_footer_loadMoreData
            }
        }
    } failure:^(NSError * _Nullable error) {
        kloadDataFooterEnd
    }];
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
    XBTPurchaseRecordCell *cell = [tableView dequeueReusableCellWithIdentifier:@"DMPurchaseRecordCell" forIndexPath:indexPath];
    cell.cellModel = self.dataArray[indexPath.row];
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    return cell;
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
