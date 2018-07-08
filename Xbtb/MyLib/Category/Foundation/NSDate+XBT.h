//
//  NSDate+XBT.h
//  SWWH
//
//  Created by 尚往文化 on 16/7/20.
//  Copyright © 2016年 cy. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface NSDate (XBT)

- (NSString *)stringWithDateFormat:(NSString *)dateFormat;

/**
 *  根据时间戳返回时间字符串
 */
+ (NSString *)stringWithTimeInterval:(unsigned long long)timeInterval dateFormat:(NSString *)dateFormat;

+ (NSDate *)dateWithTimeStr:(NSString *)timeStr dateFormat:(NSString *)dateFormat;

//加天数
- (NSDate *)dateAddDay:(NSInteger)day;
- (NSDate *)dateAddHours:(NSInteger)hours;
- (NSDate *)dateAddMinute:(NSInteger)minute;

/*
 *  时间戳
 */
@property (nonatomic,copy,readonly) NSString *timestamp;

/*
 *  时间成分
 */
@property (nonatomic,strong,readonly) NSDateComponents *components;

/*
 *  是否是今年
 */
@property (nonatomic,assign,readonly) BOOL isThisYear;

/*
 *  是否是今天
 */
@property (nonatomic,assign,readonly) BOOL isToday;

/*
 *  是否是昨天
 */
@property (nonatomic,assign,readonly) BOOL isYesToday;

/**
 是否本月
 */
@property (nonatomic, assign, readonly) BOOL isMonth;



/**
 *  两个时间比较
 *
 *  @param unit     成分单元
 *  @param fromDate 起点时间
 *  @param toDate   终点时间
 *
 *  @return 时间成分对象
 */
+(NSDateComponents *)dateComponents:(NSCalendarUnit)unit fromDate:(NSDate *)fromDate toDate:(NSDate *)toDate;

@end
