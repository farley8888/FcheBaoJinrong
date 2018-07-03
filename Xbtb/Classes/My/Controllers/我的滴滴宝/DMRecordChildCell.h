//
//  DMRecordChildCell.h
//  CheBaoJinRong
//
//  Created by apple on 2018/6/1.
//  Copyright © 2018年 apple. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "DMRecordChildModel.h"

@interface DMRecordChildCell : UITableViewCell
@property (nonatomic, assign) NSInteger type;
@property (nonatomic, strong) DMRecordChildModel *cellModel;

@end
