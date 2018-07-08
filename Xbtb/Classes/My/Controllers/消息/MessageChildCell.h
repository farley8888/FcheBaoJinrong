//
//  MessageChildCell.h
//  CheBaoJinRong
//
//  Created by apple on 2018/5/29.
//  Copyright © 2018年 apple. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "MessageChildModel.h"

@interface MessageChildCell : UITableViewCell

@property (nonatomic, strong) MessageChildModel *cellModel;

@property (nonatomic, assign) NSInteger type;  //1：平台公告  2：媒体报道

@end
