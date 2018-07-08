//
//  DMMyCouponController.m
//  CheBaoJinRong
//
//  Created by apple on 2018/5/29.
//  Copyright © 2018年 apple. All rights reserved.
//

#import "XBTMyCouponController.h"
#import "LotOfViewTableViewCell.h"
#import "MyCouponModel.h"

@interface XBTMyCouponController ()

@property (nonatomic, strong) NSMutableArray<MyCouponModel *> *dataArray;
@property (nonatomic, assign) NSInteger coupID;
@property (nonatomic, assign) NSInteger coupType;
@property (nonatomic, copy) NSString *coupAmout;

@end

@implementation XBTMyCouponController

- (void)dealloc
{
    DMLog(@"%s",__func__);
}

- (void)viewDidLoad {
    [super viewDidLoad];

    [self setUI];
    [self loadData];
}
- (void)viewWillDisappear:(BOOL)animated
{
    [super viewWillDisappear:animated];
    if (self.selsctCouponBlock) {
            self.selsctCouponBlock(self.coupID, self.coupType, self.coupAmout);
        }
}


- (void)setUI
{
    self.navigationItem.title = @"我的卡券";
    UITableView_RegisterFormNib(self.tableView, @"LotOfViewTableViewCell");
    UITableView_AutomaticDimension(self.tableView, 120);
    self.tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    WeakSelf
    kSetupRefreshNormalHeader
    
}

- (void)loadData
{
    NSDictionary *params = @{@"couponAmount":self.moneyAmout,
                             @"useqx":self.deadlin,
                             @"rqlx":self.deadlineType
                             };
    WeakSelf
    [YBHttpTool postDataDifference:@"ajaxgetuseryhq" params:params success:^(id  _Nullable obj) {
        kLoadDataHeaderEnd
        if (obj!=nil) {
            XBTStateModel *stateModel = [XBTStateModel mj_objectWithKeyValues:obj[@"state"]];
            if (stateModel.status == ResultStatusSuccess) {
                NSMutableArray *arr = [MyCouponModel mj_objectArrayWithKeyValuesArray:obj[@"data"]];
                weakSelf.dataArray = arr;
                if (arr.count == 0) {
                    [weakSelf.tableView notData:CGRectMake(0, 0, kScreenW, kScreenH - 64)];
                }
                [weakSelf.tableView reloadData];
                
            }else{
                [XBTProgressHUD showSuccess:stateModel.info];
            }
        }
    } failure:^(NSError * _Nullable error) {
        kLoadDataHeaderEnd
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
    LotOfViewTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"LotOfViewTableViewCell" forIndexPath:indexPath];
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    cell.coupModel = self.dataArray[indexPath.row];
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    MyCouponModel *model = self.dataArray[indexPath.row];
    self.coupAmout = model.couponAmount;
    self.coupID = model.id;
    self.coupType = model.couponType;
    
    [self.navigationController popViewControllerAnimated:YES];
}

@end