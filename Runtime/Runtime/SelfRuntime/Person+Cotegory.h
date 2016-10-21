//
//  Person+Cotegory.h
//  Runtime
//
//  Created by hy on 2016/10/17.
//  Copyright © 2016年 hy. All rights reserved.
//

#import "Person.h"

@interface Person (Cotegory)


//添加属性
@property (nonatomic, copy) NSString *address;
@property (nonatomic, copy) NSString *phoneNumber;

//添加方法
- (void)helloWorld;








/*
 runtime 
    1、动态获取 类 的属性，方法，delegate，成员变量Ivar
    2、关联对象 动态获取，添加 属性值
    3、交换方法  在不改变原方法的基础上 把默认方法 替换成自定义的方法，再调用默认方法
 
 */



@end
