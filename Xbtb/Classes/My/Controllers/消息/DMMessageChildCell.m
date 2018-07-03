//
//  DMMessageChildCell.m
//  CheBaoJinRong
//
//  Created by apple on 2018/5/29.
//  Copyright © 2018年 apple. All rights reserved.
//

#import "DMMessageChildCell.h"
#import "NSDate+DM.h"

@interface DMMessageChildCell ()
@property (weak, nonatomic) IBOutlet UILabel *titleLab;

@property (weak, nonatomic) IBOutlet UILabel *timeLab;

@end


@implementation DMMessageChildCell

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
}

- (void)setCellModel:(DMMessageChildModel *)cellModel
{
    _cellModel = cellModel;
    if (self.type == 1) {
        self.titleLab.text = cellModel.noticeTitle;
    }else{
        self.titleLab.text = cellModel.title;
    }
    
    self.timeLab.text = [NSDate stringWithTimeInterval:cellModel.createTime dateFormat:@"yyyy-MM-dd HH:mm:ss"];
}

@end
