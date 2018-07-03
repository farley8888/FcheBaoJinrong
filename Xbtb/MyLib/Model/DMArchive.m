//
//  DMArchive.m
//  DMArchiveTool
//
//  Created by Jason on 16/1/14.
//  Copyright © 2016年 www.jizhan.com. All rights reserved.
//

#import "DMArchive.h"
#import <objc/runtime.h>

@implementation DMArchive

- (NSArray<NSString *> *)filterForPropertyNames
{
    return nil;
}

/**
 *  获取类所有的属性名
 *  @return 属性名数组
 */
- (NSArray *)getAllProperty
{
    Class class = [self class];
    NSMutableArray *propertyArr = [[NSMutableArray alloc] init];
    unsigned int count;
    while (class != [NSObject class]) {
        objc_property_t *properties = class_copyPropertyList(class, &count);
        for(int i = 0; i < count; i++)
        {
            objc_property_t property = properties[i];
            NSString *propertyName = [[NSString alloc] initWithCString:property_getName(property) encoding:NSUTF8StringEncoding];
            
            if (![self.filterForPropertyNames containsObject:propertyName]) {
                
                [propertyArr addObject:propertyName];
            }
            
            
        }
        if (properties) {
            free(properties);
        }
        //得到父类的消息
        class = class_getSuperclass(class);
    }
    return propertyArr;
}

- (instancetype)initWithCoder:(NSCoder *)coder
{
    self = [super init];
    if (self) {
        NSArray *properties = [self getAllProperty];
        for (NSString *property in properties) {
            [self setValue:[coder decodeObjectForKey:property] forKey:property];
        }
    }
    return self;
}

- (void)encodeWithCoder:(NSCoder *)coder
{
    NSArray *properties = [self getAllProperty];
    for (NSString *property in properties) {
        [coder encodeObject:[self valueForKey:property] forKey:property];
    }
}


@end
