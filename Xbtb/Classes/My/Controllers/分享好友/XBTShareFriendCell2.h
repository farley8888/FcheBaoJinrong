//
//  XBTShareFriendCell2.h
//  CheBaoJinRong
//
//  Created by apple on 2018/6/7.
//  Copyright © 2018年 apple. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface XBTShareFriendCell2 : UITableViewCell

@property (nonatomic, copy) void(^shareURLBlock)();
@property (nonatomic, copy) void(^shareCodeBlock)();

@end
