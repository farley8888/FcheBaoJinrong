//
//  DMLotOfViewTableView.m
//  CheBaoJinRong
//
//  Created by apple on 2018/5/16.
//  Copyright © 2018年 apple. All rights reserved.
//

#import "DMLotOfViewTableView.h"
#import "DMLotOfViewTableViewCell.h"
#import "XBTMyHongBaoModel.h"

@interface DMLotOfViewTableView ()<UITableViewDelegate,UITableViewDataSource>
@property (nonatomic, strong) UITableView *tableView;
@property (nonatomic, strong) NSMutableArray<XBTMyHongBaoModel *> *dataArray;
@property (nonatomic, assign) NSInteger page;

@end

@implementation DMLotOfViewTableView

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
    tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    UITableView_RegisterFormNib(tableView, @"DMLotOfViewTableViewCell");
    UITableView_AutomaticDimension(tableView, 100);
    self.tableView = tableView;
    [self addSubview:tableView];
    [tableView loading:self.frame];
    WeakSelf
    kSetupRefreshNormalHeader
}

- (void)loadData
{
    
    NSDictionary *params = @{@"couponStatus":@(self.type),//1，未领取，2，未使用，3，已使用，4，未领取过期，5未使用过期
                             @"curPage":@1
                             };
    WeakSelf
    [YBHttpTool postDataDifference:@"queryTCouponAndJxList" params:params success:^(id  _Nullable obj) {
//        [weakSelf stop];
        [weakSelf.tableView stop];
        [weakSelf.tableView.mj_header endRefreshing];
        if (obj!= nil) {
            
            DMStateModel *model = [DMStateModel mj_objectWithKeyValues:obj[@"state"]];
            DMPageModel *pageModel =[DMPageModel mj_objectWithKeyValues:obj[@"page"]];
            if (model.status == ResultStatusSuccess) {
                
                NSMutableArray *arr = [XBTMyHongBaoModel mj_objectArrayWithKeyValuesArray:obj[@"data"]];
                weakSelf.dataArray = arr;
                kSetupMJ_footer_loadData(loadMoreData)
            }else if(model.status == 3){
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
    NSDictionary *params = @{@"couponStatus":@(self.type),//1，未领取，2，未使用，3，已使用，4，未领取过期，5未使用过期
                             @"curPage":@(self.page)
                             };
    WeakSelf
    [YBHttpTool postDataDifference:@"queryTCouponAndJxList" params:params success:^(id  _Nullable obj) {
        [weakSelf.tableView stop];
        [weakSelf.tableView.mj_header endRefreshing];
        if (obj!= nil) {
            
            DMStateModel *model = [DMStateModel mj_objectWithKeyValues:obj[@"state"]];
            DMPageModel *pageModel =[DMPageModel mj_objectWithKeyValues:obj[@"page"]];
            if (model.status == ResultStatusSuccess) {
                
                NSMutableArray *arr = [XBTMyHongBaoModel mj_objectArrayWithKeyValuesArray:obj[@"data"]];
                weakSelf.dataArray = arr;
                kSetupMJ_footer_loadMoreData
            }else if(model.status == 3){
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
    return self.dataArray.count;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return 1;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    DMLotOfViewTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"DMLotOfViewTableViewCell" forIndexPath:indexPath];
    if (self.type != 1) {
        cell.useLabel.hidden = YES;
        cell.hongbaoImage.image = [UIImage imageNamed:@"shixiaohongbao"];
    }else{
        cell.useLabel.hidden = NO;
        cell.hongbaoImage.image = [UIImage imageNamed:@"hongbao"];
    }
    cell.cellModel = self.dataArray[indexPath.section];
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    if(self.type == 1){
        [kNotificationCenter postNotificationName:kNowUse object:nil];
    }
}

- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section
{
    return [UIView new];
}

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section
{
    return kHeightForSection;
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
