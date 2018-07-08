//
//  RecordChildController.m
//  CheBaoJinRong
//
//  Created by apple on 2018/6/1.
//  Copyright © 2018年 apple. All rights reserved.
//

#import "RecordChildController.h"
#import "XBTRecordChildCell.h"
#import "XBTRecordChildModel.h"

@interface RecordChildController ()<UITableViewDelegate, UITableViewDataSource>

@property (nonatomic, strong) UITableView *tableView;
@property (nonatomic, strong) NSMutableArray *dataArray;
@property (nonatomic, assign) NSInteger page;
@property (nonatomic, copy) NSString *url;

@end

@implementation RecordChildController

- (void)viewDidLoad {
    [super viewDidLoad];

    [self setUI];
}

- (void)setUI
{
    if (self.type == 1) {
        self.url = @"appInvestHqRecord";
    }else{
        self.url = @"appRedemptionRecord";
    }
    UITableView *tableView = [[UITableView alloc]initWithFrame:CGRectMake(0, 0, kScreenW, kScreenH -60 - SafeAreaTopHeight - SafeAreaBottomHeight) style:UITableViewStyleGrouped];
    self.tableView = tableView;
    tableView.delegate = self;
    tableView.dataSource = self;
    UITableView_RegisterFormNib(tableView, @"XBTRecordChildCell");
    UITableView_AutomaticDimension(tableView, 120);
    [self.view addSubview:tableView];
    [self.view loading:CGRectMake(0, 0, self.view.width, self.view.height)];
    WeakSelf
    kSetupRefreshNormalHeader
}

- (void)loadData
{
    WeakSelf
    [YBHttpTool postDataDifference:self.url params:nil success:^(id  _Nullable obj) {
        kLoadDataHeaderEnd
        if (obj!=nil) {
            XBTStateModel *stateModel = [XBTStateModel mj_objectWithKeyValues:obj[@"state"]];
            XBTPageModel *pageModel = [XBTPageModel mj_objectWithKeyValues:obj[@"page"]];
            if (stateModel.status == ResultStatusSuccess) {
                NSMutableArray *arr = [XBTRecordChildModel mj_objectArrayWithKeyValuesArray:obj[@"data"]];
                weakSelf.dataArray = arr;
                kSetupMJ_footer_loadData(loadMoreData)
            }else if (stateModel.status == ResultStatusNoData){

                [weakSelf.tableView notData:self.tableView.frame];
            }
        }
    } failure:^(NSError * _Nullable error) {
        kLoadDataHeaderEnd
    }];
    self.isLoadData = YES;
}

- (void)loadMoreData
{
    WeakSelf
    [YBHttpTool postDataDifference:self.url params:nil success:^(id  _Nullable obj) {
        kloadDataFooterEnd
        if (obj!=nil) {
            XBTStateModel *stateModel = [XBTStateModel mj_objectWithKeyValues:obj[@"state"]];
            XBTPageModel *pageModel = [XBTPageModel mj_objectWithKeyValues:obj[@"page"]];
            if (stateModel.status == ResultStatusSuccess) {
                NSMutableArray *arr = [XBTRecordChildModel mj_objectArrayWithKeyValuesArray:obj[@"data"]];
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
    XBTRecordChildCell *cell = [tableView dequeueReusableCellWithIdentifier:@"XBTRecordChildCell" forIndexPath:indexPath];
    cell.type = self.type;
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
