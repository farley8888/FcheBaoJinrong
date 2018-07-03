//
//  DMLeftTabelViewcell.m
//  CheBaoJinRong
//
//  Created by apple on 2018/5/14.
//  Copyright © 2018年 apple. All rights reserved.
//

#import "DMLeftTabelViewcell.h"
#import "UIImageView+SD.h"

@interface DMLeftTabelViewcell ()
@property (weak, nonatomic) IBOutlet UIView *bkView;
@property (weak, nonatomic) IBOutlet UIImageView *imgView;
@property (weak, nonatomic) IBOutlet UIButton *nameBtn;
@property (weak, nonatomic) IBOutlet UIView *endView;
    
@end


@implementation DMLeftTabelViewcell

- (void)awakeFromNib {
    [super awakeFromNib];
    
    self.bkView.layer.cornerRadius = 10;
    self.bkView.clipsToBounds = YES;
    self.nameBtn.userInteractionEnabled = NO;
//    self.endView.backgroundColor = [UIColor colorWithRed:226/255.0 green:225/255.0 blue:224/255.0 alpha:1];
    
}

- (void)setCellModel:(List *)cellModel
{
    _cellModel = cellModel;
    
    [self.imgView imageWithUrlStr:[NSString stringWithFormat:@"%@%@",kAPI_URL,cellModel.activityImg] phImage:kMorentupian];
    [self.nameBtn setTitle:cellModel.activityName forState:UIControlStateNormal];
    if (self.type == 0) {  // 0: 进行中  1：已结束
        [self.nameBtn setBackgroundImage:[UIImage imageNamed:@"title_shouye"] forState:UIControlStateNormal];
//        self.endView.backgroundColor = [UIColor clearColor];
        self.endView.hidden = YES;
    }else{
        [self.nameBtn setBackgroundImage:[UIImage imageNamed:@"huise"] forState:UIControlStateNormal];
        self.endView.hidden = NO;
    }
}


@end
