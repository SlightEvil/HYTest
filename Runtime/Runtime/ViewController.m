//
//  ViewController.m
//  Runtime
//
//  Created by hy on 2016/10/13.
//  Copyright © 2016年 hy. All rights reserved.
//

#import "ViewController.h"

#import "Person.h"
#import "Person+Cotegory.h"


#import "NSObject+Runtime.h"
#import "NSObject+RuntimeUse.h"
#import "UIImageView+RuntimeCrossoverMethod.h"



#import <AVFoundation/AVFoundation.h>



#import <objc/runtime.h>




@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    //目标  1 获取属性数组
    //2 、使用KVC 设置值  字典转模型
    
    //获取Persion的属性列表数组
    NSArray *properties =   [Person cz_objPropertiesAry];
    DLog(@"%@",properties);
    
    NSDictionary *dic = @{@"name":@"张三",@"age":@(22),@"height":@(168),@"title":@"运行时",@"place":@"boss",@"address":@"China",@"phoneNumber":@"10086"};
    Person *persion = [Person cz_objcWithDictionary:dic];
    
    
    [persion logPersonDestription];
    
    [persion helloWorld];
    
    
    UIImageView *imageView = [[UIImageView alloc]initWithFrame:CGRectMake(0, 0, 200, 200)];
    imageView.center = self.view.center;
    [self.view addSubview:imageView];
    
    imageView.image = [UIImage imageNamed:@"image5.png"];
    
    

  
    
}





- (void)sendMessage:(NSString *)message
{
    DLog(@"message%@",message);
}




- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


@end
