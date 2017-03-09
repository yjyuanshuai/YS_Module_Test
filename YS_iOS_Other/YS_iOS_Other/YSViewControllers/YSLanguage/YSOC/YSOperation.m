//
//  YSOperation.m
//  YS_iOS_Other
//
//  Created by YJ on 17/3/9.
//  Copyright © 2017年 YJ. All rights reserved.
//

#import "YSOperation.h"

@interface YSOperation()

@end

@implementation YSOperation
{
    BOOL cancelled;
    BOOL finished;
    BOOL executing;
}

- (instancetype)init
{
    self = [super init];
    if (self) {
        
    }
    return self;
}

- (void)start
{

}

- (void)finished
{
    
}

- (void)cancel
{
    
}

/*

// 执行主任务
- (void)main
{
    // 新建一个自动释放池，如果是异步执行操作，那么将无法访问到主线程的自动释放池
    @autoreleasepool {
        
        // 如果这个 Operation 是在异步线程中执行操作，也就是说main方法在异步线程调用，那么将无法访问主线程的自动释放池，所以在第24行创建了一个属于当前线程的自动释放池
        
    }
}
 
*/

@end
