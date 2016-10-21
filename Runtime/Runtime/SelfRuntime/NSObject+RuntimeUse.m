//
//  NSObject+RuntimeUse.m
//  Runtime
//
//  Created by hy on 2016/10/14.
//  Copyright © 2016年 hy. All rights reserved.
//

#import "NSObject+RuntimeUse.h"
#import <objc/runtime.h>



@implementation NSObject (RuntimeUse)

//所有字典转模型框架 核心算法
+ (instancetype)cz_objcWithDictionary:(NSDictionary *)dict
{
    //实例化对象
    id object = [[self alloc]init];
    
    //获取对象的属性名称数组
    //1> 获得 self 的属性列表
    NSArray *array = [self cz_objPropertiesAry];
    
    //遍历字典  使用KVC 为数组中的属性赋值
    [dict enumerateKeysAndObjectsUsingBlock:^(id  _Nonnull key, id  _Nonnull obj, BOOL * _Nonnull stop) {
        
        //需要先判断数组中是否包含 字典的Key
        if ([array containsObject:key]) {
            
            //赋值
            [object setValue:obj forKey:key];
        }
    }];
    
    return object;
}




const void *kPropertiesKey = "kPropertiesKey";

+ (NSArray *)cz_objPropertiesAry
{
    
#pragma mark 关联对象 获取 属性值 没有 则添加属性值  （动态的添加属性值）
    /*
     此方法虽然能够获取类的属性数组  但是如果每次调用都要执行一次的话 耗费的时间长，
     使用 关联对象  动态的添加属性值  分别在方法的开头和结尾
     
     */
    /*
     参数：
        1、对象  self 
        2、const void 的key
     
     返回值  ： Id类型
     添加的属性值
     */
    
    NSArray *proList =  objc_getAssociatedObject(self, kPropertiesKey);
    if (proList) {
        return proList;
    }
    
    //获取属性数组的指针数组
    unsigned int count = 0;
    objc_property_t *property = class_copyPropertyList([self class], &count);
    
    
    //创建存放数据的数组
    NSMutableArray *array = [NSMutableArray array];
    
    //遍历属性数组
    for (unsigned int i = 0; i < count; i++) {
        
        // 指针   C语言中数组的名字 为第一个元素的指针
        objc_property_t pty = property[i];
        
        //获取属性的名字  类型为C的字符串
        const char *cName  =  property_getName(pty);
        
        //把C字符串转化为OC字符串
        NSString *name = [NSString stringWithCString:cName encoding:NSUTF8StringEncoding];
        
        //[NSString stringWithUTF8String:cName]; 也可以
        
        //把信息添加到数组里面
        [array addObject:name];
        
    }
    
    //释放属性数组
    free(property);
    
#pragma mark 关联对象 2 添加属性值 动态的添加属性值
    
    /*
     参数：
        1、对象 self
        2、const void 的key  同第一步
        3、添加的属性值  
        4、关联的协议
     */
    objc_setAssociatedObject(self, kPropertiesKey, array.copy, OBJC_ASSOCIATION_RETAIN_NONATOMIC);
    
    return array.copy;
}






@end
