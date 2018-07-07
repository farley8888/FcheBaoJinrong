//
//  DMRegularController.m
//  CheBaoJinRong
//
//  Created by apple on 2018/5/28.
//  Copyright © 2018年 apple. All rights reserved.
//

#import "DMRegularController.h"
#import "XBTDetialCell.h"
#import "XBTRegularCell.h"
#import "DMRegularModel.h"
#import "XBTDidiDetialHeadView.h"
#import "XBTRegularSectionHeadView.h"
#import "XBTProductDetailsController.h"          //产品详情
#import "DMRegularPurchaseController.h"         //立即购买
#import "XBTNavigationController.h"
#import "LonginController.h"

@interface DMRegularController ()<UITableViewDelegate,UITableViewDataSource>

@property (nonatomic, strong) UITableView *tableView;
@property (nonatomic, strong) DMRegularModel *dataModel;
@property (nonatomic, strong) NSArray *titleArray;
@property (nonatomic, strong) NSArray *deltialArray;
@property (nonatomic, strong) XBTDidiDetialHeadView *headView;
@property (nonatomic, strong) UIButton *bottomButton;


@end

@implementation DMRegularController

-(void)dealloc
{
    [kNotificationCenter removeObserver:self];
}

- (NSArray *)titleArray
{
    if (_titleArray == nil) {
        _titleArray = @[@" 项目类型",@" 产品特点",@" 起息时间",@" 还款方式",@" 起投金额",@" 产品介绍"];
    }
    return _titleArray;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    [self.view loading:CGRectMake(0, 0, self.view.width, self.view.height)];
    [self setupUI];
    [self loadData];
}

- (void)setupUI
{
    self.navigationItem.title = self.titleString;
    self.view.backgroundColor = [UIColor whiteColor];
    UITableView *tableView = [[UITableView alloc]initWithFrame:CGRectMake(0, 0, kScreenW, kScreenH- SafeAreaTopHeight - 50 - SafeAreaBottomHeight) style:UITableViewStyleGrouped];
    tableView.delegate = self;
    tableView.dataSource = self;
    UITableView_RegisterFormNib(tableView, @"DMRegularCell");
    UITableView_RegisterFormNib(tableView, @"DMDetialCell");
    UITableView_AutomaticDimension(tableView, 100);
    tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    self.tableView = tableView;
    [self.view addSubview:tableView];
    
    UIButton *button = [UIButton buttonWithType:UIButtonTypeCustom];
    button.frame = CGRectMake(0, CGRectGetMaxY(tableView.frame), kScreenW, 50);
    [button addTarget:self action:@selector(buttonClick) forControlEvents:UIControlEventTouchUpInside];
    [button setTitle:@"立即出借" forState:UIControlStateNormal];
    [button setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    [button setBackgroundColor:kColor(242, 177, 67)];
    self.bottomButton = button;
    [self.view addSubview:button];
    
    XBTDidiDetialHeadView *headView = [XBTDidiDetialHeadView headView];
    headView.frame = CGRectMake(0, 0, kScreenW, 290);
    headView.type = RegularHeadView;
    WeakSelf
    [headView setTimerStopBlock:^{
        [weakSelf loadData];
    }];
    self.headView = headView;
    self.tableView.tableHeaderView = headView ;
    [kNotificationCenter addObserver:self selector:@selector(pushBuyDidiBaoVC) name:kLoginSuccessNotification object:nil];
}

#pragma mark - 立即购买
- (void)buttonClick
{
    if ([UserManager sharedManager].user.token.length) {
        [self pushBuyDidiBaoVC];
    }else{
        XBTNavigationController *nav = [[XBTNavigationController alloc] initWithRootViewController:[[LonginController alloc] init]];
        [self.navigationController presentViewController:nav animated:YES completion:nil];
    }
}

- (void)pushBuyDidiBaoVC
{
    DMRegularPurchaseController *rpVC = [DMRegularPurchaseController new];
    rpVC.regModel = self.dataModel;
    [self.navigationController pushViewController:rpVC animated:YES];
}

#pragma mark - 加载数据
- (void)loadData
{
    WeakSelf
    [YBHttpTool postDataDifference:@"queryBorrowDetail" params:@{@"id":self.prdID} success:^(id  _Nullable obj) {
        if (obj!=nil) {
            DMStateModel *stateModel = [DMStateModel mj_objectWithKeyValues:obj[@"state"]];
            if (stateModel.status == ResultStatusSuccess) {
                
                DMRegularModel *regMoel = [DMRegularModel mj_objectWithKeyValues:obj[@"tBorrowModel"]];
                weakSelf.dataModel = regMoel;
                [weakSelf setBottomButtonTitle];
                weakSelf.deltialArray = @[@"车辆抵押",@"借款抵押物足额抵押，利息稳定高效",regMoel.interestBearingType,regMoel.repayTypeString,regMoel.minInvestString];
                weakSelf.headView.regularModel = regMoel;
                [weakSelf.tableView reloadData];
                
            }
        }
    } failure:^(NSError * _Nullable error) {
        
    }];
}

- (void)setBottomButtonTitle
{
    NSString *str = @"";
    UIColor *gary = [UIColor grayColor];
    switch (self.dataModel.borrowStatus) {
        case 2:
            str = @"即将开标";
            break;
        case 3:
            str = @"立即出借";
            gary = kColor(242, 177, 67);
            break;
        case 4:
            str = @"满标审核中";
            break;
        case 5:
            str = @"正在还款";
            break;
        case 6:
            str = @"还款结束";
            break;
        case 9:
            str = @"已流标";
            break;
            
        default:
            break;
    }
    if(self.dataModel.borrowStatus == 3){
        self.bottomButton.userInteractionEnabled = YES;
    }else{
        self.bottomButton.userInteractionEnabled = NO;
    }
    [self.bottomButton setTitle:str forState:UIControlStateNormal];
    [self.bottomButton setBackgroundColor:gary];
}

#pragma mark - UITabViewDelegate
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return self.titleArray.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    UITableViewCell *cell = nil;
    if (indexPath.row != 5) {
        XBTDetialCell *detialCell = [tableView dequeueReusableCellWithIdentifier:@"DMDetialCell" forIndexPath:indexPath];
        detialCell.detialBKView.backgroundColor = kColor(254, 251, 247);
        detialCell.titleStrig = self.titleArray[indexPath.row];
        detialCell.detialString = self.deltialArray[indexPath.row];
        cell = detialCell;
        
    }else{
        XBTRegularCell *regCell = [tableView dequeueReusableCellWithIdentifier:@"DMRegularCell" forIndexPath:indexPath];
        cell = regCell;
    }
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    if (indexPath.row == 5) {
        XBTProductDetailsController  *vc = [XBTProductDetailsController new];
        vc.prdID = self.prdID;
        vc.regModel = self.dataModel;
        [self.navigationController pushViewController:vc animated:YES];
    }
}

- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section
{
    return [XBTRegularSectionHeadView headview];
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
    return 50;
}

@end
