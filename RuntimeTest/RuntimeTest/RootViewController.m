//
//  RootViewController.m
//  RuntimeTest
//
//  Created by YJ on 16/1/5.
//  Copyright © 2016年 YJ. All rights reserved.
//

#import "RootViewController.h"

@interface RootViewController ()

@end

@implementation RootViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    [self performSelector:@selector(doSomething)];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


#pragma mark - 
+ (BOOL)resolveInstanceMethod:(SEL)sel
{
    if (sel == @selector(doSomething)) {
        NSLog(@"\n 1、--- 执行对象中的函数IML -------\n");
        return YES;
    }
    return [super resolveInstanceMethod:sel];
}

- (id)forwardingTargetForSelector:(SEL)aSelector
{
    if (aSelector == @selector(doSomething)) {
        NSLog(@"\n 2、--- forwardingTargetForSelector ----\n");
        return nil;
    }
    return [super forwardingTargetForSelector:aSelector];
}

- (NSMethodSignature *)methodSignatureForSelector:(SEL)aSelector
{
    if (aSelector == @selector(doSomething)) {
        NSLog(@"\n 3、--- methodSignatureForSelector ----\n");
        return nil;
    }
    return [super methodSignatureForSelector:aSelector];
}

- (void)doesNotRecognizeSelector:(SEL)aSelector
{
    NSLog(@"\n 4、--- doesNotRecognizeSelector ----\n");
}

- (void)forwardInvocation:(NSInvocation *)anInvocation
{
    NSLog(@"\n 5、--- forwardInvocation ----\n");
}


@end
