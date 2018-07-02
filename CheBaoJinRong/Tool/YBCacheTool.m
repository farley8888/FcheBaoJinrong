//
//  YBCacheTool.m
//  ZCWL
//
//  Created by ios-dev on 16/3/22.
//  Copyright © 2016年 com.zcwljs.cnge.app. All rights reserved.
//

#import "YBCacheTool.h"
#import "Define.h"
#import "DMMD5.h"


@implementation YBCacheTool

+ (void)cacheForData:(NSData *)data fileName:(NSString *)fileName
{
    NSString *path = [kCachePath stringByAppendingPathComponent:[DMMD5 md5:fileName]];
    
    dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0), ^{
        [data writeToFile:path atomically:YES];
    });
}

+ (NSData *)getCacheFileName:(NSString *)fileName
{
    NSString *path = [kCachePath stringByAppendingPathComponent:[DMMD5 md5:fileName]];
    return [[NSData alloc] initWithContentsOfFile:path];
}

+ (NSUInteger)getAFNSize
{
    NSUInteger size = 0;
    NSFileManager *fm = [NSFileManager defaultManager];
    
    NSDirectoryEnumerator *fileEnumerator = [fm enumeratorAtPath:kCachePath];
    for (NSString *fileName in fileEnumerator) {
        NSString *filePath = [kCachePath stringByAppendingPathComponent:fileName];
        NSDictionary *attrs = [[NSFileManager defaultManager] attributesOfItemAtPath:filePath error:nil];
        size += [attrs fileSize];
    }
    return size;
}

+ (NSUInteger)getSize
{
    //获取SDWebImage的缓存大小
    NSUInteger imageSize = [[SDImageCache sharedImageCache] getSize];
    //获取AFN的缓存大小
    NSUInteger afnSize = [self getAFNSize];
    return imageSize+afnSize;
}

+ (void)clearAFNCache
{
    NSFileManager *fm = [NSFileManager defaultManager];
    
    NSDirectoryEnumerator *fileEnumerator = [fm enumeratorAtPath:kCachePath];
    for (NSString *fileName in fileEnumerator) {
        NSString *filePath = [kCachePath stringByAppendingPathComponent:fileName];
        
        [fm removeItemAtPath:filePath error:nil];
        
    }
}

+ (void)clearCache
{
    //清除SDWebImage的缓存
    [[SDImageCache sharedImageCache] clearDiskOnCompletion:nil];
    [self clearAFNCache];
}

+ (BOOL)isExpire:(NSString *)fileName
{
    NSString *path = [kCachePath stringByAppendingPathComponent:[DMMD5 md5:fileName]];
    
    NSFileManager *fm = [NSFileManager defaultManager];
    NSDictionary *attributesDict = [fm attributesOfItemAtPath:path error:nil];
    NSDate *fileModificationDate = attributesDict[NSFileModificationDate];
    NSTimeInterval fileModificationTimestamp = [fileModificationDate timeIntervalSince1970];
    //现在的时间戳
    NSTimeInterval nowTimestamp = [[NSDate dateWithTimeIntervalSinceNow:0] timeIntervalSince1970];
    return (nowTimestamp-fileModificationTimestamp>kYBCache_Expire_Time);
}


@end
