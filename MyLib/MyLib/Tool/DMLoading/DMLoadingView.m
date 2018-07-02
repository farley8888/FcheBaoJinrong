//
//  DMLoadingView.m
//  SWWH
//
//  Created by 尚往文化 on 16/8/10.
//  Copyright © 2016年 cy. All rights reserved.
//

#import "DMLoadingView.h"
#import "UIView+Extension.h"

@implementation DMLoadingView

- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        self.backgroundColor = [UIColor whiteColor];
        UIImageView *imgView = [[UIImageView alloc] initWithFrame:self.bounds];
        imgView.width = 100;
        imgView.height = 100;
        imgView.center = self.center;
        imgView.y = self.center.y-100;
        imgView.contentMode = UIViewContentModeScaleAspectFit;
        imgView.clipsToBounds = YES;
        [self addSubview:imgView];
    }
    return self;
}

@end
