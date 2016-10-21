//
//  Person.h
//  Runtime
//
//  Created by hy on 2016/10/13.
//  Copyright © 2016年 hy. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface Person : NSObject

@property (nonatomic) NSString *name;
@property (nonatomic, assign) NSInteger age;
@property (nonatomic, assign) double height;
@property (nonatomic, copy) NSString *title;

//原子性，内存管理，读写权限，可否为空，方法名
@property (nonatomic, copy, readwrite, nullable, getter=getString) NSString *str;



- (void)logPersonDestription;



@end
