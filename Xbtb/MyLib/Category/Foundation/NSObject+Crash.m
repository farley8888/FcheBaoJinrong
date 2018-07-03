//
//  NSObject+Crash.m
//  XHGY_Agent
//
//  Created by 尚往文化 on 17/7/12.
//  Copyright © 2017年 DMing. All rights reserved.
//

#import "NSObject+Crash.h"
#import "NSObject+runtime.h"

static BOOL CrashEnable = NO;//打开就回崩溃

@implementation NSArray (runtime)

+ (void)load
{
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        [NSClassFromString(@"__NSArrayI") swizzleInstanceMethodOriginSelector:@selector(objectAtIndex:) otherSelector:@selector(DM_objectAtIndexI:)];
        [NSClassFromString(@"__NSArray0") swizzleInstanceMethodOriginSelector:@selector(objectAtIndex:) otherSelector:@selector(DM_objectAtIndex0:)];
    });
}

- (id)DM_objectAtIndexI:(NSInteger)index
{
    if (self.count==0) return nil;
    if (index < self.count) {
        return [self DM_objectAtIndexI:index];
    } else {
        if (CrashEnable) {
            NSAssert(NO, @"数组越界了。。。。。。。");
        }
        return nil;
    }
}

- (id)DM_objectAtIndex0:(NSInteger)index
{
    if (self.count==0) return nil;
    if (index < self.count) {
        return [self DM_objectAtIndex0:index];
    } else {
        if (CrashEnable) {
            NSAssert(NO, @"数组越界了。。。。。。。");
        }
        return nil;
    }
}

@end

@implementation NSMutableArray (runtime)

+ (void)load
{
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        [NSClassFromString(@"__NSArrayM") swizzleInstanceMethodOriginSelector:@selector(insertObject:atIndex:) otherSelector:@selector(DM_insertObject:atIndex:)];
        [NSClassFromString(@"__NSArrayM") swizzleInstanceMethodOriginSelector:@selector(objectAtIndex:) otherSelector:@selector(DM_objectAtIndex:)];
        [NSClassFromString(@"__NSPlaceholderArray") swizzleInstanceMethodOriginSelector:@selector(initWithObjects:count:) otherSelector:@selector(DM_initWithObjects:count:)];
    });
}

- (void)DM_insertObject:(id)anObject atIndex:(NSUInteger)index
{
    if (anObject != nil && index<=self.count) {
        [self DM_insertObject:anObject atIndex:index];
    } else {
        if (CrashEnable) {
            NSAssert(NO, @"插入的对象是空或者插入的索引越界了。。。");
        }
    }
}

- (id)DM_objectAtIndex:(NSInteger)index
{
    if (index < self.count) {
        return [self DM_objectAtIndex:index];
    } else {
        if (CrashEnable) {
            NSAssert(NO, @"数组越界了。。。。。。。");
        }
        return nil;
    }
}

- (instancetype)DM_initWithObjects:(const id  _Nonnull __unsafe_unretained *)objects count:(NSUInteger)cnt
{
    for (int i=0; i<cnt; i++) {
        if (objects[i] == nil) {
            if (CrashEnable) {
                NSAssert(NO, @"插入的对象是空的。。。");
            }
            return nil;
        }
    }
    return [self DM_initWithObjects:objects count:cnt];
}

@end

@implementation NSDictionary (runtime)

+ (void)load
{
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        [NSClassFromString(@"__NSPlaceholderDictionary") swizzleInstanceMethodOriginSelector:@selector(initWithObjects:forKeys:count:) otherSelector:@selector(DM_initWithObjects:forKeys:count:)];
    });
}

- (instancetype)DM_initWithObjects:(const id  _Nonnull __unsafe_unretained *)objects forKeys:(const id<NSCopying>  _Nonnull __unsafe_unretained *)keys count:(NSUInteger)cnt
{
    for (int i=0; i<cnt; i++) {
        if (objects[i] == nil) {
            if (CrashEnable) {
                NSAssert(NO, @"插入的对象是空的。。。");
            }
            return nil;
        }
    }
    return [self DM_initWithObjects:objects forKeys:keys count:cnt];
}

@end

@implementation NSMutableDictionary (runtime)

+ (void)load
{
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        [NSClassFromString(@"__NSDictionaryM") swizzleInstanceMethodOriginSelector:@selector(setObject:forKey:) otherSelector:@selector(DM_setObject:forKey:)];
    });
}

- (void)DM_setObject:(id)anObject forKey:(id<NSCopying>)aKey
{
    if (anObject!=nil) {
        [self DM_setObject:anObject forKey:aKey];
    } else {
        if (CrashEnable) {
            NSAssert(NO, @"设置了字典的value为nil");
        }
    }
}

@end

@implementation NSString (runtime)

+ (void)load
{
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        [NSClassFromString(@"NSPlaceholderMutableString") swizzleInstanceMethodOriginSelector:@selector(initWithString:) otherSelector:@selector(DM_initWithString:)];
    });
}

- (NSString *)DM_initWithString:(NSString *)str
{
    if (str==nil) {
        return nil;
    }
    return [self DM_initWithString:str];
}

@end

