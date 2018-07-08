//
//  MessageDetialController.h
//  CheBaoJinRong
//
//  Created by apple on 2018/5/29.
//  Copyright © 2018年 apple. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "MessageChildModel.h"

@interface MessageDetialController : UIViewController

@property (nonatomic, strong) MessageChildModel *childModel;
@property (nonatomic, assign) NSInteger type;

@end
