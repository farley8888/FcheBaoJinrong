//
//  DMSubstitutePaymentView.m
//  CheBaoJinRong
//
//  Created by apple on 2018/5/15.
//  Copyright © 2018年 apple. All rights reserved.
//

#import "XBTSubstitutePaymentView.h"
#import "XBTSubstitutePaymentCell.h"
#import "XBTReturnMoneyModel.h"

@interface XBTSubstitutePaymentView()<UITableViewDelegate,UITableViewDataSource>

@property (nonatomic, strong) NSMutableArray<XBTReturnMoneyModel *> *dataArray;
@property (nonatomic, strong) UITableView *tableView;
@property (nonatomic, assign) NSInteger page;

@end

@implementation XBTSubstitutePaymentView

- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        [self setTableView];
    }
    return self;
}


- (void)setTableView
{
    UITableView *tableView = [[UITableView alloc]initWithFrame:CGRectMake(0, 0, self.width, self.height) style:UITableViewStyleGrouped];
    tableView.delegate = self;
    tableView.dataSource = self;
    UITableView_RegisterFormNib(tableView, @"DMSubstitutePaymentCell");
    UITableView_AutomaticDimension(tableView, 100);
    self.tableView = tableView;
    [self addSubview:tableView];
    [self loading:CGRectMake(0, 0, self.width, self.height)];
    WeakSelf
    kSetupRefreshNormalHeader
}

- (void)loadData
{
    NSDictionary *params = @{@"curPage":@1,
                             @"repayStatus":@(self.type)
                             };
    
    WeakSelf
    [YBHttpTool postDataDifference:@"userreturnrecord" params:params success:^(id  _Nullable obj) {
        [weakSelf stop];
        [weakSelf.tableView stop];
        [weakSelf.tableView.mj_header endRefreshing];
        if (obj!=nil) {
            DMStateModel *model = [DMStateModel mj_objectWithKeyValues:obj[@"state"]];
            DMPageModel *pageModel = [DMPageModel mj_objectWithKeyValues:obj[@"page"]];
            if (model.status == ResultStatusSuccess) {
                NSMutableArray *arr = [XBTReturnMoneyModel mj_objectArrayWithKeyValuesArray:obj[@"data"]];
                weakSelf.dataArray = arr;
                kSetupMJ_footer_loadData(loadMoreData)
                if (weakSelf.type == 1) { //待收款时不发送通知
                    [kNotificationCenter postNotificationName:kSetRetuBackTopView object:nil userInfo:@{@"zds":obj[@"zds"],@"dyds":obj[@"dyds"]}];
                }
                
            }else if (model.status == 1){
                [weakSelf.tableView notData:weakSelf.tableView.frame];
            }
        }
    } failure:^(NSError * _Nullable error) {
        [weakSelf.tableView stop];
        [weakSelf.tableView.mj_header endRefreshing];
    }];
    self.isLoadData = YES;
}

- (void)loadMoreData
{
    NSDictionary *params = @{@"curPage":@(self.page),
                             @"repayStatus":@(self.type)
                             };
    WeakSelf
    [YBHttpTool postDataDifference:@"userreturnrecord" params:params success:^(id  _Nullable obj) {
        [weakSelf.tableView stop];
        [weakSelf.tableView.mj_header endRefreshing];
        if (obj!=nil) {
            DMStateModel *model = [DMStateModel mj_objectWithKeyValues:obj[@"state"]];
            DMPageModel *pageModel = [DMPageModel mj_objectWithKeyValues:obj[@"page"]];
            if (model.status == ResultStatusSuccess) {
                NSMutableArray *arr = [XBTReturnMoneyModel mj_objectArrayWithKeyValuesArray:obj[@"data"]];
                [weakSelf.dataArray addObjectsFromArray: arr];
                kSetupMJ_footer_loadMoreData
            }else if (model.status == 1){
                [weakSelf.tableView notData:weakSelf.tableView.frame];
            }
        }
    } failure:^(NSError * _Nullable error) {
        [weakSelf.tableView stop];
        [weakSelf.tableView.mj_header endRefreshing];
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
    XBTSubstitutePaymentCell *cell = [tableView dequeueReusableCellWithIdentifier:@"DMSubstitutePaymentCell" forIndexPath:indexPath];
    if (self.type == 1) {
        cell.type = SubstitutePaymentCell;
    }else{
        cell.type = ReceivablesCell;
    }
    
    cell.cellReturnModel = self.dataArray[indexPath.row];
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
