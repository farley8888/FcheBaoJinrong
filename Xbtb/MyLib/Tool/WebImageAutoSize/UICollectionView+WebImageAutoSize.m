//
//  UICollectionView+WebImageAutoSize.m
//  DMWebImageAutoSizeExample
//
//  Created by zhuxiaohui on 2017/10/25.
//  Copyright © 2017年 it7090.com. All rights reserved.

#import "UICollectionView+WebImageAutoSize.h"
#import "XBTWebImageAutoSize.h"

@implementation UICollectionView (WebImageAutoSize)
-(void)dm_reloadDataForURL:(NSURL *)url{
    BOOL reloadState = [XBTWebImageAutoSize reloadStateFromCacheForURL:url];
    if(!reloadState){
        [self reloadData];
        [XBTWebImageAutoSize storeReloadState:YES forURL:url completed:nil];
    }
}

#pragma mark- 过期
-(void)dm_reloadItemAtIndexPath:(NSIndexPath *)indexPath forURL:(NSURL *)url{
    BOOL reloadState = [XBTWebImageAutoSize reloadStateFromCacheForURL:url];
    if(!reloadState){
        [self reloadItemsAtIndexPaths:[NSArray arrayWithObject:indexPath]];
        [XBTWebImageAutoSize storeReloadState:YES forURL:url completed:nil];
    }
}

-(void)dm_reloadItemsAtIndexPaths:(NSArray<NSIndexPath *> *)indexPaths forURL:(NSURL *)url{
    BOOL reloadState = [XBTWebImageAutoSize reloadStateFromCacheForURL:url];
    if(!reloadState){
        [self reloadItemsAtIndexPaths:indexPaths];
        [XBTWebImageAutoSize storeReloadState:YES forURL:url completed:nil];
    }
}
@end
