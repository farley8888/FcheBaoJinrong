//
//  DMDidiDetialCell.m
//  CheBaoJinRong
//
//  Created by apple on 2018/5/22.
//  Copyright © 2018年 apple. All rights reserved.
//

#import "DMDidiDetialCell.h"
#import "HomeButton.h"

@interface DMDidiDetialCell ()
@property (weak, nonatomic) IBOutlet UIView *bkView;
@end


@implementation DMDidiDetialCell

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
    
    for (int i = 0; i < 3; i++) {
        HomeButton *btn = [self viewWithTag:1700 + i];
        btn.titleLabel.textAlignment = NSTextAlignmentCenter;
        btn.userInteractionEnabled = NO;
    }
    self.bkView.layer.cornerRadius = 5;
    self.bkView.clipsToBounds = YES;
    self.bkView.backgroundColor = kColor(254, 251, 247);
}

@end
