//
//  DMShareRecordModel.h
//  CheBaoJinRong
//
//  Created by apple on 2018/6/28.
//  Copyright © 2018年 apple. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface DMDataModel: NSObject
//awardAmount = 0;
@property (nonatomic, assign) CGFloat awardAmount;
//cellPhone = 13811111111;
@property (nonatomic, copy) NSString *cellPhone;
//createTime = 1484100336000;
@property (nonatomic, assign) unsigned long long createTime;
//id = 10;
    
@end


@interface DMShareRecordModel : NSObject

//    count = 9;
@property (nonatomic, assign) NSInteger count;
//    data =     (
@property (nonatomic, strong) NSMutableArray<DMDataModel *> *data;
//    sumtjjl = 0;
@property (nonatomic, copy) NSString *sumtjjl;
    
@end
