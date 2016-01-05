//
//  RootViewController.m
//  RuntimeTest
//
//  Created by YJ on 16/1/5.
//  Copyright © 2016年 YJ. All rights reserved.
//

#import "RootViewController.h"
#import <objc/runtime.h>

@interface RootViewController ()

@end

@implementation RootViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
//    [self performSelector:@selector(doSomething)];
    
    [self performSelector:@selector(secondVCMethod)];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


#pragma mark - 
/*
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
*/

#pragma mark - 

/**
 *  <#Description#>
 *
 *  @param sel <#sel description#>
 *
 *  @return <#return value description#>
 */
/*
+ (BOOL)resolveInstanceMethod:(SEL)sel
{
    if (sel == @selector(doSomething)) {
        NSLog(@" --- ---");
        class_addMethod([self class], sel, (IMP)dynamicMethodIMP, "v@:");
//        class_addMethod([self class], sel, (IMP)newMethod, "i@:@");
        return YES;
    }
    return [super resolveInstanceMethod:sel];
}

/*
 * 说明 class_addMethod 函数
 * class_addMethod(<#__unsafe_unretained Class cls#>, <#SEL name#>, <#IMP imp#>, <#const char *types#>)
 * cls: 在此类中添加方法，即方法所加的类
 * name: 方法名
 * imp: 实现方法的函数
 * types: 定义的返回类型和参数类型。v@:  v(void)  @(参数，这里指id(self) )  :(指方法，这里指SEL(_cmd) )
 */

/*
void dynamicMethodIMP (id self, SEL _cmd)
{
    NSLog(@" --- 自定义函数一 ---");
}

int newMethod(id self, SEL _cmd, NSString *str)
{
    NSLog(@" --- 自定义函数二 ---");
    return 10;
}
*/

#pragma mark -
+ (BOOL)resolveInstanceMethod:(SEL)sel
{
    return [super resolveInstanceMethod:sel];
}

- (id)forwardingTargetForSelector:(SEL)aSelector
{
    Class vcClass = NSClassFromString(@"FirstViewController");
    UIViewController * vc = [vcClass new];
    if (aSelector == NSSelectorFromString(@"secondVCMethod")) {
        NSLog(@"现在是第二个界面在操作");
        return vc;
    }
    return nil;
}

@end
