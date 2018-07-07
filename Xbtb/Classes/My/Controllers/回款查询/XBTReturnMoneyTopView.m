//
//  DMReturnMoneyTopView.m
//  CheBaoJinRong
//
//  Created by apple on 2018/5/15.
//  Copyright © 2018年 apple. All rights reserved.
//

#import "XBTReturnMoneyTopView.h"

@interface XBTReturnMoneyTopView ()

@property (nonatomic, strong) UILabel *totaleLabel;
@property (nonatomic, strong) UILabel *mouthLabel;

@end

@implementation XBTReturnMoneyTopView

-(void)dealloc
{
    [kNotificationCenter removeObserver:self];
}

- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        [self setUpTopview];
        [self addNotion];
    }
    return self;
}

- (void)addNotion
{
    [kNotificationCenter addObserver:self selector:@selector(setTopValue:) name:kSetRetuBackTopView object:nil];
    
}

- (void)setTopValue:(NSNotification *)not
{
    DMLog(@"通知传值  -- %@",not.userInfo);
    self.totaleLabel.text = [NSString stringWithFormat:@"%@",not.userInfo[@"zds"]];
    self.mouthLabel.text = [NSString stringWithFormat:@"%@",not.userInfo[@"dyds"]];;
}

- (void)setUpTopview
{
    UIImageView *bgView = [[UIImageView alloc]init];
    UILabel *totalLabel = [[UILabel alloc]init];
    UILabel *thisMonthLabel = [[UILabel alloc]init];
    
    UILabel *totalNumberLab = [[UILabel alloc]init];
    UILabel *thisNumberLab = [[UILabel alloc]init];
    
    self.totaleLabel = totalNumberLab;
    self.mouthLabel = thisNumberLab;
    
    bgView.image = [UIImage imageNamed:@"bg_huikuanchaxun"];
    bgView.contentMode = UIViewContentModeScaleAspectFill;
    
    totalNumberLab.textColor = KColorFromRGB(0xffa500);
    thisNumberLab.textColor = KColorFromRGB(0xffa500);
    
    totalLabel.text = @"总待收(元):";
    thisMonthLabel.text = @"本月待收(元):";
    totalNumberLab.text = @"0.00";
    thisNumberLab.text = @"0.00";
    
    totalNumberLab.font = [UIFont systemFontOfSize:14.0];
    thisNumberLab.font = [UIFont systemFontOfSize:14.0];
    totalLabel.font = [UIFont systemFontOfSize:14.0];
    thisMonthLabel.font = [UIFont systemFontOfSize:14.0];
    
    totalLabel.textAlignment = NSTextAlignmentRight;
    thisMonthLabel.textAlignment = NSTextAlignmentRight;
    totalNumberLab.textAlignment = NSTextAlignmentLeft;
    thisNumberLab.textAlignment = NSTextAlignmentLeft;
    
    [self addSubview:bgView];
    [self addSubview:totalLabel];
    [self addSubview:thisMonthLabel];
    [self addSubview:totalNumberLab];
    [self addSubview:thisNumberLab];
    
    [bgView mas_makeConstraints:^(MASConstraintMaker *make) {
        
        make.top.equalTo(@0);
        make.left.equalTo(@0);
        make.right.equalTo(@0);
        make.bottom.equalTo(@0);
    }];
    
    [thisMonthLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        
        make.bottom.equalTo(@-5);
        make.left.equalTo(@5);
    }];
    
    [totalLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(@10);
        make.left.equalTo(@5);
        make.right.mas_equalTo(thisMonthLabel.mas_right);
        make.bottom.mas_equalTo(thisMonthLabel.mas_top);
        make.height.mas_equalTo(thisMonthLabel.mas_height);
    }];

    [totalNumberLab mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(totalLabel.mas_right).equalTo(@3);
        make.right.mas_lessThanOrEqualTo(@-3);
        make.centerY.mas_equalTo(totalLabel.mas_centerY);
    }];
    
    [thisNumberLab mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(thisMonthLabel.mas_top);
        make.bottom.mas_equalTo(thisMonthLabel.mas_bottom);
        make.left.mas_equalTo(thisMonthLabel.mas_right).equalTo(@3);
        make.right.mas_lessThanOrEqualTo(@-3);
    }];
}

@end
