//
//  NSObject+RuntimeUse.h
//  Runtime
//
//  Created by hy on 2016/10/14.
//  Copyright © 2016年 hy. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface NSObject (RuntimeUse)


/**
      根据获取的属性名  使用KVC 赋值  
    @param dict 传入的字典 映射 对象
 
    @return  赋值完毕的对象
 */
+ (instancetype)cz_objcWithDictionary:(NSDictionary *)dict;



/**
    获取 属性的名称数组
    @return  返回对象的属性名称数组
 */
+ (NSArray *)cz_objPropertiesAry;




/*
 
  runtime 使用
    1、字典转模型
    2、给分类添加关联对象
    3、交叉方法  在无法修改系统，第三方框架时
            a、利用交换方法，先执行自己的方法
            b、在执行系统或者第三方框架的方法
            c、黑魔法，对系统/框架版本有很强的依赖性
 
    #import <objc/runtime.h>
    1、动态获取类的属性等
    2、关联对象  （动态添加属性值）
    使用 runtime 的时候 一般 创建一个 NSObject 的分类  Cotegory
    3、交叉方法
            1、不用修改系统的类方法
            2、拦截系统的默认方法，提前做一些事情
 
 
    动态获取类的信息
            1、Property  属性
            2、Protocol  协议
            3、Method    方法
            4、Ivar      成员变量
 
    class_copyxxxxxListxxxx   
    xxxxGetName
 
    
    关联对象: 动态的添加属性
    参数：
    1、对象 self
    2、动态属性的 key   const void *key
 
    返回值  动态添加的 “属性值”
    objc_getAssociatedObject(self,kPropertiesListKey);
 
  ---- 2、到此为止，对象的属性数组获取完毕，利用关联对象，动态添加属性
 
    参数：
    1、对象 self [OC 中class] 也是一个特殊的对象
    2、动态添加属性的key ,获取值得时候使用
    3、动态添加的属性值
    4、对象的引用关系   (OBJC_ASSOCIATION_RETAIN_NONATOMIC)关联 保持 非原子

    objc_setAssociatedObject(self, kPropertiesListKey, array.copy, OBJC_ASSOCIATION_RETAIN_NONATOMIC);

 
    3、交换方法
    
 
 
 */





@end
