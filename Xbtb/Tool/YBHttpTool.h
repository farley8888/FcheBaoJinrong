//
//  YBHttp.h
//  Wanyingjinrong
//
//  Created by Jason on 15/11/17.
//  Copyright © 2015年 www.jizhan.com. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <AFNetworking/AFNetworking.h>
#import "XBTCacheTool.h"
#import "Data.h"


@class Wallet;
@interface NSError (YBHttp)

@property (nonatomic, assign) NSInteger statusCode;

@end


@interface YBHttpTool : NSObject

+ (void)post:(NSString *_Nullable)url params:(NSDictionary *_Nullable)params success:(void (^_Nullable)(Data * _Nullable obj))success failure:(void (^_Nullable)(NSError * _Nonnull error))failure;

+ (void)post:(NSString *_Nullable)url params:(NSDictionary *_Nullable)params cacheType:(YBCacheType)cacheType success:(void (^_Nullable)(Data *_Nullable obj))success failure:(void (^_Nullable)(NSError * _Nullable error))failure;

//支付回调
+ (void)payBackPost:(NSString *_Nullable)url params:(NSDictionary *_Nullable)params success:(void (^_Nullable)(Data *_Nullable obj))success failure:(void (^_Nullable)(NSError *_Nullable error))failure;

//post请求原始URL
+ (void)postWithOriginalUrl:(NSString *_Nullable)url params:(NSDictionary * _Nullable)params success:(void (^_Nullable)(id _Nullable obj))success failure:(void (^_Nullable)(NSError *_Nullable error))failure;

//上传图片
+ (void)uploadImageWithImage:(NSData *_Nullable)image success:(void (^_Nullable)(Data *_Nullable obj))success failure:(void (^_Nullable)(NSError *_Nullable error))failure;

+ (void)uploadImageArrayWithImages:(NSArray<NSData *> *_Nullable)images success:(void (^_Nullable)(Data * _Nullable obj))success failure:(void (^_Nullable)(NSError *_Nullable error))failure;

//更新设别ID
+ (void)updateRegistrationID;

//App检查更新
+ (void)updateAppSuccess:(void (^_Nullable)(id _Nullable))success failure:(void (^_Nullable)(NSError *_Nullable))failure;

//数据结构不同的请求方式
+(void)postDataDifference:(NSString *_Nullable)url params:(NSDictionary *_Nullable)params success:(void (^_Nullable)(id  _Nullable obj))success failure:(void (^_Nullable)(NSError *_Nullable error))failure;

//可缓存数据
+ (void)get:(NSString *_Nullable)url params:(NSDictionary *_Nullable)params cacheType:(YBCacheType)cacheType success:(void (^_Nullable)(Data *_Nullable))success failure:(void (^_Nullable)(NSError *_Nullable error))failure;

//请求外层结构不一样的get方法
+(void)getDataDifference:(NSString *_Nullable)url params:(NSDictionary *_Nullable)params success:(void (^_Nullable)(id  _Nullable obj))success failure:(void (^_Nullable)(NSError *_Nullable error))failure;

//请求html格式的get方法
+ (void)getDataTypeForTextHtmlUrl:(NSString *_Nullable)url params:(NSDictionary *_Nullable)params Success:(void(^_Nullable)(Data *_Nullable obj))success failure:(void(^_Nullable)(NSError *_Nullable error))failure;

//加载本地缓存方法
+ (void)getDateSuccess:(void (^_Nullable)(Data *_Nullable obj))success failure:(void (^_Nullable)(NSError *_Nullable error))failure;

//get有外层方法
+ (void)getDataUrl:(NSString *_Nullable)url params:(NSDictionary *_Nullable)params success:(void (^_Nullable)(Data *_Nullable obj))success failure:(void (^_Nullable)(NSError *_Nullable error))failure;

@end
