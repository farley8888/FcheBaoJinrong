//
//  DMSettingCell.h
//  CheBaoJinRong
//
//  Created by apple on 2018/5/17.
//  Copyright © 2018年 apple. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface XBTSettingCell : UITableViewCell
@property (weak, nonatomic) IBOutlet UIImageView *imageViewTitel;
@property (weak, nonatomic) IBOutlet UILabel *nameLabel;
@property (nonatomic, assign) NSInteger index;
@property (weak, nonatomic) IBOutlet UILabel *rightLabel;

@property (nonatomic, copy) void(^cellBlock)();

@end
