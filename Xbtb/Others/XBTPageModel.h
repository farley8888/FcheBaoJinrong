//
//  XBTPageModel.h
//  CheBaoJinRong
//
//  Created by apple on 2018/5/18.
//  Copyright © 2018年 apple. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface XBTPageModel : NSObject

//"endRow": 1,
//"firstPage": true,
//"hasNextPage": false,
@property (nonatomic, assign) BOOL hasNextPage;
//"hasPrePage": false,
@property (nonatomic, assign) BOOL hasPrePage;
//"lastPage": true,
@property (nonatomic, assign) BOOL lastPage;
//"limit": 10,
//"nextPage": 1,
@property (nonatomic, assign) NSInteger nextPage;
//"offset": 0,
//"page": 1,
//"prePage": 1,
//"slider": [1],
//"startRow": 1,
//"totalCount": 1,
@property (nonatomic, assign) NSInteger totalCount;
//"totalPages": 1
@property (nonatomic, assign) NSInteger totalPages;

@end
