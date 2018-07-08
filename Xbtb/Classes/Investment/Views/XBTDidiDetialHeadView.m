//
//  XBTDidiDetialHeadView.m
//  CheBaoJinRong
//
//  Created by apple on 2018/5/28.
//  Copyright © 2018年 apple. All rights reserved.
//

#import "XBTDidiDetialHeadView.h"
#import "XBTCycleProgressView.h"
#import "NSDate+XBT.h"

@interface XBTDidiDetialHeadView ()

@property (weak, nonatomic) IBOutlet XBTCycleProgressView *progressView;
@property (weak, nonatomic) IBOutlet UILabel *interestRate;
@property (weak, nonatomic) IBOutlet UILabel *amoutLabel;
@property (weak, nonatomic) IBOutlet UILabel *characteristic;
@property (weak, nonatomic) IBOutlet UILabel *top1Label;
@property (weak, nonatomic) IBOutlet UILabel *top2Label;
@property (weak, nonatomic) IBOutlet UILabel *top3Label;

//@property (nonatomic, strong) CADisplayLink *displayLinkTimer;
@property (nonatomic, assign) NSInteger secondTime;


@end
@implementation XBTDidiDetialHeadView

+ (XBTDidiDetialHeadView *)headView
{
    XBTDidiDetialHeadView *headView = [[UINib nibWithNibName:@"XBTDidiDetialHeadView" bundle:nil]instantiateWithOwner:self options:nil].lastObject;
    [headView setupUI];
    return headView;
}

//- (CADisplayLink *)displayLinkTimer
//{
//    if (_displayLinkTimer == nil) {
//        _displayLinkTimer = [CADisplayLink displayLinkWithTarget:self selector:@selector(timer:)];
//        _displayLinkTimer.frameInterval = 60;
//        [_displayLinkTimer addToRunLoop:[NSRunLoop currentRunLoop] forMode:NSRunLoopCommonModes];
//    }
//    return _displayLinkTimer;
//}

- (void)setupUI
{
    self.progressView.progress = 0.5;
    self.progressView.mainColor = kColor(236, 136, 57);
    self.progressView.line_width = 8;
    self.progressView.fillColor = [UIColor groupTableViewBackgroundColor];
    self.progressView.scareString = @"7.8%+2%";
}

//- (void)timer:(CADisplayLink*)timer
//{
//    self.secondTime--;
//    [self getDetailTimeWithTimestamp:self.secondTime];
//    if (self.secondTime <= 0) {
//        [timer invalidate];
//        timer = nil;
//        self.displayLinkTimer = nil;
//        self.top3Label.text = [NSString stringWithFormat:@"剩0天0时0分0秒"];
//        // 执行block回调
//        self.timerStopBlock();
//    }
//}

- (void)setRegularModel:(RegularModel *)regularModel
{
    _regularModel = regularModel;
    if (regularModel.deadlineType == 1) {
        self.top1Label.text = [NSString stringWithFormat:@"%ld天",regularModel.deadline];
    }else if (regularModel.deadlineType == 2){
        self.top1Label.text = [NSString stringWithFormat:@"%ld月",regularModel.deadline];
    }
    
    if ([regularModel.borrowTitle containsString:@"新手标"]) {
        self.progressView.scareString = [NSString stringWithFormat:@"%.1f%%+3%%",(self.regularModel.annualRate - 3.0)];
    }else{
        self.progressView.scareString = [NSString stringWithFormat:@"%.1f%%+1%%",(self.regularModel.annualRate - 1.0)];
    }
    
    self.characteristic.text = @"总金额";
    
    self.top2Label.text = [NSString stringWithFormat:@"%.2f元",regularModel.borrowAmount - regularModel.hasBorrowAmount];
    self.secondTime = regularModel.remainTime;
    self.top3Label.text = [NSString stringWithFormat:@"%.2f",regularModel.borrowAmount];
//    if (regularModel.remainTime > 0) {
//        [self setUPTimer];
//    }else{
//        self.top3Label.text = [NSDate stringWithTimeInterval:regularModel.fullTime dateFormat:@"yyyy-MM-dd"];
//    }
    
    self.progressView.progress = regularModel.hasBorrowAmount/regularModel.borrowAmount * 1.0;
}

- (void)setUPTimer
{
//    if (self.displayLinkTimer) {
//
//    }
}

- (void)getDetailTimeWithTimestamp:(NSInteger)timestamp{
    NSInteger ms = timestamp;
    NSInteger ss = 1;
    NSInteger mi = ss * 60;
    NSInteger hh = mi * 60;
    NSInteger dd = hh * 24;
    
    // 剩余的
    NSInteger day = ms / dd;// 天
    NSInteger hour = (ms - day *dd) / hh;// 时
    NSInteger minute = (ms - day * dd - hour * hh) / mi;// 分
    NSInteger second = (ms - day *dd - hour * hh - minute * mi) / ss;// 秒
    //    NSLog(@"%zd日:%zd时:%zd分:%zd秒",day,hour,minute,second);
    
    self.top3Label.text = [NSString stringWithFormat:@"剩%zd天%zd时%zd分%zd秒",day,hour,minute,second];
}

- (void)setType:(HeadViewType)type
{
    if (type == RegularHeadView) {
        self.interestRate.text = @"出借期限";
        self.amoutLabel.text = @"剩余金额";
        self.characteristic.text = @"出借总额";
    }else{
        self.interestRate.text = @"基础利率";
        self.amoutLabel.text = @"起投金额";
        self.characteristic.text = @"出借总额";
    }
}

@end
