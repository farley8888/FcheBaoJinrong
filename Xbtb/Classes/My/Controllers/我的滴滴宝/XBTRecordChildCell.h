//
//  XBTRecordChildCell.h
//  CheBaoJinRong
//
//  Created by apple on 2018/6/1.
//  Copyright © 2018年 apple. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "XBTRecordChildModel.h"

@interface XBTRecordChildCell : UITableViewCell
@property (nonatomic, assign) NSInteger type;
@property (nonatomic, strong) XBTRecordChildModel *cellModel;

@end
