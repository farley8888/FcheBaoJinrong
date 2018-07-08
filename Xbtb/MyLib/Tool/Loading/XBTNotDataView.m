//
//  XBTNotDataView.m
//  SWWH
//
//  Created by 尚往文化 on 16/8/13.
//  Copyright © 2016年 cy. All rights reserved.
//

#import "XBTNotDataView.h"
#import "UIView+Extension.h"

@implementation XBTNotDataView

- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        CGFloat w = 150;
        CGFloat h = 150;
        self.backgroundColor = [UIColor whiteColor];
        UIImageView *imgView = [[UIImageView alloc] initWithFrame:CGRectMake(self.width/2-w/2, self.height/2-h/2 -80, w, h)];
        imgView.contentMode = UIViewContentModeScaleAspectFit;
        imgView.clipsToBounds = YES;
//        [imgView imageWithUrlStr:[UserManager sharedManager].appConfig.nocontentPic phImage:nil];
        imgView.image = [UIImage imageNamed:@"notData"];
        [self addSubview:imgView];
        UILabel *lab = [[UILabel alloc]init];
        [self addSubview:lab];
        lab.text = @"暂无数据";
        lab.textColor = [UIColor darkGrayColor];
        lab.font = [UIFont systemFontOfSize:16.0f];
        lab.translatesAutoresizingMaskIntoConstraints = NO;
        [lab.topAnchor constraintEqualToAnchor:imgView.bottomAnchor].active = YES;
        [lab.centerXAnchor constraintEqualToAnchor:self.centerXAnchor].active = YES;
        
    }
    return self;
}

@end
