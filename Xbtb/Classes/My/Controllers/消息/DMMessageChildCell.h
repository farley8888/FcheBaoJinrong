//
//  DMMessageChildCell.h
//  CheBaoJinRong
//
//  Created by apple on 2018/5/29.
//  Copyright © 2018年 apple. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "DMMessageChildModel.h"

@interface DMMessageChildCell : UITableViewCell

@property (nonatomic, strong) DMMessageChildModel *cellModel;

@property (nonatomic, assign) NSInteger type;  //1：平台公告  2：媒体报道

@end
