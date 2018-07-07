//
//  DMArchive.h
//  DMArchiveTool
//
//  Created by Jason on 16/1/14.
//  Copyright © 2016年 www.jizhan.com. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface XBTArchive : NSObject

- (NSArray *)getAllProperty;

- (NSArray<NSString *> *)filterForPropertyNames;

@end
