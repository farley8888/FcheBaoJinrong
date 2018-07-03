//
//  DMLotOfViewTableViewCell.h
//  CheBaoJinRong
//
//  Created by apple on 2018/5/16.
//  Copyright © 2018年 apple. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "DMMyHongBaoModel.h"
#import "DMMyCouponModel.h"

@interface DMLotOfViewTableViewCell : UITableViewCell

@property (nonatomic, strong) DMMyHongBaoModel *cellModel;
@property (nonatomic, strong) DMMyCouponModel *coupModel;
@property (weak, nonatomic) IBOutlet UILabel *useLabel;
@property (weak, nonatomic) IBOutlet UIImageView *hongbaoImage;

@end
