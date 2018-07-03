//
//  NSObject+runtime.h
//  SWWH
//
//  Created by 尚往文化 on 16/9/10.
//  Copyright © 2016年 cy. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <objc/runtime.h>
#import <objc/message.h>

@interface DMRuntimeProperty : NSObject
@property (nonatomic, copy) NSString *name;
@property (nonatomic, copy) NSString *type;
/**属性特性描述字符串*/
@property (nonatomic, copy) NSString *attributes;
/**所有属性特性*/
@property (nonatomic, assign) objc_property_attribute_t *attributeList;
@end

@interface DMRuntimeMethod : NSObject

/**方法名称*/
@property (nonatomic, copy) NSString *name;
/**返回类型*/
@property (nonatomic, copy) NSString *returnType;
/**参数个数*/
@property (nonatomic, assign) NSUInteger numberOfArguments;
/**参数类型*/
@property (nonatomic, strong) NSArray<NSString *> *argumentTypes;

@end

@interface NSObject (runtime)


/**
 为类添加一个方法

 @param sel 方法名字
 @param imp 方法实现
 @param types 方法的类型 例如：v@:@、@@:@、v@:
 */
- (void)addMethod:(SEL)sel imp:(IMP)imp types:(const char *)types;

/**
 交换方法
 */
+ (void)swizzleClassMethodOriginSelector:(SEL)originSelector otherSelector:(SEL)otherSelector;
+ (void)swizzleInstanceMethodOriginSelector:(SEL)originSelector otherSelector:(SEL)otherSelector;

/**
 方法-->函数
 */
- (void *)getFunctionForSel:(SEL)sel;
/**
 获取类的所有属性 但是不会获取成员变量
 */
+ (NSArray<DMRuntimeProperty *> *)getAllProperty;
/**
 获取类的成员变量
 */
+ (NSArray<DMRuntimeProperty *> *)getAllIvar;

/**
 获取类的所有方法
 */
+ (NSArray<DMRuntimeMethod *> *)getAllMethod;

@end






