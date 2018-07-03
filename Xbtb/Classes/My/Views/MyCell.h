//
//  MyCell.h
//  XYG
//
//  Created by 张殿明 on 2017/11/14.
//  Copyright © 2017年 Mac. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface MyCell : UITableViewCell
@property (weak, nonatomic) IBOutlet UILabel *canUseLabel;
@property (nonatomic, copy) void(^buttonClickBlock)(NSInteger tag);

@end
