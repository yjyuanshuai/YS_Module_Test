//
//  GlobalString.h
//  YS_iOS_Other
//
//  Created by YJ on 16/6/17.
//  Copyright © 2016年 YJ. All rights reserved.
//

#ifndef GlobalString_h
#define GlobalString_h

/*********  一些全局定义 **********************/

#define kScreenWidth    [UIScreen mainScreen].bounds.size.width
#define kScreenHeight   [UIScreen mainScreen].bounds.size.height

#define kAPPKeyWindow   [UIApplication sharedApplication].keyWindow

#define kSystemVersion  [[[UIDevice currentDevice] systemVersion] floatValue]





/*********  用户偏好设置有关 *******************/
#define UserRememberPassWord    @"UserRememberPassWord"
#define UserName                @"UserName"
#define UserPassWord            @"UserPassWord"





/*********  百度地图 *******************/

#define kBaiduMapAK     @"0o1W98wXRSCK6dgQoxl2T6XMEnGQIK2L"

#endif /* GlobalString_h */
