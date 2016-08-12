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
#define YSColorRGB(red, green, blue) [UIColor colorWithRed:red/255.0 green:green/255.0 blue:blue/255.0 alpha:1.0]

#define YSColorRGBAlpha(red, green, blue, alpha) [UIColor colorWithRed:red/255.0 green:green/255.0 blue:blue/255.0 alpha:alpha]

#define UIColorFromRGB(rgbValue) [UIColor colorWithRed:((float)((rgbValue & 0xFF0000) >> 16))/255.0 green:((float)((rgbValue & 0xFF00) >> 8))/255.0 blue:((float)(rgbValue & 0xFF))/255.0 alpha:1.0] 


#define YSColorDefault [UIColor colorWithRed:153.0/255.0 green:230.0/255.0 blue:240.0/255.0 alpha:1.0]


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
