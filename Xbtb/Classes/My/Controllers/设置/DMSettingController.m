//
//  DMSettingController.m
//  CheBaoJinRong
//
//  Created by apple on 2018/5/15.
//  Copyright © 2018年 apple. All rights reserved.
//

#import "DMSettingController.h"
#import "XBTSettingCell.h"
#import "DMRealNameAuthenticationVController.h"  //实名认证
#import "DMBankCardController.h"                 //银行卡
#import "XBTChangeLonginPWController.h"           //修改登录密码
#import "XBTLogOutView.h"                         //退出登录view
#import "XBTMyBankCardController.h"               //我的银行卡
#import "DMGestureLockViewController.h"          //手势密码
#import "XBTNavigationController.h"
#import "LonginController.h"
#import "UIAlertView+Block.h"


@interface DMSettingController ()

@property(nonatomic,strong)NSArray<NSArray<NSDictionary *> *> *titleArray;
@property (nonatomic, assign) CGFloat caches;

@end

@implementation DMSettingController

-(NSArray<NSArray<NSDictionary *> *> *)titleArray
{
    if (_titleArray == nil) {
        NSDictionary *infoDictionary = [[NSBundle mainBundle] infoDictionary];
        NSString *appCurVersion = [infoDictionary objectForKey:@"CFBundleShortVersionString"];
        NSArray *arr = @[@[@{@"title":@"实名制",@"img":@"shimingzhi_my",@"rit":@"未认证"},
                           @{@"title":@"我的银行卡",@"img":@"yinhangka",@"rit":@""},
                           @{@"title":@"登录密码",@"img":@"denglumima",@"rit":@"去修改"},
                           @{@"title":@"交易密码",@"img":@"jiaoyimima",@"rit":@"去设置"},
                           @{@"title":@"手势密码",@"img":@"shoushimima",@"rit":@""},
                           @{@"title":@"手势密码",@"img":@"shoushimima",@"rit":@"去设置"}],
                         @[@{@"title":@"当前版本",@"img":@"banben",@"rit":[NSString stringWithFormat:@"V%@", appCurVersion]},
                           @{@"title":@"清除缓存",@"img":@"qingchu",@"rit":@"0.0M"}]];
        _titleArray = arr;
    }
    return _titleArray;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self setUI];
    
    self.caches = [self folderSizeAtPath:[NSSearchPathForDirectoriesInDomains(NSCachesDirectory, NSUserDomainMask, YES) lastObject]];
}
    
- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    [self.tableView reloadData];
}
    

- (void)setUI
{
    self.navigationItem.title = @"设置";
    UITableView_RegisterFormNib(self.tableView, @"DMSettingCell");
    //    UITableView_AutomaticDimension(self.tableView, 80);
}

- (void)pushGesVC
{
    DMGestureLockViewController *lockVC = [DMGestureLockViewController new];
    [self.navigationController pushViewController:lockVC animated:YES];
}

- (void)logOut
{
    UIAlertController *alert = [UIAlertController alertControllerWithTitle:@"温馨提示" message:@"是否确定退出登录？" preferredStyle:UIAlertControllerStyleAlert];
    UIAlertAction *cancelAction = [UIAlertAction actionWithTitle:@"取消" style:UIAlertActionStyleCancel handler:^(UIAlertAction * _Nonnull action) {
        
    }];
    
    UIAlertAction *confirmAction = [UIAlertAction actionWithTitle:@"确定" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
        [kNotificationCenter postNotificationName:kLogoutNotification object:nil];
    }];
    
    [alert addAction:cancelAction];
    [alert addAction:confirmAction];
    [self.navigationController presentViewController:alert animated:YES completion:nil];
}
#pragma mark - 计算、清理缓存
//遍历文件夹获得文件夹大小，返回多少M
- (float ) folderSizeAtPath:(NSString*) folderPath{
    
    NSFileManager* manager = [NSFileManager   defaultManager];
    if (![manager  fileExistsAtPath:folderPath]) return 0;
    NSEnumerator *childFilesEnumerator = [[manager subpathsAtPath:folderPath] objectEnumerator];
    NSString* fileName;
    long long folderSize = 0;
    while ((fileName = [childFilesEnumerator nextObject]) != nil){
        NSString* fileAbsolutePath = [folderPath stringByAppendingPathComponent:fileName];
        folderSize += [self fileSizeAtPath:fileAbsolutePath];
    }
    return folderSize/(1024.0*1024.0);
}

- (long long) fileSizeAtPath:(NSString*) filePath{
    
    NSFileManager* manager = [NSFileManager defaultManager];
    
    if ([manager fileExistsAtPath:filePath]){
        
        return [[manager attributesOfItemAtPath:filePath error:nil]  fileSize];
    }
    return 0;
}

-(void)clearFile
{
    NSString * cachPath = [NSSearchPathForDirectoriesInDomains (NSCachesDirectory , NSUserDomainMask , YES ) firstObject];
    
    NSArray *files = [[NSFileManager defaultManager] subpathsAtPath :cachPath];
    
    DMLog(@"cachpath = %@",cachPath);
    
    for ( NSString *p in files) {
        
        NSError *error = nil ;
        
        NSString *path = [cachPath stringByAppendingPathComponent:p];
        
        if ([[NSFileManager defaultManager] fileExistsAtPath:path]) {
            
            [[NSFileManager defaultManager] removeItemAtPath :path error :&error];
        }
    }
    [ self performSelectorOnMainThread : @selector (clearCachSuccess) withObject : nil waitUntilDone : YES ];
}
-(void)clearCachSuccess
{
    DMLog(@"清理成功");
    self.caches = [self folderSizeAtPath:[NSSearchPathForDirectoriesInDomains(NSCachesDirectory, NSUserDomainMask, YES) lastObject]];
    [self.tableView reloadRowsAtIndexPaths:@[[NSIndexPath indexPathForRow:1 inSection:1]] withRowAnimation:UITableViewRowAnimationNone];
}

#pragma mark - TableViewDelegate
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return self.titleArray.count;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return self.titleArray[section].count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    XBTSettingCell *setCell = [tableView dequeueReusableCellWithIdentifier:@"DMSettingCell" forIndexPath:indexPath];
    setCell.nameLabel.text = self.titleArray[indexPath.section][indexPath.row][@"title"];
    setCell.imageViewTitel.image = [UIImage imageNamed:self.titleArray[indexPath.section][indexPath.row][@"img"]];
    setCell.index = indexPath.row;
    setCell.rightLabel.text = self.titleArray[indexPath.section][indexPath.row][@"rit"];
    if (indexPath.section == 0) {
        UserManager *manger = [UserManager sharedManager];
        if (indexPath.row == 0 ) {
            if (manger.user.realName.length != 0) {
                setCell.rightLabel.textColor = KColorFromRGB(0xaff500);
                setCell.rightLabel.text = @"已认证";
            }
        }else if(indexPath.row == 3){
            
            setCell.rightLabel.text = manger.user.payPwd ? @"去修改":@"去设置";
        }
    }
    if (indexPath.section == 1) {
        setCell.accessoryType = UITableViewCellAccessoryNone;
        if (indexPath.row == 1) {
            setCell.rightLabel.text = [NSString stringWithFormat:@"%.1fM",self.caches];
        }
    }
    WeakSelf
    [setCell setCellBlock:^{
        [weakSelf alertMessage];
    }];
    
    return setCell;
}

- (void)alertMessage
{
    WeakSelf
    [[UIAlertView alertWithTitle:@"温馨提示" message:@"您还未设置手势密码，请设置后在开启" buttonIndex:^(NSInteger index) {
        if (index == 1) {
            [weakSelf pushGesVC];
        }
    } cancelButtonTitle:@"取消" otherButtonTitles:@"去设置"] show];
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    UIViewController *vc = nil;
    if (indexPath.section == 0) {
        if (indexPath.row == 0) {
            DMRealNameAuthenticationVController *raVC = [DMRealNameAuthenticationVController new];
            vc = raVC;
        }else if (indexPath.row == 1){
            
            if ([UserManager sharedManager].user.bankCardNo.length == 0) {
                DMBankCardController *bcVC = [DMBankCardController new];
                vc = bcVC;
            }else{
                XBTMyBankCardController *mbVC = [XBTMyBankCardController new];
                vc = mbVC;
            }
            
        }else if (indexPath.row == 2){
            XBTChangeLonginPWController *clVC = [XBTChangeLonginPWController new];
            clVC.type = 1;
            vc = clVC;
        }else if (indexPath.row == 3){
            UserManager *manger = [UserManager sharedManager];
            if (manger.user.payPwd) {
                XBTChangeLonginPWController *ctVC = [XBTChangeLonginPWController new];
                ctVC.type = 2;
                vc = ctVC;
            }else{
                DMRealNameAuthenticationVController *raVC = [DMRealNameAuthenticationVController new];
                raVC.type = TransactionPassWord;
                vc = raVC;
            }
        }else if (indexPath.row == 5){
            DMGestureLockViewController *lockVC = [DMGestureLockViewController new];
            vc = lockVC;
        }
    }else{
        if (indexPath.row == 1) {
            //清除缓存
            [self clearFile];
        }
    }
    if (vc == nil) {
        return;
    }
    [self.navigationController pushViewController:vc animated:YES];
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 60;
}

- (UIView *)tableView:(UITableView *)tableView viewForFooterInSection:(NSInteger)section
{
    XBTLogOutView *logout = [XBTLogOutView logoutView];
    WeakSelf
    [logout setLogoutBlock:^{
        [weakSelf logOut];
    }];
    return section == 0?[UIView new]:logout;
}

- (CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section
{
    return section == 0?CGFLOAT_MIN:80;
}


@end
