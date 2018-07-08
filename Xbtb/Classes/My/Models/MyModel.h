//
//  MyModel.h
//  XYG
//
//  Created by 张殿明 on 2017/11/21.
//  Copyright © 2017年 Mac. All rights reserved.
//

#import <Foundation/Foundation.h>


@interface MyModel : NSObject

@property (nonatomic, strong) XBTStateModel *state;

//"userId": 100035,
@property (nonatomic, assign) CGFloat total1;

//"accountName": "cy3329520",
@property (nonatomic, assign) CGFloat total2;
//"mobile": "18819046314",
@property (nonatomic, assign) CGFloat total3;
//usableAmount
@property (nonatomic, copy) NSString *usableAmount;
/**  待回款总额  **/
@property (nonatomic, assign) CGFloat dhksum;
/**  红包数量  **/
@property (nonatomic, copy) NSString *sumhb;

@end
