//
//  DMMessageChildController.m
//  CheBaoJinRong
//
//  Created by apple on 2018/5/29.
//  Copyright © 2018年 apple. All rights reserved.
//

#import "XBTMessageChildController.h"
#import "MessageChildCell.h"
#import "MessageChildModel.h"
#import "MessageDetialController.h"
#import "WKWebViewController.h"
#import "MessageController.h"

@interface XBTMessageChildController ()

@property (nonatomic, strong) NSMutableArray<MessageChildModel *> *dataArray;
@property (nonatomic, assign) NSInteger page;

@end

@implementation XBTMessageChildController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    [self setTableViewCell];
}


- (void)setTableViewCell
{
    UITableView_RegisterFormNib(self.tableView, @"MessageChildCell");
    UITableView_AutomaticDimension(self.tableView, 120);
    
    [self.tableView loading:CGRectMake(0, 0, self.tableView.width, self.tableView.height)];
    WeakSelf
    kSetupRefreshNormalHeader
}

- (void)loadData
{
    WeakSelf
    [YBHttpTool postDataDifference:self.url params:nil success:^(id  _Nullable obj) {
        [weakSelf.tableView stop];
        kLoadDataHeaderEnd
        if (obj != nil) {
            XBTStateModel *stateModel = [XBTStateModel mj_objectWithKeyValues:obj[@"state"]];
            XBTPageModel *pageModel = [XBTPageModel mj_objectWithKeyValues:obj[@"page"]];
            if (stateModel.status == ResultStatusSuccess) {
                NSMutableArray *arr = [MessageChildModel mj_objectArrayWithKeyValuesArray:obj[@"data"]];
                weakSelf.dataArray = arr;
                kSetupMJ_footer_loadData(loadMoreData)

            }else if (stateModel.status == ResultStatusNoData){
                [weakSelf.tableView notData:CGRectMake(0, 0, kScreenW, weakSelf.view.height)];
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
        if (obj != nil) {
            XBTStateModel *stateModel = [XBTStateModel mj_objectWithKeyValues:obj[@"state"]];
            XBTPageModel *pageModel = [XBTPageModel mj_objectWithKeyValues:obj[@"page"]];
            if (stateModel.status == ResultStatusSuccess) {
                NSMutableArray *arr = [MessageChildModel mj_objectArrayWithKeyValuesArray:obj[@"data"]];
                [weakSelf.dataArray addObjectsFromArray: arr];
                kSetupMJ_footer_loadMoreData
                if (arr.count == 0) {
                    [weakSelf.view notData:CGRectMake(0, 0, kScreenW, weakSelf.view.height)];
                }
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
    MessageChildCell *cell = [tableView dequeueReusableCellWithIdentifier:@"MessageChildCell" forIndexPath:indexPath];
    cell.type = self.type;
    cell.cellModel = self.dataArray[indexPath.row];
    
    return  cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    
    WKWebViewController *wkWebView = [WKWebViewController new];
    
    NSArray *arr = self.navigationController.childViewControllers;
    MessageController *vc = arr[1];
    if (vc.type == 2) {
        wkWebView.webViewH = kScreenH - 20;
    }else{
        wkWebView.webViewH = kScreenH + 44;
    }
    
    if (self.type == 1) {
        wkWebView.navigationItem.title = @"平台公告";
        wkWebView.url = [NSString stringWithFormat:@"http://www.chebaojr.com/wechat/noticemsg.html?id=%@",self.dataArray[indexPath.row].id];
    }else{
        wkWebView.navigationItem.title = @"媒体报道";
        wkWebView.url = [NSString stringWithFormat:@"http://www.chebaojr.com/wechat/mediamsg.html?id=%@",self.dataArray[indexPath.row].id];
    }
    [self.navigationController pushViewController:wkWebView animated:YES];
}

@end
