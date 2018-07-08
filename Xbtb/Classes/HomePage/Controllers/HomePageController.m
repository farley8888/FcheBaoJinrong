//
//  HomePageController.m
//  CheBaoJinRong
//
//  Created by ltyj on 2017/12/7.
//  Copyright © 2017年 ltyj. All rights reserved.
//

#import "HomePageController.h"
#import "XBTHomePageCell3.h"
#import "XBTHomePageCell2.h"
#import "XBTHomePageCell4.h"
#import "XBTHomeHeardView.h"
#import "DMHomePageModel.h"
#import "DMDidiDetialController.h"
#import "DMRegularController.h"
#import "MessageController.h"
#import "XBTJSViewController.h"
#import "WKWebViewController.h"
#import "XBTWebRechargeController.h"
#import "XBTNavigationController.h"
#import "LonginController.h"

#import "UIImage+DMIconFont.h"
#import "CALayer+Transition.h"

@interface HomePageController ()

@property (nonatomic, strong) DMHomePageModel *dataModel;

@end

@implementation HomePageController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self setNav];
    [self setUI];
    [self setTabHeader];
    [self loadData];
}
- (void)setUI
{
    self.tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    UITableView_RegisterFormNib(self.tableView, @"DMHomePageCell3");
    UITableView_RegisterFormNib(self.tableView, @"DMHomePageCell2");
    UITableView_RegisterFormNib(self.tableView, @"DMHomePageCell4");
    UITableView_AutomaticDimension(self.tableView, 160);
    WeakSelf
    kSetupRefreshNormalHeader
}

- (void)setNav
{
    UIImageView *imageView = [[UIImageView alloc]initWithFrame:CGRectMake(0, 0, 50, 35)];
    imageView.image = [UIImage imageNamed:@"logo"];
    imageView.contentMode = UIViewContentModeScaleAspectFill;
    self.navigationItem.titleView = imageView;
}

- (void)setTabHeader
{
    CGFloat headView_H = kScreenW/(670.0/330.0) + 132;
    XBTHomeHeardView *heardView = [XBTHomeHeardView homeHeardView];
    heardView.frame = CGRectMake(0, 0, kScreenW, headView_H);
    WeakSelf
    [heardView setBanerClickBlock:^(NSInteger index) {
        [weakSelf banerUrl:index];
    }];
    [heardView setHomeButtonClickBlock:^(NSInteger tag) {
        [weakSelf homeButtonUrl:tag];
    }];
    [heardView setLoopViewBlock:^{
        MessageController *msVC = [MessageController new];
        msVC.type = 2;
        [weakSelf.navigationController pushViewController:msVC animated:YES];
    }];
    
    self.tableView.tableHeaderView = heardView;
}

- (void)loadData
{
    WeakSelf
    [YBHttpTool postDataDifference:@"index" params:nil success:^(id  _Nullable obj) {
        kLoadDataHeaderEnd
        if (obj != nil) {
            DMHomePageModel *model = [DMHomePageModel mj_objectWithKeyValues:obj];
            if (model.state.status == ResultStatusSuccess) {

                weakSelf.dataModel = model;
                XBTHomeHeardView *headView = (XBTHomeHeardView *)weakSelf.tableView.tableHeaderView;
                headView.imageArray = model.banners;
                headView.loopViewArray = model.data4;
                [weakSelf.tableView reloadData];
            }
        }
    } failure:^(NSError * _Nullable error) {
        kLoadDataHeaderEnd
    }];
}

- (void)homeButtonUrl:(NSInteger)tag
{
    NSString *jsUrl = nil;
    NSString *title = nil;
    switch (tag) {
        case 0:
            jsUrl = [NSString stringWithFormat:@"%@wechat/yungift.html",kAPI_URL];
            title = @"新人壕礼";
            break;
        case 1:
            jsUrl = [NSString stringWithFormat:@"%@wechat/aboutUs.html",kAPI_URL];
            title = @"信息披露";
            break;
        case 2:
            jsUrl = [NSString stringWithFormat:@"%@wechat/safe.html",kAPI_URL];
            title = @"安全保障";
            break;
        case 3:
            jsUrl = [NSString stringWithFormat:@"%@wechat/recommend.html",kAPI_URL];
            title = @"推荐有礼";
            break;
            
        default:
            break;
    }
    [self pushVC:jsUrl title:title];
}

- (void)banerUrl:(NSInteger )index
{
    NSString *url = self.dataModel.banners[index].url;
    DMLog(@"banerTitle: %@ ",url);
    if ([url containsString:@"wechat/index.html"]) {
        return;
    }
    NSString *title = nil;
    if ([url isEqualToString:@"wechat/recommend.html"]) {
        title = @"推荐有礼";
    }else if ([url isEqualToString:@"wechat/yungift.html"]){
        title = @"新手壕礼";
    }
    url = [NSString stringWithFormat:@"%@%@",kAPI_URL,url];
    [self pushVC:url title:title];
}
    
- (void)pushVC:(NSString*)jsUrl title:(NSString *)tit
{
    WKWebViewController *jsVC = [WKWebViewController new];
    jsVC.webViewH = kScreenH-20;;
    jsVC.url = jsUrl;
    if (tit != nil) {
        jsVC.title = tit;
    }
    [self.navigationController pushViewController:jsVC animated:YES];
}

- (void)headViewPush
{
    //tableBar内部跳转其他控制器
    self.tabBarController.selectedIndex = 1;
    UINavigationController *nav = self.tabBarController.viewControllers[1];
    UIViewController *vc = [nav.viewControllers firstObject];
//    if ([vc isKindOfClass:[ShopGoodsController class]] && [vc respondsToSelector:@selector(homePageForType)]) {
//        ShopGoodsController *shopvc = (ShopGoodsController *)vc;
//        shopvc.type = tag;
//        //调用选中控制器内部方法
////        [vc performSelector:@selector(homePageForType)];
//
//    }
    [self.tabBarController.view.layer transitionWithAnimType:TransitionAnimTypeReveal subType:TransitionSubtypesFromRight curve:TransitionCurveEaseOut duration:0.3f];
    [self.navigationController popToRootViewControllerAnimated:NO];
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return self.dataModel.data2.count +1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return 1;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    WeakSelf
    if (indexPath.section == 0) {
        XBTHomePageCell3 *cell3 =[tableView dequeueReusableCellWithIdentifier:@"DMHomePageCell3" forIndexPath:indexPath];
        [cell3 setMoreButtonClick:^{
            [weakSelf headViewPush];
        }];
        cell3.selectionStyle = UITableViewCellSelectionStyleNone;
        return cell3;
    }
//    else if (indexPath.section == (self.dataModel.data2.count +1)){
//        DMHomePageCell4 *cell4 = [tableView dequeueReusableCellWithIdentifier:@"DMHomePageCell4" forIndexPath:indexPath];
//        cell4.selectionStyle = UITableViewCellSelectionStyleNone;
//        return cell4;
//    }
    XBTHomePageCell2 *cell2 = [tableView dequeueReusableCellWithIdentifier:@"DMHomePageCell2" forIndexPath:indexPath];
    cell2.cellData = self.dataModel.data2[indexPath.section-1];
    cell2.selectionStyle = UITableViewCellSelectionStyleNone;
    return cell2;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    if (indexPath.section == 0 || (indexPath.section == self.dataModel.data2.count +1)) {
        return;
    }
    DMRegularController *regVC = [DMRegularController new];
    regVC.prdID = self.dataModel.data2[indexPath.section-1].id;
    regVC.titleString = self.dataModel.data2[indexPath.section-1].borrowTitle;
    [self.navigationController pushViewController:regVC animated:YES];
}

- (UIView *)tableView:(UITableView *)tableView viewForFooterInSection:(NSInteger)section
{
    return [UIView new];
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (indexPath.section == 0) {
        return 60;
    }
    CGFloat score = 400.0/220.0;
    return kScreenW/score;
}

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section
{
    return kHeightForSection;
}

- (CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section
{
    return CGFLOAT_MIN;
}

@end
