//
//  ViewController.m
//  RuntimeGetIsa
//
//  Created by sanjia on 2018/4/28.
//  Copyright © 2018年 sanjia. All rights reserved.
//

#import "ViewController.h"

#import "ClassTwo.h"
#import <objc/runtime.h>
@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
    
    [self getIsa];
}


- (void)getIsa
{
    //ClassTwo : ClassOne，ClassOne ： NSObject
    //获取ClassTwo对应的元类的super_class
    Class currentClass = objc_getMetaClass("ClassTwo");
    Class onemeta = objc_getMetaClass("ClassOne");
    Class objectmeta = objc_getMetaClass("NSObject");
    NSLog(@"meta %p", currentClass);
    NSLog(@"meta %p", onemeta);
    NSLog(@"meta %p", objectmeta);
    //打印这些元类的super_class ClassTwo ClassOne NSObject NSObject nil
    //基元类的super_calss指向基类 基类的super_class为nil 形成闭环
    for (int i = 0; i < 5; i++) {
        NSLog(@"Following the super_class pointer %d times gives %p", i, currentClass);
        currentClass = class_getSuperclass(currentClass);
    }
    //打印ClassTwo类的super_class指向 ClassTwo ClassOne NSObject nil
    currentClass = [ClassTwo class];
    Class oneclass = [ClassOne class];
    Class objectclass = [NSObject class];
    NSLog(@"meta %p", currentClass);
    NSLog(@"meta %p", oneclass);
    NSLog(@"meta %p", objectclass);
    for (int i = 0; i < 4; i++) {
        NSLog(@"Following the super_class pointer %d times gives %p", i, currentClass);
        currentClass = class_getSuperclass(currentClass);
    }
    //打印ClassTwo的isa指向 ClassTwo nil nil nil 任何元类的isa指向基类的元类，就是nil
    currentClass = [ClassTwo class];
    NSLog(@"meta %p", currentClass);
    NSLog(@"meta %p", [ClassTwo new]);
    for (int i = 0; i < 4; i++) {
        NSLog(@"Following the isa pointer %d times gives %p", i, currentClass);
        currentClass = objc_getClass((__bridge void *)currentClass);
    }
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


@end
