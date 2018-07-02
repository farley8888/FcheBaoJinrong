//
//  DMNetErrorView.m
//  SWWH
//
//  Created by 尚往文化 on 16/8/19.
//  Copyright © 2016年 cy. All rights reserved.
//

#import "DMNetErrorView.h"
#import "UIView+Extension.h"

@implementation DMNetErrorView

- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        CGFloat w = 150;
        CGFloat h = 150;
        self.backgroundColor = [UIColor whiteColor];
        UIImageView *imgView = [[UIImageView alloc] initWithFrame:CGRectMake(self.width/2-w/2, self.height/2-h/2, w, h)];
        imgView.contentMode = UIViewContentModeScaleAspectFit;
        imgView.clipsToBounds = YES;
//        [imgView imageWithUrlStr:[UserManager sharedManager].appConfig.nonetworkPic phImage:nil];
        [self addSubview:imgView];
        imgView.userInteractionEnabled = YES;
        UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(tap)];
        [imgView addGestureRecognizer:tap];
    }
    return self;
}

- (instancetype)initWithFrame:(CGRect)frame againBlock:(void (^)())againBlock
{
    self = [self initWithFrame:frame];
    if (self) {
        self.againBlock = againBlock;
    }
    return self;
}

- (void)tap
{
    if (self.againBlock) {
        self.againBlock();
    }
}

@end
