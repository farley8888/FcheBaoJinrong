//
//  HomeButton.m
//  SWWH
//
//  Created by 尚往文化 on 16/6/28.
//  Copyright © 2016年 YBing. All rights reserved.
//

#import "HomeButton.h"
#import "UIView+Extension.h"

@implementation HomeButton

- (void)layoutSubviews
{
    [super layoutSubviews];
    self.imageView.width = self.imageWidth?self.imageWidth:40;
    self.imageView.height = self.imageView.width;
    self.imageView.contentMode = UIViewContentModeScaleAspectFit;
    self.imageView.x = self.width/2 - self.imageView.width/2;
    self.imageView.y = self.height/2 - (self.imageView.height+20+3)/2;
    self.titleLabel.width = self.width;
    self.titleLabel.height = 20;
    self.titleLabel.y = CGRectGetMaxY(self.imageView.frame)+5;
    self.titleLabel.x = 0;
    
    
}

@end
