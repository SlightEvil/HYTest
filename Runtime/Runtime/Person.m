//
//  Person.m
//  Runtime
//
//  Created by hy on 2016/10/13.
//  Copyright © 2016年 hy. All rights reserved.
//

#import "Person.h"

@implementation Person


- (NSString *)description
{
    NSArray *keys = @[@"name",@"age",@"title",@"height",@"address",@"phoneNumber"];
    
    return [self dictionaryWithValuesForKeys:keys].description;
    
}

- (void)logPersonDestription
{
    DLog(@"person 调用的方法");
}


@end
