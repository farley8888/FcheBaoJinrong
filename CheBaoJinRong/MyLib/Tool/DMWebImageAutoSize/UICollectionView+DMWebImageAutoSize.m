//
//  UICollectionView+DMWebImageAutoSize.m
//  DMWebImageAutoSizeExample
//
//  Created by zhuxiaohui on 2017/10/25.
//  Copyright © 2017年 it7090.com. All rights reserved.

#import "UICollectionView+DMWebImageAutoSize.h"
#import "DMWebImageAutoSize.h"

@implementation UICollectionView (DMWebImageAutoSize)
-(void)dm_reloadDataForURL:(NSURL *)url{
    BOOL reloadState = [DMWebImageAutoSize reloadStateFromCacheForURL:url];
    if(!reloadState){
        [self reloadData];
        [DMWebImageAutoSize storeReloadState:YES forURL:url completed:nil];
    }
}

#pragma mark- 过期
-(void)dm_reloadItemAtIndexPath:(NSIndexPath *)indexPath forURL:(NSURL *)url{
    BOOL reloadState = [DMWebImageAutoSize reloadStateFromCacheForURL:url];
    if(!reloadState){
        [self reloadItemsAtIndexPaths:[NSArray arrayWithObject:indexPath]];
        [DMWebImageAutoSize storeReloadState:YES forURL:url completed:nil];
    }
}

-(void)dm_reloadItemsAtIndexPaths:(NSArray<NSIndexPath *> *)indexPaths forURL:(NSURL *)url{
    BOOL reloadState = [DMWebImageAutoSize reloadStateFromCacheForURL:url];
    if(!reloadState){
        [self reloadItemsAtIndexPaths:indexPaths];
        [DMWebImageAutoSize storeReloadState:YES forURL:url completed:nil];
    }
}
@end
