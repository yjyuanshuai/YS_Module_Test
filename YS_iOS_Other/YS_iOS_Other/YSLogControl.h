//
//  YSLogControl.h
//  YS_iOS_Other
//
//  Created by YJ on 16/6/21.
//  Copyright © 2016年 YJ. All rights reserved.
//

#ifndef YSLogControl_h
#define YSLogControl_h


// __OBJC__ 这个宏，在所有的.m 和 .mm 文件中默认就定义了这个宏
#ifdef __OBJC__
// 如果这个全局的头文件或者宏只需要在 .m 或者 .mm 文件中使用，请把该头文件或宏写到 #ifdef __OBJC__ 中

    #import <UIKit/UIKit.h>
    #import <Foundation/Foundation.h>


#ifdef  DEBUG

// ... 指接收可变参数
#define NJLog(...) NSLog(__VA_ARGS__)

#else

#define NJLog(...)

#endif



#endif


#endif /* YSLogControl_h */
