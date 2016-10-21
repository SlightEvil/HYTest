//
//  NSObject+Runtime.h
//  Runtime
//
//  Created by hy on 2016/10/13.
//  Copyright © 2016年 hy. All rights reserved.
//


/*
 运行时 
 1、动态获取类的属性
 2、建立NSObject 的分类  Cotegory
 
 
 
 运行时 是C语言
 */

#import <Foundation/Foundation.h>

@interface NSObject (Runtime)

/**
 *  给定一个字典 创建 self 类对应的对象
 * @param  dict 字典
 
 *  @return  self 类对应的对象
 */
+ (instancetype)cz_objWithDict:(NSDictionary *)dict;


/**
 *  获取类的属性列表数组
 */
+ (NSArray *)cz_objProperties;



@end
