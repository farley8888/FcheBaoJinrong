//
//  UITableView+DMWebImageAutoSize.m
//  DMWebImageAutoSizeExample
//
//  Created by zhuxiaohui on 2017/10/25.
//  Copyright © 2017年 it7090.com. All rights reserved.

#import "UITableView+DMWebImageAutoSize.h"
#import "DMWebImageAutoSizeConst.h"
#import "XBTWebImageAutoSize.h"

@implementation UITableView (DMWebImageAutoSize)

-(void)dm_reloadDataForURL:(NSURL *)url{
    BOOL reloadState = [XBTWebImageAutoSize reloadStateFromCacheForURL:url];
    if(!reloadState){
        [self reloadData];
        [XBTWebImageAutoSize storeReloadState:YES forURL:url completed:nil];
    }
}

#pragma mark-过期
-(void)dm_reloadRowAtIndexPath:(NSIndexPath *)indexPath forURL:(NSURL *)url{
    [self dm_reloadRowAtIndexPath:indexPath withRowAnimation:UITableViewRowAnimationNone forURL:url];
}

-(void)dm_reloadRowAtIndexPath:(NSIndexPath *)indexPath withRowAnimation:(UITableViewRowAnimation)animation forURL:(NSURL *)url{
    BOOL reloadState = [XBTWebImageAutoSize reloadStateFromCacheForURL:url];
    if(!reloadState){
        [self reloadRowsAtIndexPaths:[NSArray arrayWithObject:indexPath] withRowAnimation:animation];
        [XBTWebImageAutoSize storeReloadState:YES forURL:url completed:nil];
    }
}

-(void)dm_reloadRowsAtIndexPaths:(NSArray<NSIndexPath *> *)indexPaths forURL:(NSURL *)url{
    [self dm_reloadRowsAtIndexPaths:indexPaths withRowAnimation:UITableViewRowAnimationNone forURL:url];
}

-(void)dm_reloadRowsAtIndexPaths:(NSArray<NSIndexPath *> *)indexPaths withRowAnimation:(UITableViewRowAnimation)animation forURL:(NSURL *)url{
    BOOL reloadState = [XBTWebImageAutoSize reloadStateFromCacheForURL:url];
    if(!reloadState){
        [self reloadRowsAtIndexPaths:indexPaths withRowAnimation:animation];
        [XBTWebImageAutoSize storeReloadState:YES forURL:url completed:nil];
    }
}
@end
