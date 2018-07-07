//
//  DMProductDetailsController.m
//  CheBaoJinRong
//
//  Created by apple on 2018/5/28.
//  Copyright © 2018年 apple. All rights reserved.
//

#import "XBTProductDetailsController.h"
#import "DMProductInformationController.h"      //产品信息
#import "DMLoanMaterialController.h"            //借款资料
#import "DMPurchaseRecordController.h"          //购买记录
#import "DMRegularPurchaseController.h"         //购买非滴滴宝
#import "DMLotOfViewScrollerTopView.h"
#import "XBTNavigationController.h"
#import "LonginController.h"

@interface XBTProductDetailsController ()<UIScrollViewDelegate>

@property (nonatomic, strong) DMProductInformationController *prdInfoVC;
@property (nonatomic, strong) DMLoanMaterialController *loaMaterVC;
@property (nonatomic, strong) DMPurchaseRecordController *purchRecordVC;
@property (nonatomic, strong) DMLotOfViewScrollerTopView *topView;
@property (nonatomic, strong) UIScrollView *scroller;

@end

@implementation XBTProductDetailsController

-(void)dealloc
{
    DMLog(@"%s",__func__);
    [kNotificationCenter removeObserver:self];
}

- (DMProductInformationController *)prdInfoVC
{
    if (_prdInfoVC == nil) {
        _prdInfoVC = [DMProductInformationController new];
        _prdInfoVC.prdID = self.prdID;
    }
    return _prdInfoVC;
}

- (DMLoanMaterialController *)loaMaterVC
{
    if (_loaMaterVC == nil) {
        _loaMaterVC = [DMLoanMaterialController new];
        _loaMaterVC.prdID = self.prdID;
    }
    return _loaMaterVC;
}

- (DMPurchaseRecordController *)purchRecordVC
{
    if (_purchRecordVC == nil) {
        _purchRecordVC = [DMPurchaseRecordController new];
        _purchRecordVC.prdID = self.prdID;
        _purchRecordVC.result = self.regModel.borrowStatus;
    }
    return _purchRecordVC;
}

- (UIScrollView *)scroller
{
    if (_scroller == nil) {
        _scroller = [[UIScrollView alloc]initWithFrame:CGRectMake(0, 60, kScreenW, kScreenH -60 - SafeAreaTopHeight - SafeAreaBottomHeight - 50)];
        _scroller.showsVerticalScrollIndicator = NO;
        _scroller.showsHorizontalScrollIndicator = NO;
        _scroller.pagingEnabled = YES;
        _scroller.delegate = self;
        _scroller.contentSize = CGSizeMake(kScreenW * 3, 0);
    }
    return _scroller;
}


- (void)viewDidLoad {
    [super viewDidLoad];

    [self setScrollerViews];
    [self setController];
    [self setBottomButton];
    [self skipToPageForType:0];
}
- (void)setScrollerViews
{
    self.navigationItem.title = @"产品介绍";
    self.view.backgroundColor = [UIColor whiteColor];
    DMLotOfViewScrollerTopView *topView = [[DMLotOfViewScrollerTopView alloc]initWithFrame:CGRectMake(0, 0, kScreenW  , 60)];
    topView.titleArr = @[@"产品信息",@"借款材料",@"购买记录"];
    WeakSelf
    [topView setButtonClickBlock:^(NSInteger tag) {
        [weakSelf scrollerView:tag];
    }];
    self.topView = topView;
    [self.view addSubview:topView];
}

 - (void)setBottomButton
{
    UIButton *button = [UIButton buttonWithType:UIButtonTypeCustom];
    button.frame = CGRectMake(0, CGRectGetMaxY(self.scroller.frame), kScreenW, 50);
    [button addTarget:self action:@selector(buttonClick) forControlEvents:UIControlEventTouchUpInside];
    [button setTitle:@"立即出借" forState:UIControlStateNormal];
    [button setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    [button setBackgroundColor:kColor(242, 177, 67)];
    NSString *str = @"立即出借";
    UIColor *gary = [UIColor grayColor];
    switch (self.regModel.borrowStatus) {
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
    if(self.regModel.borrowStatus == 3){
        button.userInteractionEnabled = YES;
    }else{
        button.userInteractionEnabled = NO;
    }
    [button setTitle:str forState:UIControlStateNormal];
    [button setBackgroundColor:gary];
    [self.view addSubview:button];
//    [kNotificationCenter addObserver:self selector:@selector(pushVC) name:kLoginSuccessNotification object:nil];
}

- (void)buttonClick
{
    if ([UserManager sharedManager].user.token.length) {
        [self pushVC];
    }else{
        XBTNavigationController *nav = [[XBTNavigationController alloc] initWithRootViewController:[[LonginController alloc] init]];
        [self.navigationController presentViewController:nav animated:YES completion:nil];
    }
}

- (void)pushVC
{
    DMRegularPurchaseController *rpVC = [DMRegularPurchaseController new];
    rpVC.regModel = self.regModel;
    [self.navigationController pushViewController:rpVC animated:YES];
}

- (void)setController
{
    [self.view addSubview: self.scroller];
    [self addChildViewController:self.prdInfoVC];
    [self.scroller  addSubview:self.prdInfoVC.view];
    self.prdInfoVC.view.frame = CGRectMake(0, 0, kScreenW, self.scroller.height);
    
    [self addChildViewController:self.loaMaterVC];
    [self.scroller addSubview:self.loaMaterVC.view];
    self.loaMaterVC.view.frame = CGRectMake(kScreenW, 0, kScreenW, self.scroller.height);
    
    [self addChildViewController:self.purchRecordVC];
    [self.scroller addSubview:self.purchRecordVC.view];
    self.purchRecordVC.view.frame = CGRectMake(2*kScreenW, 0, kScreenW, self.scroller.height);
}

- (void)scrollerView:(NSInteger)tag
{
    [self.scroller setContentOffset:CGPointMake(tag * kScreenW, 0) animated:YES];
//    NSInteger index = (self.scroller.contentOffset.x+ self.scroller.width/2)/self.scroller.width;
    [self skipToPageForType:tag];
}

- (void)scrollViewDidEndDecelerating:(UIScrollView *)scrollView
{
    NSInteger index = (scrollView.contentOffset.x+scrollView.width/2)/scrollView.width;
    self.topView.selectIndex = index;
    [self scrolleAndLoadData:index];
}

- (void)scrolleAndLoadData:(NSInteger)tag
{
    
    if (tag == 0) {
        __kindof DMProductInformationController *vc = self.childViewControllers[tag];
        if (!vc.isLoadData) {
            [vc loadData];
        }
    }else if(tag == 1){
        __kindof DMLoanMaterialController *vc = self.childViewControllers[tag];
        if (!vc.isLoadData) {
            [vc loadData];
        }
    }else{
        __kindof DMPurchaseRecordController *vc = self.childViewControllers[tag];
        if (!vc.isLoadData) {
            [vc loadData];
        }
    }
}

//根据type跳到相应的页面
- (void)skipToPageForType:(NSInteger )type
{
    [self.scroller setContentOffset:CGPointMake(type*self.scroller.width, 0) animated:YES];
    
    [self scrolleAndLoadData:type];
}


@end
