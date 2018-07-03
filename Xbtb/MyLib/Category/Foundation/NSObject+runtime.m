//
//  NSObject+runtime.m
//  SWWH
//
//  Created by 尚往文化 on 16/9/10.
//  Copyright © 2016年 cy. All rights reserved.
//

#import "NSObject+runtime.h"

@implementation DMRuntimeProperty

- (NSString *)description
{
    return [NSString stringWithFormat:@"name:%@----type:%@", _name, _type];
}

@end

@implementation DMRuntimeMethod

- (NSString *)description
{
    return [NSString stringWithFormat:@"name:%@----returnType:%@", _name, _returnType];
}

@end

@implementation NSObject (runtime)

+ (void)swizzleClassMethodOriginSelector:(SEL)originSelector otherSelector:(SEL)otherSelector
{
    Method otherMehtod = class_getClassMethod(self, otherSelector);
    Method originMehtod = class_getClassMethod(self, originSelector);
    // 交换2个方法的实现
    method_exchangeImplementations(otherMehtod, originMehtod);
}

+ (void)swizzleInstanceMethodOriginSelector:(SEL)originSelector otherSelector:(SEL)otherSelector
{
    Method otherMehtod = class_getInstanceMethod(self, otherSelector);
    Method originMehtod = class_getInstanceMethod(self, originSelector);
    // 交换2个方法的实现
    method_exchangeImplementations(otherMehtod, originMehtod);
}

- (void)addMethod:(SEL)sel imp:(IMP)imp types:(const char *)types
{
    Method method = class_getInstanceMethod([self class], sel);
    if (method==nil) {
        if (imp) {
            class_addMethod([self class], sel, imp, types);
        }
    }
}

- (void *)getFunctionForSel:(SEL)sel
{
    IMP imp = [self methodForSelector:sel];
    return imp;
}

+ (NSArray<DMRuntimeProperty *> *)getAllProperty
{
    Class class = [self class];
    NSMutableArray<DMRuntimeProperty *> *propertyArr = [[NSMutableArray alloc] init];
    unsigned int count;
    while (class != [NSObject class]) {
        
        objc_property_t *properties = class_copyPropertyList(class, &count);
        for(int i = 0; i < count; i++) {
            
            objc_property_t property = properties[i];
            
            DMRuntimeProperty *obj = [DMRuntimeProperty new];
            obj.name = [[NSString alloc] initWithUTF8String:property_getName(property)];
            obj.attributes = [[NSString alloc] initWithUTF8String:property_getAttributes(property)];
            unsigned int outCount;
            objc_property_attribute_t *attributeList = property_copyAttributeList(property, &outCount);
            obj.attributeList = attributeList;
            
            obj.type = [[NSString alloc] initWithUTF8String:property_copyAttributeValue(property, "T")];
            
            [propertyArr addObject:obj];
        }
        if (properties) {
            free(properties);
        }
        //得到父类的消息
        class = class_getSuperclass(class);
    }
    return [NSArray arrayWithArray:propertyArr];
}

+ (NSArray<DMRuntimeProperty *> *)getAllIvar {
    Class class = [self class];
    NSMutableArray *ivarArr = [[NSMutableArray alloc] init];
    unsigned int methodCount = 0;
    while (class != [NSObject class]) {
        Ivar *ivars = class_copyIvarList(class, &methodCount);
        for (unsigned int i = 0; i < methodCount; i ++) {
            Ivar ivar = ivars[i];
            DMRuntimeProperty *obj = [DMRuntimeProperty new];
            obj.name = [[NSString alloc] initWithUTF8String:ivar_getName(ivar)];
            obj.type = [NSString stringWithUTF8String:ivar_getTypeEncoding(ivar)];
            [ivarArr addObject:obj];
        }
        if (ivars) {
            free(ivars);
        }
        class = class_getSuperclass(class);
    }
    return ivarArr;
}

+ (NSArray<DMRuntimeMethod *> *)getAllMethod
{
    Class class = [self class];
    unsigned int count;
    NSMutableArray *methodArr = [[NSMutableArray alloc] init];
    while (class != [NSObject class]) {
        Method *methods = class_copyMethodList(class, &count);
        for (int i = 0; i < count; i++)
        {
            Method method = methods[i];
            //方法名称
            SEL selector = method_getName(method);
            NSString *name = NSStringFromSelector(selector);
            //返回类型
            NSString *returnType = [NSString stringWithUTF8String:method_copyReturnType(method)];
            //方法的参数个数
            unsigned int numberOfArguments =  method_getNumberOfArguments(method);
            //参数的类型
            NSMutableArray *argumentTypes = [NSMutableArray array];
            for (int j=0; j<numberOfArguments; j++) {
                [argumentTypes addObject:[NSString stringWithUTF8String:method_copyArgumentType(method, j)]];
            }
            DMRuntimeMethod *obj = [DMRuntimeMethod new];
            obj.name = name;
            obj.returnType = returnType;
            obj.numberOfArguments = numberOfArguments;
            obj.argumentTypes = argumentTypes;
            [methodArr addObject:obj];
        }
        class = class_getSuperclass(class);
    }
    return [NSArray arrayWithArray:methodArr];
}

@end



