//
//  DMMyDidiCell.h
//  CheBaoJinRong
//
//  Created by apple on 2018/5/15.
//  Copyright © 2018年 apple. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface XBTMyDidiCell : UITableViewCell

@property (nonatomic, copy) void(^cellButtonClick)(NSInteger tag);

@end
