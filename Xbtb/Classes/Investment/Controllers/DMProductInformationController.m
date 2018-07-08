//
//  DMProductInformationController.m
//  CheBaoJinRong
//
//  Created by apple on 2018/5/28.
//  Copyright © 2018年 apple. All rights reserved.
//

#import "DMProductInformationController.h"
#import "XBTProductInformationCell.h"
#import "XBTProductInformationModel.h"

@interface DMProductInformationController ()

@property (nonatomic, strong) NSArray *titleArray;
@property (nonatomic, strong) NSArray *detialArray;

@end

@implementation DMProductInformationController

- (NSArray *)titleArray
{
    if (_titleArray == nil) {
        _titleArray = @[@"项目说明",@"借款人信息",@"车辆信息",@"担保措施"];
    }
    return _titleArray;
}

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
    UITableView_RegisterFormNib(self.tableView, @"DMProductInformationCell");
    UITableView_AutomaticDimension(self.tableView, 100);
    [self.tableView loading:CGRectMake(0, 0, self.tableView.width, self.tableView.height)];
    WeakSelf
    kSetupRefreshNormalHeader
}


- (void)loadData
{
    WeakSelf
    [YBHttpTool postDataDifference:@"queryBorrowIntroduce" params:@{@"id":self.prdID} success:^(id  _Nullable obj) {
        kLoadDataHeaderEnd
        if (obj!= nil) {
            XBTStateModel *stateModel = [XBTStateModel mj_objectWithKeyValues:obj[@"state"]];
            if (stateModel.status == ResultStatusSuccess) {
                XBTProductInformationModel *model = [XBTProductInformationModel mj_objectWithKeyValues:obj[@"data"]];
                weakSelf.detialArray = @[model.introductionInfos,model.riskControlInfos,model.collateralInfos,model.guaranteetype];
                [weakSelf.tableView reloadData];
            }
        }
    } failure:^(NSError * _Nullable error) {
        kLoadDataHeaderEnd
    }];
    self.isLoadData = YES;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return self.titleArray.count;
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 1;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    XBTProductInformationCell *cell = [tableView dequeueReusableCellWithIdentifier:@"DMProductInformationCell" forIndexPath:indexPath];
    cell.titleStrig = self.titleArray[indexPath.row];
    cell.detialString = self.detialArray[indexPath.row];
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    return cell;
    
}


@end
