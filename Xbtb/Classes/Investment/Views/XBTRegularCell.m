//
//  XBTRegularCell.m
//  CheBaoJinRong
//
//  Created by apple on 2018/5/28.
//  Copyright © 2018年 apple. All rights reserved.
//

#import "XBTRegularCell.h"

@interface XBTRegularCell()
@property (weak, nonatomic) IBOutlet UIView *detialBKView;

@end

@implementation XBTRegularCell

- (void)awakeFromNib {
    [super awakeFromNib];

    self.detialBKView.backgroundColor = kColor(254, 251, 247);
    self.detialBKView.layer.cornerRadius = 5;
    self.detialBKView.clipsToBounds = YES;
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
