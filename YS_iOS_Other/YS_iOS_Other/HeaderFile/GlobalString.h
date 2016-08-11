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
#define kScreenHeightNo20       [UIScreen mainScreen].bounds.size.height - 20
#define kScreenHeightNo64       [UIScreen mainScreen].bounds.size.height - 64
#define kScreenHeightNo113      [UIScreen mainScreen].bounds.size.height - 64 - 49


#define kAPPKeyWindow   [UIApplication sharedApplication].keyWindow


#define kSystemVersion  [[[UIDevice currentDevice] systemVersion] floatValue]



/*********  颜色  ************************/
#define YSColorRGB(red, green, blue) [UIColor colorWithRed:red green:green blue:blue alpha:1.0]
#define YSColorRGBAlpha(red, green, blue, alpha) [UIColor colorWithRed:red green:green blue:blue alpha:alpha]

#define YSColorDefault [UIColor colorWithRed:25.0 green:196.0 blue:250.0 alpha:1.0]


/*********  用户偏好设置有关 *******************/
#define UserRememberPassWord    @"UserRememberPassWord"
#define UserName                @"UserName"
#define UserPassWord            @"UserPassWord"





/*********  keychain *******************/
#define KeyChainUserAccount     @"KeyChainUserAccount"
#define KeyChainUserPassword    @"KeyChainUserPassword"





/*********  百度地图 *******************/

#define kBaiduMapAK     @"0o1W98wXRSCK6dgQoxl2T6XMEnGQIK2L"




#endif /* GlobalString_h */
