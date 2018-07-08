//
//  XBTScreenRecordCell.m
//  CheBaoJinRong
//
//  Created by apple on 2018/5/31.
//  Copyright © 2018年 apple. All rights reserved.
//

#import "XBTScreenRecordCell.h"

@interface XBTScreenRecordCell ()
@property (weak, nonatomic) IBOutlet UILabel *titleLab;

@end


@implementation XBTScreenRecordCell

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
}

- (void)setTitleString:(NSString *)titleString
{
    _titleString = titleString;
    
    self.titleLab.text = titleString;
}

@end
