//
//  NSObject+Runtime.m
//  Runtime
//
//  Created by hy on 2016/10/13.
//  Copyright © 2016年 hy. All rights reserved.
//

#import "NSObject+Runtime.h"
#import <objc/runtime.h>

@implementation NSObject (Runtime)


//所有字典转模型框架 核心算法
+ (instancetype)cz_objWithDict:(NSDictionary *)dict
{
    id object = [[self alloc]init];
    
    //使用字典 设置对象信息
     //1> 获得 self 的属性列表
    NSArray *proList = [self cz_objProperties];
    
    //遍历字典
    [dict enumerateKeysAndObjectsUsingBlock:^(id  _Nonnull key, id  _Nonnull obj, BOOL * _Nonnull stop) {
        
        NSLog(@"key %@ ---- value %@",key,obj);
        
        //2> 判断key 是否包含在proList 里面
        if ([proList containsObject:key]) {
            
            //说明属性存在 可以使用 KVC 设置数值
            [object setValue:obj forKey:key];
        }
    }];

    return object;
}


/*
 动态获取属性名称
 
 获取类的属性列表class_copyPropertyList
 遍历列表 获取 属性名称  property_getName
 添加到 OC数组
 
 */

const char * kPropertiesListKey = "kPropertiesListKey";

+ (NSArray *)cz_objProperties
{
#pragma mark 关联对象的步骤 1 
     //---- 1、从关联对象中获取哦对象属性，如果有，直接返回
        // 2 见 line 125 行
    
     /*
     获取关联对象 - 动态添加的属性
      
      参数：
      1、对象 self 
      2、动态属性的 key   const void *key
      
      返回值  动态添加的 “属性值”
     */
    //返回 id类型
    NSArray *ptyList =  objc_getAssociatedObject(self,kPropertiesListKey);
    
    if (ptyList != nil) {
        return ptyList;
    }
    
    
    //调用运行时方法 调用类的属性列表
    // IvarList    成员变量
    // MethodList   方法列表
    // PropertyList   属性
    // ProtocolList    协议
    
    /**
     *  参数：
     *      1、要获取的类
     *      2、类属性的个数     指针
     *  返回： 
     *      所有属性的数组，  C语言中，数组的名字 就是指向第一个元素的地址
     
      retain/create/copy 需要 release  最好option + click（点击）
     
     */
    
    unsigned int count = 0;  //下面为数组
    objc_property_t *proList =  class_copyPropertyList([self class], &count);
    
    NSLog(@"属性的数量%d",count);
    
    //创建数组
    NSMutableArray *array = [NSMutableArray array];
    
    //遍历所有的属性
    for (unsigned int i = 0; i < count; i++) {
        
        //1、从数组中获取属性
        /**
            C语言 的结构体指针 通常不需要 ”*“
         */
        objc_property_t pty = proList[i];   //这个为指针
        
        //2、从 pty 中获取属性的名称
        const char *cName =  property_getName(pty);//这个是C的字符串 使用 %s
        DLog(@"%s",cName);
        
        //使用OC 的字符串   需要把C的字符串转化一下
        NSString *name = [NSString stringWithCString:cName encoding:NSUTF8StringEncoding];
        
        //将属性名称添加到数组
        [array addObject:name];
        
    }

    //释放数组
    free(proList);
    
#pragma mark 关联对象的步骤 2
    // ---- 2、到此为止，对象的属性数组获取完毕，利用关联对象，动态添加属性
    /**
     参数：
     1、对象 self [OC 中class] 也是一个特殊的对象
     2、动态添加属性的key ,获取值得时候使用
     3、动态添加的属性值
     4、对象的引用关系   (OBJC_ASSOCIATION_RETAIN_NONATOMIC)关联 保持 非原子
     */
    
    objc_setAssociatedObject(self, kPropertiesListKey, array.copy, OBJC_ASSOCIATION_RETAIN_NONATOMIC);
    
    return array.copy;  //把数组的copy 返回过去
}



/*
  动态获取属性名称

 获取类的属性列表class_copyPropertyList
 遍历列表 获取 属性名称  property_getName
 添加到 OC数组

 */
+ (NSArray *)cz_objPropertyArray
{
    //获取本类 的属性拷贝
    unsigned int count = 0;    //属性列表数组
    objc_property_t *property =  class_copyPropertyList([self class], &count);
    
    
    NSMutableArray *array = [NSMutableArray array];
    
    for (unsigned int i = 0; i < count; i++) {
        
        //指针    C语言中 每个数组的名字 是第一个元素的指针
        objc_property_t pty = property[i];
        //获取的C的字符串
       const char *cName =  property_getName(pty);
        
        //转化为OC 字符串
        NSString *name = [NSString stringWithCString:cName encoding:NSUTF8StringEncoding];
        
        //添加到数组里面
        [array addObject:name];
        
    }
    
    //释放属性列表数组
    free(property);
    
    return array.copy;
}


//字典转模型

/*
    1、先初始化该类
    2、获取该类的属性列表
    3、遍历字典  使用KVC 把字典里面的值 赋值给类对象
 */
+ (instancetype)initWithDict:(NSDictionary *)dict
{
    
    id object = [[self alloc]init];
    
    //获取类的属性列表
    NSArray *proList = [self cz_objPropertyArray];
    
    //遍历字典
    [dict enumerateKeysAndObjectsUsingBlock:^(id  _Nonnull key, id  _Nonnull obj, BOOL * _Nonnull stop) {
        
        //判断字典里的key 是不是包含在数组里面
        if ([proList containsObject:key]) {
            
            //使用KVC 给类对象赋值
            [object setValue:obj forKey:key];
        }
        
    }];
    
    return object;
    
}















@end
