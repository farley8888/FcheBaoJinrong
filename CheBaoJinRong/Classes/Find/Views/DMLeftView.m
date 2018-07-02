//
//  DMLeftTabView.m
//  CheBaoJinRong
//
//  Created by apple on 2018/5/14.
//  Copyright © 2018年 apple. All rights reserved.
//

#import "DMLeftView.h"
#import "DMLeftTabelViewcell.h"
#import "DMDindModel.h"
#import "DMWebRechargeController.h"
#import "WKWebViewController.h"
#import "DMNavigationController.h"
#import "LonginController.h"

@interface DMLeftView ()<UITableViewDelegate,UITableViewDataSource>

@property (nonatomic, strong) NSMutableArray<List *> *dataArray;
@property (nonatomic, strong) UITableView *tableView;
@property (nonatomic, assign) NSInteger page;

@end

@implementation DMLeftView

- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if(self){
        [self setUI];
//        [self loadData];
    }
    return self;
}

- (void)setUI
{
    UITableView *tableView = [[UITableView alloc]initWithFrame:CGRectMake(0, 0, self.width, self.height) style:UITableViewStyleGrouped];
    tableView.backgroundColor = [UIColor groupTableViewBackgroundColor];
    tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    tableView.delegate = self;
    tableView.dataSource = self;
    UITableView_RegisterFormNib(tableView, @"DMLeftTabelViewcell");
    UITableView_AutomaticDimension(tableView, 100);
    self.tableView = tableView;
    [self addSubview:tableView];
    [self loading:CGRectMake(0, 0, self.frame.size.width, self.frame.size.height)];
    WeakSelf
    kSetupRefreshNormalHeader
}

- (void)loadData
{
    NSDictionary *params = @{@"type":@(self.type), // 不传：进行中  1：已结束
                             @"curPage":@1
                             };
    [self stop];
    WeakSelf
    [YBHttpTool postDataDifference:@"selectActivitylist" params:params success:^(id  _Nullable obj) {
        [weakSelf.tableView stop];
        [weakSelf.tableView.mj_header endRefreshing];
        if (obj!= nil) {
            DMDindModel *model = [DMDindModel mj_objectWithKeyValues:obj];
            DMPageModel *pageModel = model.page;
            weakSelf.dataArray = model.list;
            kSetupMJ_footer_loadData(loadMoreData)
            if (model.list.count == 0) {
                [weakSelf.tableView notData:CGRectMake(0, 1, kScreenW, weakSelf.tableView.height-1)];
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
    NSDictionary *params = @{@"type":@(self.type), // 不传：进行中  1：已结束
                             @"curPage":@(self.page)
                             };
    [self stop];
    WeakSelf
    [YBHttpTool postDataDifference:@"selectActivitylist" params:params success:^(id  _Nullable obj) {
        [weakSelf.tableView stop];
        [weakSelf.tableView.mj_footer endRefreshing];
        if (obj!= nil) {
            DMDindModel *model = [DMDindModel mj_objectWithKeyValues:obj];
            DMPageModel *pageModel = model.page;
            [weakSelf.dataArray addObjectsFromArray: model.list];
            kSetupMJ_footer_loadMoreData
            if (model.list.count == 0) {
                [weakSelf.tableView notData:CGRectMake(0, 1, kScreenW, weakSelf.tableView.height-1)];
            }
        }
    } failure:^(NSError * _Nullable error) {
        [weakSelf.tableView stop];
        [weakSelf.tableView.mj_footer endRefreshing];
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
    DMLeftTabelViewcell *cell = [tableView dequeueReusableCellWithIdentifier:@"DMLeftTabelViewcell" forIndexPath:indexPath];
    cell.type = self.type;
    if(self.type == Finish){
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
    }
    cell.cellModel = self.dataArray[indexPath.section];
    
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    if(self.type == 1){
        return;
    };
    NSString *url = self.dataArray[indexPath.section].activityWapSrc;
    DMLog(@"url = %@",url);
    NSString *title = nil;
    if ([url containsString:@"wechat/recommend.html"]) {
        title = @"推荐有礼";
    }else if ([url containsString:@"wechat/yungift.html"]){
        title = @"新手壕礼";
    }
    
    WKWebViewController *jsVC = [WKWebViewController new];
    jsVC.webViewH = kScreenH - 20;
    jsVC.url = url;
    jsVC.title = title;
    [[self viewController].navigationController pushViewController:jsVC animated:YES];
}
    
- (UIViewController *)viewController
{
    for (UIView* next = [self superview]; next; next = next.superview) {
        UIResponder *nextResponder = [next nextResponder];
        if ([nextResponder isKindOfClass:[UIViewController class]]) {
            return (UIViewController *)nextResponder;
        }
    }
    return nil;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
        //    F   690 *340
    CGFloat scare = 690/340.0;
    return kScreenW/scare;
}

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section
{
    return 10;
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
