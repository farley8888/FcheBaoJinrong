//
//  LotOfViewTableViewCell.h
//  CheBaoJinRong
//
//  Created by apple on 2018/5/16.
//  Copyright © 2018年 apple. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "XBTMyHongBaoModel.h"
#import "MyCouponModel.h"

@interface LotOfViewTableViewCell : UITableViewCell

@property (nonatomic, strong) XBTMyHongBaoModel *cellModel;
@property (nonatomic, strong) MyCouponModel *coupModel;
@property (weak, nonatomic) IBOutlet UILabel *useLabel;
@property (weak, nonatomic) IBOutlet UIImageView *hongbaoImage;

@end
