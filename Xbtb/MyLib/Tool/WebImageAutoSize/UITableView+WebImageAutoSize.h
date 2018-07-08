//
//  UITableView+WebImageAutoSize.h
//  DMWebImageAutoSizeExample
//
//  Created by zhuxiaohui on 2017/10/25.
//  Copyright © 2017年 it7090.com. All rights reserved.

#import <UIKit/UIKit.h>
#import "WebImageAutoSizeConst.h"

@interface UITableView (WebImageAutoSize)

/**
 Reload tableView

 @param url imageURL
 */
-(void)dm_reloadDataForURL:(NSURL *)url;

#pragma mark - 过期
/**
 *  Reload row
 *
 *  @param indexPath indexPath
 *  @param url        imageURL
 */
-(void)dm_reloadRowAtIndexPath:(NSIndexPath *)indexPath forURL:(NSURL *)url DMWebImageAutoSizeDeprecated("请使用dm_reloadDataForURL:");

/**
 *  Reload row withRowAnimation
 *
 *  @param indexPath indexPath
 *  @param animation UITableViewRowAnimation
 *  @param url       imageURL
 */
-(void)dm_reloadRowAtIndexPath:(NSIndexPath *)indexPath withRowAnimation:(UITableViewRowAnimation)animation forURL:(NSURL *)url DMWebImageAutoSizeDeprecated("请使用dm_reloadDataForURL:");

/**
 *  Reload rows
 *
 *  @param indexPaths indexPaths
 *  @param url        imageURL
 */
-(void)dm_reloadRowsAtIndexPaths:(NSArray<NSIndexPath *> *)indexPaths forURL:(NSURL *)url DMWebImageAutoSizeDeprecated("请使用dm_reloadDataForURL:");
;
@end
