//
//  DMMyBankCardController.m
//  CheBaoJinRong
//
//  Created by apple on 2018/5/19.
//  Copyright © 2018年 apple. All rights reserved.
//

#import "DMMyBankCardController.h"
#import "DMNavigationBar.h"
#import "DMMyBankCardModel.h"

@interface DMMyBankCardController ()
@property (weak, nonatomic) IBOutlet UIView *bkView;
@property (weak, nonatomic) IBOutlet UIImageView *bankImageView;
@property (weak, nonatomic) IBOutlet UILabel *bankName;
@property (weak, nonatomic) IBOutlet UILabel *userName;
@property (weak, nonatomic) IBOutlet UILabel *bankNumber;

@end

@implementation DMMyBankCardController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.bkView.layer.cornerRadius = 10;
    self.bkView.clipsToBounds = YES;
    [self setNAV];
    [self loadBankCard];
    
}

- (void)setNAV
{
    self.navigationItem.title = @"我的银行卡";
    [self.navigationController.navigationBar setTranslucent:YES];
    [self dm_setStatusBarStyle:UIStatusBarStyleLightContent];
    [self dm_setNavBarBarTintColor:[UIColor clearColor]];
    [self dm_setNavBarShadowImageHidden:YES];
    [self dm_setNavBarTitleColor:[UIColor whiteColor]];
    [self dm_setNavBarTintColor:[UIColor whiteColor]];
    [self dm_setNavBarBackgroundAlpha:0];
}

- (void)loadBankCard
{
    WeakSelf
    [YBHttpTool postDataDifference:@"selectBankCard" params:nil success:^(id  _Nullable obj) {
        if (obj!= nil) {
            DMStateModel *stateModel = [DMStateModel mj_objectWithKeyValues:obj[@"state"]];
            if (stateModel.status == ResultStatusSuccess) {
                NSMutableArray *modelArray = [DMMyBankCardModel mj_objectArrayWithKeyValuesArray:obj[@"data"]];
                DMMyBankCardModel *model = [modelArray firstObject];
                weakSelf.bankName.text = model.bankName;
                NSString *cardNum = [model.bankCardNo stringByReplacingCharactersInRange:NSMakeRange(4, model.bankCardNo.length - 8) withString:@" **** **** **** "];
                weakSelf.bankNumber.text = cardNum;
                NSString *userName = [model.realName stringByReplacingCharactersInRange:NSMakeRange(1, model.realName.length -1) withString:@"**"];
                weakSelf.userName.text = [NSString stringWithFormat:@"开户名:%@",userName];
            }
        }
    } failure:^(NSError * _Nullable error) {
        
    }];
    
}


@end
