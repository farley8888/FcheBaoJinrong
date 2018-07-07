//
//  DMLoanMaterialController.m
//  CheBaoJinRong
//
//  Created by apple on 2018/5/28.
//  Copyright © 2018年 apple. All rights reserved.
//

#import "DMLoanMaterialController.h"
#import "DMLoanMaterialCell.h"
#import "DMLoanMateriaModel.h"

#import "XBTWebImageAutoSize.h"

@interface DMLoanMaterialController ()<UITableViewDelegate, UITableViewDataSource>

@property (nonatomic, strong) NSMutableArray<DMLoanMateriaModel *> *dataArray;
@property (nonatomic, strong) UITableView *tableView;

@end

@implementation DMLoanMaterialController

- (void)dealloc
{
    DMLog(@"%s",__func__);
}

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self setUI];

}

- (void)setUI
{
    [self.view loading:self.view.frame];
    UITableView *tableView = [[UITableView alloc]initWithFrame:CGRectMake(0, 0, kScreenW, kScreenH -60 - SafeAreaTopHeight - SafeAreaBottomHeight - 50) style:UITableViewStyleGrouped];
    self.tableView = tableView;
    tableView.delegate = self;
    tableView.dataSource = self;
    UITableView_RegisterFormNib(tableView, @"DMLoanMaterialCell");
    UITableView_AutomaticDimension(tableView, 120);
    [self.view addSubview:tableView];
    [self.view loading:self.view.frame];
    WeakSelf
    kSetupRefreshNormalHeader
    
}

- (void)loadData
{
    WeakSelf
    [YBHttpTool postDataDifference:@"queryBorrowData" params:@{@"id":self.prdID} success:^(id  _Nullable obj) {
        kLoadDataHeaderEnd
        if (obj!=nil) {
            DMStateModel *stateModel = [DMStateModel mj_objectWithKeyValues:obj[@"state"]];
            if (stateModel.status == ResultStatusSuccess) {
                NSMutableArray *arr = [DMLoanMateriaModel mj_objectArrayWithKeyValuesArray:obj[@"data"]];
                weakSelf.dataArray = arr;
//                dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(2 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
                
                    [weakSelf.tableView reloadData];
//                });
                
            }else if (stateModel.status == 3){
               
                [weakSelf.tableView notData:weakSelf.tableView.frame];
            }
        }
    } failure:^(NSError * _Nullable error) {
        kLoadDataHeaderEnd
    }];
    self.isLoadData = YES;
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    DMLog(@"DC:%@",kDocumentPath);
    return self.dataArray.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    DMLoanMaterialCell *cell = [tableView dequeueReusableCellWithIdentifier:@"DMLoanMaterialCell" forIndexPath:indexPath];
    DMLoanMateriaModel *model = self.dataArray[indexPath.row];
    NSString *url = [NSString stringWithFormat:@"%@%@",kAPI_URL,model.attrPath];
    DMLog(@"%@",url);
    [cell.leftConterButton setTitle:model.attrName forState:UIControlStateNormal];
    [cell.imgView sd_setImageWithURL:[NSURL URLWithString:url] completed:^(UIImage *image, NSError *error, SDImageCacheType cacheType, NSURL *imageURL) {
    
        /** 缓存image size */
        [XBTWebImageAutoSize storeImageSize:image forURL:imageURL completed:^(BOOL result) {
            /** reload  */
            if(result)  [tableView  dm_reloadDataForURL:imageURL];
        }];
    }];
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    return cell;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    DMLoanMateriaModel *model = self.dataArray[indexPath.row];
    NSString *url = [NSString stringWithFormat:@"%@%@",kAPI_URL,model.attrPath];
     return [XBTWebImageAutoSize imageHeightForURL:[NSURL URLWithString:url] layoutWidth:kScreenW -30 estimateHeight:200];
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
