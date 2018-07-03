//
//  Province.h
//  SWWH
//
//  Created by 尚往文化 on 16/7/29.
//  Copyright © 2016年 cy. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>

@interface DMCity : NSObject

@property (nonatomic, assign) NSInteger parentId;

@property (nonatomic, copy) NSString *cityCode;

@property (nonatomic, copy) NSString *shortName;

@property (nonatomic, assign) NSInteger id;

@property (nonatomic, copy) NSString *pinyin;

@property (nonatomic, copy) NSString *mergerName;

@property (nonatomic, assign) NSInteger levelType;

@property (nonatomic, assign) CGFloat lng;

@property (nonatomic, assign) CGFloat lat;

@property (nonatomic, copy) NSString *name;

@property (nonatomic, copy) NSString *zipCode;

@end
