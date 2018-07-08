//
//  XBTInvestmentCell.h
//  CheBaoJinRong
//
//  Created by apple on 2018/5/14.
//  Copyright © 2018年 apple. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "HomePageModel.h"

typedef NS_ENUM(NSInteger, CellType){
    InvesMentType,
    SellOutType
};

@interface XBTInvestmentCell : UITableViewCell

@property (nonatomic, strong) Data1 *cellData;

@property (nonatomic, assign) CellType type;

@end
