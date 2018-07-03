//
//  DMRecordChildCell.m
//  CheBaoJinRong
//
//  Created by apple on 2018/6/1.
//  Copyright © 2018年 apple. All rights reserved.
//

#import "DMRecordChildCell.h"
#import "NSDate+DM.h"

@interface DMRecordChildCell ()

@property (weak, nonatomic) IBOutlet UILabel *timeLabel;
@property (weak, nonatomic) IBOutlet UILabel *amoutLabel;
@property (weak, nonatomic) IBOutlet UIButton *statebutton;

@end

@implementation DMRecordChildCell

- (void)awakeFromNib {
    [super awakeFromNib];
    self.statebutton.userInteractionEnabled = NO;

}

- (void)setType:(NSInteger)type
{
    _type = type;
    if (self.type == 1) {   //1： 投资   2：赎回
        self.statebutton.hidden = YES;
    }else{
        self.statebutton.hidden = NO;
        self.statebutton.layer.cornerRadius = self.statebutton.height / 2.0;
        self.statebutton.clipsToBounds = YES;
    }
}


- (void)setCellModel:(DMRecordChildModel *)cellModel
{
    _cellModel = cellModel;
    
    if (self.type == 1) {
        self.timeLabel.text = [NSDate stringWithTimeInterval:cellModel.investTime dateFormat:@"yyyy-MM-dd HH:mm:ss"];
        self.amoutLabel.text = [NSString stringWithFormat:@"%.2f",cellModel.investmoney];
    }else{
        self.timeLabel.text = [NSDate stringWithTimeInterval:cellModel.createTime dateFormat:@"yyyy-MM-dd HH:mm:ss"];
        self.amoutLabel.text = [NSString stringWithFormat:@"%.2f",cellModel.shmoney];
        [self.statebutton setTitle:cellModel.applyStatusString forState:UIControlStateNormal];
    }
}

@end
