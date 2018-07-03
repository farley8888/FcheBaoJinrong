//
//  DMShareFriendController.m
//  CheBaoJinRong
//
//  Created by apple on 2018/6/6.
//  Copyright © 2018年 apple. All rights reserved.
//

#import "DMShareFriendController.h"
#import "DMShareFriendCell1.h"
#import "DMShareFriendCell2.h"
#import "DMShareFriendCell3.h"
#import <UShareUI/UShareUI.h>
#import "DMShareCodeController.h"

@interface DMShareFriendController ()

@property (nonatomic, strong) NSArray *dataArray;

@end

@implementation DMShareFriendController

- (NSArray *)dataArray
{
    if (_dataArray == nil) {
        _dataArray = @[@"",@"",@"被邀请人首次出借1月标金额≥5000元，邀请人将获得现金30元＋20元现金券；被邀请人首次出借2月标金额≥5000元，邀请人将获得现金50元＋30元现金券；被邀请人首次出借3月标金额≥5000元，邀请人将获得现金80元＋60元现金券；被邀请人首次出借6月标金额≥5000元，邀请人将获得现金100元＋80元现金券。",@"被邀请人须通过邀请人的注册链接注册平台账户；",@"被邀请人注册后15天内需完成首次出借，否则邀请失效;",@"被邀请人首次单笔出借需≥5000元，出借期限需≥30天，方可有效；",@"被邀请人首次单笔出借需≥5000元，出借期限需≥30天，方可有效；",@"被邀请人首次出借生效后，邀请奖励即刻发放至邀请人账户；",@"严禁用户恶意刷单，一切通过不法手段获得的奖励，一经发现，将取消奖励的发放。"];
    }
    return _dataArray;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self setupUI];
}

- (void)setupUI
{
    self.navigationItem.title = @"邀请好友";
    self.tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    UITableView_RegisterFormNib(self.tableView, @"DMShareFriendCell1");
    UITableView_RegisterFormNib(self.tableView, @"DMShareFriendCell2");
    UITableView_RegisterFormNib(self.tableView, @"DMShareFriendCell3");
    UITableView_AutomaticDimension(self.tableView, 120);
}

- (void)showShareUI
{
    //显示分享面板
    WeakSelf
    [UMSocialUIManager setPreDefinePlatforms:@[@(UMSocialPlatformType_WechatSession),@(UMSocialPlatformType_WechatTimeLine),@(UMSocialPlatformType_QQ),@(UMSocialPlatformType_Qzone)]];
    [UMSocialUIManager showShareMenuViewInWindowWithPlatformSelectionBlock:^(UMSocialPlatformType platformType, NSDictionary *userInfo) {
        // 根据获取的platformType确定所选平台进行下一步操作
        [weakSelf  shareWebPageToPlatformType:platformType];
    }];
}

- (void)shareWebPageToPlatformType:(UMSocialPlatformType)platformType
{
    //创建分享消息对象
    UMSocialMessageObject *messageObject = [UMSocialMessageObject messageObject];
    
    //创建网页内容对象
    UIImage *img = [UIImage imageNamed:@"ic_launcher"];
    UMShareWebpageObject *shareObject = [UMShareWebpageObject shareObjectWithTitle:@"鑫贝通宝-人脉总动员，邀请送现金红包，可提现！" descr:@"邀请好友注册，百元现金红包+现金券壕礼送不停，邀请多多，现金多多，可提至银行卡。" thumImage:img];
    //设置网页地址
    shareObject.webpageUrl = [NSString stringWithFormat:@"http://www.chebaojr.com/wechat/regIndex.html?tel=%@",[UserManager sharedManager].user.userName];
    
    //分享消息对象设置分享内容对象
    messageObject.shareObject = shareObject;
    
    //调用分享接口
    [[UMSocialManager defaultManager] shareToPlatform:platformType messageObject:messageObject currentViewController:self completion:^(id data, NSError *error) {
        if (error) {
            UMSocialLogInfo(@"************Share fail with error %@*********",error);
            [MBProgressHUD showSuccess:@"分享失败"];
        }else{
            [MBProgressHUD showSuccess:@"分享成功"];
        }
    }];
}

- (void)shareCode
{
    DMShareCodeController *srVC = [DMShareCodeController new];
    srVC.modalPresentationStyle = UIModalPresentationOverCurrentContext;
    [self.navigationController presentViewController:srVC animated:YES completion:nil];
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
    UITableViewCell *cell = nil;
    if(indexPath.row == 0){
        DMShareFriendCell1 *cell1 = [tableView dequeueReusableCellWithIdentifier:@"DMShareFriendCell1" forIndexPath:indexPath];
        cell = cell1;
    }else if (indexPath.row == 1){
        DMShareFriendCell2 *cell2 = [tableView dequeueReusableCellWithIdentifier:@"DMShareFriendCell2" forIndexPath:indexPath];
        WeakSelf
        [cell2 setShareURLBlock:^{
            [weakSelf showShareUI];
        }];
        [cell2 setShareCodeBlock:^{
            [weakSelf shareCode];
        }];
        
        cell = cell2;
    }else{
        DMShareFriendCell3 *cell3 = [tableView dequeueReusableCellWithIdentifier:@"DMShareFriendCell3" forIndexPath:indexPath];
        cell3.detiLab.text = self.dataArray[indexPath.row];
        cell = cell3;
    }
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    return cell;
}


- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section
{
    return CGFLOAT_MIN;
}

@end
