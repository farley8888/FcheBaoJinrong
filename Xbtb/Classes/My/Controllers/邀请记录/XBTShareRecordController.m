//
//  DMShareRecordController.m
//  CheBaoJinRong
//
//  Created by apple on 2018/6/28.
//  Copyright © 2018年 apple. All rights reserved.
//

#import "XBTShareRecordController.h"
#import "DMShareRecordCell.h"
#import "DMShareRecordSectionView.h"
#import "DMShareRecordHeadView.h"
#import "DMShareRecordModel.h"

@interface XBTShareRecordController ()

@property (nonatomic, assign) NSInteger page;
@property (nonatomic, strong) DMShareRecordModel *dataModel;
@property (nonatomic, strong) DMShareRecordHeadView *headView;
    
@end

@implementation XBTShareRecordController

- (void)viewDidLoad {
    [super viewDidLoad];
 
    
    [self setUI];
    [self setTableViewHeadView];
    [self loadData];
}

- (void)setUI
{
    self.navigationItem.title = @"邀请记录";
    self.tableView.backgroundColor = [UIColor whiteColor];
    self.tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    UITableView_RegisterFormNib(self.tableView, @"DMShareRecordCell");
    UITableView_AutomaticDimension(self.tableView, 100);
}

- (void)setTableViewHeadView
{
    CGFloat score = 305/168.0;
    CGFloat head_H = kScreenW / score;
    DMShareRecordHeadView *headview = [DMShareRecordHeadView shareRecordHeadView];
    headview.frame = CGRectMake(0, 0, kScreenW, head_H);
    self.headView = headview;
    self.tableView.tableHeaderView = headview;
    WeakSelf
    kSetupRefreshNormalHeader
}

- (void)loadData
{
    NSDictionary *params = @{@"curPage":@1,
                             };
    WeakSelf
    [YBHttpTool postDataDifference:@"selectReferee" params:params success:^(id  _Nullable obj) {
        kLoadDataHeaderEnd
        if (obj!= nil) {
            DMStateModel *stateModel = [DMStateModel mj_objectWithKeyValues:obj[@"state"]];
            if (stateModel.status == ResultStatusSuccess) {
                DMShareRecordModel *model = [DMShareRecordModel mj_objectWithKeyValues:obj];
                DMPageModel *pageModel = [DMPageModel mj_objectWithKeyValues:obj[@"page"]];
                weakSelf.dataModel = model;
                
                weakSelf.headView.totalMoneyLabel.text = model.sumtjjl;
                weakSelf.headView.totalFriendLabel.text = [NSString stringWithFormat:@"   已邀请%ld位好友    ",model.count];
                kSetupMJ_footer_loadData(loadMoreData);
                
            }else if(stateModel.status == ResultStatusNoData){
                [weakSelf.view notData:CGRectMake(0, 0, kScreenW, kScreenH)];
            }
        }
    } failure:^(NSError * _Nullable error) {
        kLoadDataHeaderEnd
    }];
}
    
- (void)loadMoreData
{
    NSDictionary *params = @{@"curPage":@(self.page)};
    WeakSelf
    [YBHttpTool postDataDifference:@"selectReferee" params:params success:^(id  _Nullable obj) {
        kloadDataFooterEnd
        if (obj!= nil) {
            DMStateModel *stateModel = [DMStateModel mj_objectWithKeyValues:obj[@"state"]];
            if (stateModel.status == ResultStatusSuccess) {
                DMShareRecordModel *model = [DMShareRecordModel mj_objectWithKeyValues:obj];
                DMPageModel *pageModel = [DMPageModel mj_objectWithKeyValues:obj[@"page"]];
                [weakSelf.dataModel.data addObjectsFromArray:model.data];
                kSetupMJ_footer_loadMoreData;
                    
            }else if(stateModel.status == ResultStatusNoData){
                    [weakSelf.view notData:CGRectMake(0, 0, kScreenW, kScreenH)];
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
    return self.dataModel.data.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    DMShareRecordCell *cell = [tableView dequeueReusableCellWithIdentifier:@"DMShareRecordCell" forIndexPath:indexPath];
    cell.cellModel = self.dataModel.data[indexPath.row];
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    return cell;
}

- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section
{
    return [DMShareRecordSectionView shareRecordSectionView];
}

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section
{
    return 50;
}




@end
