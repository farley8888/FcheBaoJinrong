//
//  MyHeadView.m
//  XYG
//
//  Created by 张殿明 on 2017/11/14.
//  Copyright © 2017年 Mac. All rights reserved.
//

#import "MyHeadView.h"
#import "HomeButton.h"
#import "UIImageView+SD.h"
#import "UIImage+DMIconFont.h"
#import "MyCell.h"
#import "UIView+DMGradientColor.h"
//#import "UIImage+Cut.h"

@interface MyHeadView()

@property (nonatomic,strong) NSArray<NSDictionary *> *headImageTitleArray;
/**  待收利息  **/
@property (weak, nonatomic) IBOutlet UILabel *incomeLabel;
/**  累计利息  **/
@property (weak, nonatomic) IBOutlet UILabel *cumulativeIncome;
/**  提现按钮  **/
@property (weak, nonatomic) IBOutlet UIButton *withdrawButton;
/**  充值按钮  **/
@property (weak, nonatomic) IBOutlet UIButton *rechargeButton;
/**  总资产  **/
@property (weak, nonatomic) IBOutlet UILabel *totalNumberLabel;
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *safeTopViewLay;
/**  是否可见按钮  **/
@property (weak, nonatomic) IBOutlet UIButton *canSeeButton;

@property (weak, nonatomic) IBOutlet UILabel *topLabel;
@property (weak, nonatomic) IBOutlet UILabel *leftLab;
@property (weak, nonatomic) IBOutlet UIView *bottomView;
@property (weak, nonatomic) IBOutlet UILabel *canUseMoneyLabel;

@end

@implementation MyHeadView

+ (MyHeadView *)myHeadView
{
    MyHeadView *view = [[UINib nibWithNibName:@"MyHeadView" bundle:nil] instantiateWithOwner:self options:nil].lastObject;
    
    [view setHeadSubView];
    return view;
}

- (void)setType:(MyHeadViewOrMyDiDiBaoType)type
{
    _type = type;
    if (type == MyDiDiBaoHeadViewType) {
        self.topLabel.text = @"今日预计利息(元)";
        self.leftLab.text = @"总金额(元)";
    }
}

- (void)awakeFromNib
{
    [super awakeFromNib];
    [self setHeadSubView];
}

- (void)setHeadSubView
{
    self.safeTopViewLay.constant = 15+SafeAreaTopHeight;
    [self.withdrawButton gradientColorTransverse:YES vertical:NO width:80 stratColor:KColorFromRGB(0x46d7ff) endColor:KColorFromRGB(0x1e96ff)];
    [self.rechargeButton gradientColorTransverse:YES vertical:NO width:80 stratColor:KColorFromRGB(0xff9d38) endColor:KColorFromRGB(0xff7933)];

//    self.withdrawButton.layer.cornerRadius = self.withdrawButton.height;
//    self.rechargeButton.layer.cornerRadius = self.rechargeButton.height;
}

- (HomeButton *)getHomeButtonWithTag:(NSInteger)tag
{
    HomeButton *button = [self viewWithTag:tag];
    return button;
}

- (void)setIsCanSee:(BOOL)isCanSee
{
    _isCanSee = isCanSee;
    self.canSeeButton.selected = isCanSee;
    [self setMyProfitVisual:isCanSee];
}

- (void)setHeadModel:(MyModel *)headModel
{
    _headModel = headModel;

    [self setMyProfitVisual:self.isCanSee];
}

- (IBAction)withdrawClick:(UIButton *)sender {
    if (self.withdrawAndRechBlock) {
        self.withdrawAndRechBlock(sender.tag - 1200);
    }
}

- (IBAction)rechargeButtonClick:(UIButton *)sender {
    if (self.withdrawAndRechBlock) {
        self.withdrawAndRechBlock(sender.tag - 1200);
    }
}

- (IBAction)secrecyButtonClick:(UIButton *)sender {
    
    sender.selected = !sender.selected;
    [self setMyProfitVisual:sender.selected];
    if (self.type == MyHeadViewType) {
        [NSUserDefaults saveBool:sender.selected key:kMyProfitVisual];
        
    }else{
        [NSUserDefaults saveBool:sender.selected key:kMyDidiBaoVisual];
    }
    self.isCanSee = sender.selected;
//    if (self.headHomeButtonClick) {
//        self.headHomeButtonClick(sender.selected);
//    }
    [self setMyProfitVisual:sender.selected];
}

- (void)setMyProfitVisual:(BOOL)isCan
{
    if (isCan == YES) {
        self.totalNumberLabel.text = @"＊＊＊";
        self.incomeLabel.text = @"＊＊＊";
        self.cumulativeIncome.text = @"＊＊＊";
        self.canUseMoneyLabel.text = @"＊＊＊";
    }else{
        
        self.totalNumberLabel.text = self.headModel.total1 == 0?@"0.0":[NSString stringWithFormat:@"%.2f",self.headModel.total1];
        self.incomeLabel.text = self.headModel.total3 == 0?@"0.0":[NSString stringWithFormat:@"%.2f",self.headModel.total3];
        self.cumulativeIncome.text = self.headModel.total2 == 0?@"0.0":[NSString stringWithFormat:@"%.2f",self.headModel.total2];
        self.canUseMoneyLabel.text = self.headModel.usableAmount == nil?@"0.0":self.headModel.usableAmount;
    }
}

@end
