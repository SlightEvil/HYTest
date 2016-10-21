//
//  UIImageView+RuntimeCrossoverMethod.h
//  Runtime
//
//  Created by hy on 2016/10/14.
//  Copyright © 2016年 hy. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UIImageView (RuntimeCrossoverMethod)

/*
 运行时的交叉方法
 
 就3句话
 //获取 类 实例化的原始方法   setImage:
 Method originalMethod = class_getInstanceMethod([self class], @selector(setImage:));
 
 //获取 自定义的类的实例化的方法  cz_setImage:
 Method swizzleMethod = class_getInstanceMethod([self class], @selector(cz_setImage:));
 
 //交换两个方法 setImage: 和 cz_setImage:  完成之后
 //1> 调用setImage: 相当于调用 cz_setImage:
 //2> 调用 cz_setImage: 相当于调用 setImage:
 method_exchangeImplementations(originalMethod, swizzleMethod);
 
 
 
 */



@end
