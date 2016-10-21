//
//  Person+Cotegory.m
//  Runtime
//
//  Created by hy on 2016/10/17.
//  Copyright © 2016年 hy. All rights reserved.
//

#import "Person+Cotegory.h"
#import <objc/runtime.h>

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>




@implementation Person (Cotegory)

//@dynamic 表明
@dynamic address;
@dynamic phoneNumber;




#pragma mark - add property  use AssociatedObject
const void *kAddress  = "Address";
const void *kPhoneNumber = "PhoneNumber";

//设置关联对象
- (NSString *)address
{
    //获取关联对象 的动态属性值
    return objc_getAssociatedObject(self, &kAddress);
}

- (void)setAddress:(NSString *)address
{
    //动态的添加设置 关联对象的 属性值
    return objc_setAssociatedObject(self, kAddress, address, OBJC_ASSOCIATION_RETAIN_NONATOMIC);
}

- (NSString *)phoneNumber
{
    return objc_getAssociatedObject(self, &kPhoneNumber);
}

- (void)setPhoneNumber:(NSString *)phoneNumber
{
    return objc_setAssociatedObject(self, &kPhoneNumber, phoneNumber, OBJC_ASSOCIATION_RETAIN_NONATOMIC);
}


#pragma mark - exchange methods

//load 在类添加到运行时的时候 就会调用
+ (void)load
{
    /*
     1、获取默认方法
     2、获取新方法
     3、交换两个方法  (交换两个方法之后，默认方法名 和自定义的方法名就进行了交换，调用默认方法 使用自定义方法名，
     调用自定义方法 使用默认方法名)
     */
    
    Method oldMehtod =  class_getInstanceMethod([self class], @selector(logPersonDestription));
    Method newMethod = class_getInstanceMethod([self class], @selector(cz_newAction));
    method_exchangeImplementations(oldMehtod, newMethod);
    
}

- (void)cz_newAction
{
    //do something
    
    DLog(@"这里进行了方法交换，调用的方法为 %s",__FUNCTION__);
    
    //调用系统默认的方法   因为经过runtime 交换方法，默认方法 的方法名 和 自定义的方法名 进行了交换
    [self cz_newAction];
}


#pragma mark -  add new method
- (void)helloWorld
{
    DLog(@"输出hello world");
}





//
//#pragma mark - get class properties
//
//const void *kClassProperties = "ClassProperties";
//+ (NSArray *)cz_getClassProperties
//{
//    /*
//     动态获取类的属性列表
//
//     关联对象
//     A、 动态获取 属性值
//
//     1、获取类的属性的指针列表数组
//     2、创建可变存储数组
//     3、遍历指针数组 获取名称，把C字符串转换成OC的字符串，添加到存储数组
//
//     B、动态设置 属性值
//
//     */
//
//    NSArray *propertiesAry =  objc_getAssociatedObject(self, &kClassProperties);
//
//    if (propertiesAry) {
//        return propertiesAry;
//    }
//
        //返回类型为指向指针的指针
//    unsigned int count = 0;
//    objc_property_t *properties = class_copyPropertyList([self class], &count);
//
//
//    NSMutableArray *array = [NSMutableArray array];
//
//    for (unsigned int i = 0; i < count; i++) {
//
//        objc_property_t pty = properties[i];
//
//        const char *cName =  property_getName(pty);
//
//        NSString *name = [NSString stringWithCString:cName encoding:NSUTF8StringEncoding];
//
//        [array addObject:name];
//
//    }
//
//    //动态 添加属性值
//    objc_setAssociatedObject(self, &kClassProperties, array.copy, OBJC_ASSOCIATION_RETAIN_NONATOMIC);
//    /*
//     @param  对象 self
//     @param  const void *key
//     @param  属性值
//     @param  关联协议
//     */
//
//    return array.copy;
//}

//#pragma mark - set class properties value
//
//+ (instancetype)cz_setPropertiesValueWithDictionary:(NSDictionary *)dictionary
//{
//    /*
//     1、获取类的实例对象
//     1、获取类的属性数组
//     2、枚举字典 使用KVC赋值
//     */
//
//    id object = [[self alloc]init];
//
//    //获取类的属性数组
//    NSArray *properties = [self cz_getClassProperties];
//
//    [dictionary enumerateKeysAndObjectsUsingBlock:^(id  _Nonnull key, id  _Nonnull obj, BOOL * _Nonnull stop) {
//
//        //判断数组是否包含 key
//        if ([properties containsObject:key]) {
//
//            [object setObject:obj forKey:key];
//        }
//    }];
//
//    return object;
//
//}





@end
