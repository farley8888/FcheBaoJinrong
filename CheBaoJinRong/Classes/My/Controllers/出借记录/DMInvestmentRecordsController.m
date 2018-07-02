//
//  DMInvestmentRecordsController.m
//  CheBaoJinRong
//
//  Created by apple on 2018/5/15.
//  Copyright © 2018年 apple. All rights reserved.
//

#import "DMInvestmentRecordsController.h"
#import "DMSubstitutePaymentCell.h"
#import "DMInvestmentRecordsModel.h"
#import "DMScreenRecordController.h"

@interface DMInvestmentRecordsController ()

@property (nonatomic, strong) NSMutableArray<DMInvestmentRecordsModel *> *dataArray;
@property (nonatomic, copy) NSString *type;
@property (nonatomic, assign) NSInteger page;

@end

@implementation DMInvestmentRecordsController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self setUI];
    [self loadData];
}

- (void)setUI
{
    self.navigationItem.title = @"出借记录";
    self.navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc]initWithTitle:@"筛选" style:UIBarButtonItemStylePlain target:self action:@selector(rightBarButtonClick)];
    UITableView_RegisterFormNib(self.tableView, @"DMSubstitutePaymentCell");
    UITableView_AutomaticDimension(self.tableView, 80);
    WeakSelf
    kSetupRefreshNormalHeader
    
}

- (void)loadData
{
    NSMutableDictionary *params = [[NSMutableDictionary alloc]initWithDictionary: @{@"curPage":@1,
                                                                                    }];
    if (self.type.length != 0) {
        [params setValue:self.type forKey:@"borrowStatus"];
    }
    WeakSelf
    [YBHttpTool postDataDifference:@"selectInvestListing" params:params success:^(id  _Nullable obj) {
        kLoadDataHeaderEnd
        if (obj!= nil) {
            DMStateModel *stateModel = [DMStateModel mj_objectWithKeyValues:obj[@"state"]];
            DMPageModel *pageModel = [DMPageModel mj_objectWithKeyValues:obj[@"page"]];
            if (stateModel.status == ResultStatusSuccess) {
                NSMutableArray *arr = [DMInvestmentRecordsModel mj_objectArrayWithKeyValuesArray:obj[@"data"]];
                weakSelf.dataArray = arr;
                kSetupMJ_footer_loadData(loadMoreData)

            }else if (stateModel.status == 3){
                [weakSelf.dataArray removeAllObjects];
                [weakSelf.tableView reloadData];
                [weakSelf.tableView notData:weakSelf.tableView.frame];
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
    NSMutableDictionary *params = [[NSMutableDictionary alloc]initWithDictionary: @{@"curPage":@(self.page),
                                                                                    }];
    if (self.type.length != 0) {
        [params setValue:self.type forKey:@"borrowStatus"];
    }
    WeakSelf
    [YBHttpTool postDataDifference:@"selectInvestListing" params:params success:^(id  _Nullable obj) {
        kloadDataFooterEnd
        if (obj!= nil) {
            DMStateModel *stateModel = [DMStateModel mj_objectWithKeyValues:obj[@"state"]];
            DMPageModel *pageModel = [DMPageModel mj_objectWithKeyValues:obj[@"page"]];
            if (stateModel.status == ResultStatusSuccess) {
                NSMutableArray *arr = [DMInvestmentRecordsModel mj_objectArrayWithKeyValuesArray:obj[@"data"]];
                weakSelf.dataArray = arr;
                kSetupMJ_footer_loadMoreData
                
            }else if (stateModel.status == 3){
                
                [weakSelf.dataArray removeAllObjects];
                [weakSelf.tableView reloadData];
                [weakSelf.tableView notData:weakSelf.tableView.frame];
            }
        }
    } failure:^(NSError * _Nullable error) {
        kloadDataFooterEnd
    }];
}

- (void)rightBarButtonClick
{
    DMScreenRecordController *srVC = [DMScreenRecordController new];
    srVC.type = 2;
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
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    cell.cellInvestModel = self.dataArray[indexPath.row];
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
}

@end
