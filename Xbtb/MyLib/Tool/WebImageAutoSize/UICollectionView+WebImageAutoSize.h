//
//  UICollectionView+WebImageAutoSize.h
//  DMWebImageAutoSizeExample
//
//  Created by zhuxiaohui on 2017/10/25.
//  Copyright © 2017年 it7090.com. All rights reserved.

#import <UIKit/UIKit.h>
#import "WebImageAutoSizeConst.h"

@interface UICollectionView (WebImageAutoSize)

/**
 Reload collectionView
 
 @param url imageURL
 */
-(void)dm_reloadDataForURL:(NSURL *)url;

#pragma mark - 过期
/**
 *  Reload item
 *
 *  @param indexPath indexPath
 *  @param url        imageURL
 */
-(void)dm_reloadItemAtIndexPath:(NSIndexPath *)indexPath forURL:(NSURL *)url DMWebImageAutoSizeDeprecated("请使用dm_reloadDataForURL:");

/**
 *  Reload items
 *
 *  @param indexPaths indexPaths
 *  @param url        imageURL
 */
-(void)dm_reloadItemsAtIndexPaths:(NSArray<NSIndexPath *> *)indexPaths forURL:(NSURL *)url  DMWebImageAutoSizeDeprecated("请使用dm_reloadDataForURL:");

@end
