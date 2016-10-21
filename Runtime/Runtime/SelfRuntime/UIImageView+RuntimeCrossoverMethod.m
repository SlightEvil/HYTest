//
//  UIImageView+RuntimeCrossoverMethod.m
//  Runtime
//
//  Created by hy on 2016/10/14.
//  Copyright © 2016年 hy. All rights reserved.
//

#import "UIImageView+RuntimeCrossoverMethod.h"

#import <objc/runtime.h>


@implementation UIImageView (RuntimeCrossoverMethod)


//在类 被加载到运行时的时候，就会执行
+ (void)load{
    
    //交叉方法  就下面的3句话
    
    //获取 类 实例化的原始方法   setImage:
    Method originalMethod = class_getInstanceMethod([self class], @selector(setImage:));
    
    //获取 自定义的类的实例化的方法  cz_setImage:
    Method swizzleMethod = class_getInstanceMethod([self class], @selector(cz_setImage:));
    
    //交换两个方法 setImage: 和 cz_setImage:  完成之后
    //1> 调用setImage: 相当于调用 cz_setImage:
    //2> 调用 cz_setImage: 相当于调用 setImage:
    method_exchangeImplementations(originalMethod, swizzleMethod);
}

//自定义 的 类 的实例化方法  Cotegory
- (void)cz_setImage:(UIImage *)image
{
    //这里是我们想要做的事情
    DLog(@"调用的自定义的方法： %s",__FUNCTION__);
    
    //1、根据 imageView 的大小 自动调整 image 的大小
    //使用 CG 重新生成一张和目标尺寸相同的图片
    UIGraphicsBeginImageContextWithOptions(self.bounds.size, YES, 0);
    
    //图片拉伸到目标尺寸
    [image drawInRect:self.bounds];
    
    //取得图片
    UIImage *result = UIGraphicsGetImageFromCurrentImageContext();
    
    //关闭上下文
    UIGraphicsEndImageContext();
    
    //再调用系统 的默认方法
    /*重点 :
            为什么 方法名是自定义方法 而不是系统默认的方法名字
            是因为load 里面 系统默认方法和自定义的方法进行了交换  
            系统默认的方法 setImage: 变成了 cz_setImage: 
            所以 在交换方法完成之后 再次调用系统默认的方法就变成了 我们自定义的方法
     
     */
    [self cz_setImage:result];
}




@end
