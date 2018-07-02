//
//  NSUserDefaults+Extension.h
//  Xunbao2
//
//  Created by Jason on 15/7/21.
//  Copyright (c) 2015年 Jason. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface NSUserDefaults (Extension)

+ (void)saveBool:(BOOL)value key:(NSString *)key;
+ (BOOL)getBoolForKey:(NSString *)key;

+ (void)saveFloat:(float)value key:(NSString *)key;
+ (float)getFloatForKey:(NSString *)key;

+ (void)saveInteger:(NSInteger)value key:(NSString *)key;
+ (NSInteger)getIntegerForKey:(NSString *)key;

+ (void)saveObject:(id)obj key:(NSString *)key;
+ (id)getObjectForKey:(NSString *)key;

@end
