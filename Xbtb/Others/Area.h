//
//  Area.h
//  SWWH
//
//  Created by 尚往文化 on 17/1/14.
//  Copyright © 2017年 cy. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface Area : NSObject

@property (nonatomic, assign) NSInteger parentId;

@property (nonatomic, copy) NSString *name;

@property (nonatomic, assign) NSInteger id;

@property (nonatomic, copy) NSString *sort;

@property (nonatomic, copy) NSString *fullName;

@property (nonatomic, copy) NSString *path;

//"initial": "A"
@property (nonatomic, copy) NSString *initial;


@end
