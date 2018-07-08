//
//  XBTSellOutController.m
//  CheBaoJinRong
//
//  Created by apple on 2018/5/18.
//  Copyright © 2018年 apple. All rights reserved.
//

#import "XBTSellOutController.h"
#import "XBTInvestmentCell.h"
#import "HomePageModel.h"

@interface XBTSellOutController ()<UITableViewDelegate, UITableViewDataSource>

@property (nonatomic, strong) UITableView *tableView;
@property (nonatomic, strong) NSMutableArray<Data1 *> *dataArray;
@property (nonatomic, assign) NSInteger page;

@end

@implementation XBTSellOutController

- (void)dealloc
{
    DMLog(@"%s",__func__);
}

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    [self setUI];
    [self loadData];
}

- (void)setUI
{
    self.navigationItem.title = @"售罄";
    UITableView *tableView = [[UITableView alloc]initWithFrame:CGRectMake(0, 0, kScreenW, kScreenH- SafeAreaTopHeight) style:UITableViewStyleGrouped];
    tableView.delegate = self;
    tableView.dataSource = self;
    tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    UITableView_RegisterFormNib(tableView, @"XBTInvestmentCell");
    UITableView_AutomaticDimension(tableView, 140);
    self.tableView = tableView;
    [self.view addSubview:tableView];
    [self.view loading:CGRectMake(0, 0, self.view.width, self.view.height)];
    WeakSelf
    kSetupRefreshNormalHeader
}

- (void)loadData
{
    NSDictionary *params = @{@"curPage":@1,
                             @"pageSize":kLimit
                             };
    WeakSelf
    [YBHttpTool postDataDifference:@"selectNoviceBorrowList2" params:params success:^(id  _Nullable obj) {
        kLoadDataHeaderEnd
        if (obj != nil) {
            XBTStateModel *state = [XBTStateModel mj_objectWithKeyValues:obj[@"state"]];
            XBTPageModel *pageModel = [XBTPageModel mj_objectWithKeyValues:obj[@"page"]];
            if (state.status == ResultStatusSuccess) {
                NSMutableArray *arr = [Data1 mj_objectArrayWithKeyValuesArray:obj[@"data"]];
                weakSelf.dataArray = arr;
                kSetupMJ_footer_loadData(loadMoreData)
            }else if (state.status == 3){
                [weakSelf.tableView notData:CGRectMake(0, 0, kScreenW, kScreenH - SafeAreaTopHeight)];
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
    [YBHttpTool postDataDifference:@"selectNoviceBorrowList2" params:params success:^(id  _Nullable obj) {
        kloadDataFooterEnd
        if (obj != nil) {
            XBTStateModel *state = [XBTStateModel mj_objectWithKeyValues:obj[@"state"]];
            XBTPageModel *pageModel = [XBTPageModel mj_objectWithKeyValues:obj[@"page"]];
            if (state.status == ResultStatusSuccess) {
                NSMutableArray *arr = [Data1 mj_objectArrayWithKeyValuesArray:obj[@"data"]];
                [weakSelf.dataArray addObjectsFromArray: arr];
                kSetupMJ_footer_loadMoreData
            }else if (state.status == 3){
                [weakSelf.tableView notData:CGRectMake(0, 0, kScreenW, kScreenH - SafeAreaTopHeight)];
            }
        }
    } failure:^(NSError * _Nullable error) {
        kloadDataFooterEnd
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

    XBTInvestmentCell *cell2 = [tableView dequeueReusableCellWithIdentifier:@"XBTInvestmentCell" forIndexPath:indexPath];
    cell2.cellData = self.dataArray[indexPath.section];
    cell2.type = SellOutType;
    cell2.selectionStyle = UITableViewCellSelectionStyleNone;
    return cell2;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
//    if (indexPath.section == 0) {
//        CGFloat score = 400.0/230;
//        return kScreenW/score;
//    }
    CGFloat scare = 525.0/250;
    return kScreenW/scare;
}

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section
{
    return kHeightForSection;
}

- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section
{
    return [UIView new];
}

- (CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section
{
    return CGFLOAT_MIN;
}

- (UIView *)tableView:(UITableView *)tableView viewForFooterInSection:(NSInteger)section
{
    return [UIView new];
}

@end
