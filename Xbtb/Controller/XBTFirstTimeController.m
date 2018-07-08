//
//  DMFirstTimeController.m
//  SWWH
//
//  Created by 尚往文化 on 16/11/14.
//  Copyright © 2016年 cy. All rights reserved.
//

#import "XBTFirstTimeController.h"
#import "SelectVCTool.h"

@interface XBTFirstTimeController ()<UIScrollViewDelegate>

@property (nonatomic, strong) UIScrollView *scrollView;
@property (nonatomic, strong) UIPageControl *pageControl;

@end

@implementation XBTFirstTimeController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor whiteColor];
    
    [self setupUI];
}

- (void)setupUI
{
    NSInteger imageCount = 4;
    
    self.scrollView = [[UIScrollView alloc] initWithFrame:CGRectMake(0, 0, kScreenW, kScreenH)];
    self.scrollView.pagingEnabled = YES;
    self.scrollView.showsHorizontalScrollIndicator = NO;
    self.scrollView.bounces = NO;
    self.scrollView.delegate = self;
    [self.view addSubview:self.scrollView];
    self.scrollView.contentSize = CGSizeMake(kScreenW*imageCount, 0);
    
    NSArray *titles = @[@"重磅来袭\n邮币卡领域的头条直播",
                        @"公益活动\n巡回人文化公益",
                        @"交易拍卖\n文化藏品交易拍卖",
                        @"团队管理\n极致经济会员团队管理，全网交流"];
    for (int i = 0; i<imageCount; i++) {
        UIImageView *imageView = [[UIImageView alloc] initWithFrame:CGRectMake(kScreenW*i, 0, kScreenW, kScreenH)];
        imageView.image = [UIImage imageNamed:[NSString stringWithFormat:@"引导%zi", i+1]];
        imageView.contentMode = UIViewContentModeScaleAspectFill;
        [self.scrollView addSubview:imageView];
        
        UILabel *label = [[UILabel alloc] initWithFrame:CGRectMake(0, imageView.height-100, imageView.width, 100)];
        NSString *title = titles[i];
        label.textAlignment = NSTextAlignmentCenter;
        label.numberOfLines = 2;
        label.textColor = [UIColor grayColor];
        label.font = [UIFont systemFontOfSize:12];
        NSMutableAttributedString *mAtt = [[NSMutableAttributedString alloc] initWithString:title];
        NSRange range = [title rangeOfString:@"\n"];
        [mAtt addAttribute:NSFontAttributeName value:[UIFont systemFontOfSize:18] range:NSMakeRange(0, range.location)];
        [mAtt addAttribute:NSForegroundColorAttributeName value:[UIColor blackColor] range:NSMakeRange(0, range.location)];
        label.attributedText = mAtt;
        [imageView addSubview:label];
    }
    
    UIPageControl *pageControl = [[UIPageControl alloc] initWithFrame:CGRectMake(0, kScreenH-30, kScreenW, 34)];
    pageControl.pageIndicatorTintColor = [UIColor blackColor];
    pageControl.currentPageIndicatorTintColor = [UIColor redColor];
    pageControl.numberOfPages = imageCount;
    [self.view addSubview:pageControl];
    self.pageControl = pageControl;
    
    UIButton *skipBtn = [UIButton buttonWithType:UIButtonTypeRoundedRect];
//    [skipBtn setBackgroundImage:[UIImage imageNamed:@"立即体验"] forState:UIControlStateNormal];
    [skipBtn setTitle:@"立即体验" forState:UIControlStateNormal];
    [skipBtn setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
    skipBtn.titleLabel.font = [UIFont systemFontOfSize:18];
    skipBtn.layer.cornerRadius = 5;
//    skipBtn.layer.borderColor = kMenuColor.CGColor;
    skipBtn.layer.borderWidth = 1;
    skipBtn.frame = CGRectMake(kScreenW*(imageCount-1) + (kScreenW/2 - 148/2), pageControl.y- 80, 148, 34);
    skipBtn.backgroundColor = [UIColor clearColor];
    [skipBtn addTarget:self action:@selector(skip:) forControlEvents:UIControlEventTouchUpInside];
    [self.scrollView addSubview:skipBtn];
    
}

- (void)skip:(UIButton *)btn
{
    [NSUserDefaults saveBool:YES key:kNOFirstTimeKey];
    [NSUserDefaults saveObject:kVersion key:kVersionKey];
    
    [SelectVCTool selectVC];
}

- (void)scrollViewDidScroll:(UIScrollView *)scrollView
{
    CGFloat x = scrollView.contentOffset.x;
    NSInteger page = (x+kScreenW/2)/kScreenW;
    self.pageControl.currentPage = page;
}



@end
