//
//  YJCookieManager.m
//  EncryptionTest
//
//  Created by YJ on 16/1/4.
//  Copyright © 2016年 YJ. All rights reserved.
//

#import "YJCookieManager.h"

@implementation YJCookieManager

///增加cookies
+ (void)addCookiesToRequest:(NSMutableDictionary *)cookieDic
{
    NSEnumerator * enumeratorKey = [cookieDic keyEnumerator];
    for (NSObject * key in enumeratorKey) {
        NSHTTPCookie *userInfoCookie = [NSHTTPCookie cookieWithProperties:
                                        [NSDictionary dictionaryWithObjectsAndKeys:
                                         @".baidu.com", NSHTTPCookieDomain,
                                         @"/", NSHTTPCookiePath,
                                         [NSString stringWithFormat:@"%@",key],  NSHTTPCookieName,
                                         [NSDate dateWithTimeIntervalSinceNow:30*24*3600], NSHTTPCookieExpires,
                                         [NSString stringWithFormat:@"%@",[cookieDic objectForKey:key]], NSHTTPCookieValue,
                                         nil]];
        [[NSHTTPCookieStorage sharedHTTPCookieStorage] setCookie:userInfoCookie];
        NSHTTPCookie *txdaiCookie = [NSHTTPCookie cookieWithProperties:
                                     [NSDictionary dictionaryWithObjectsAndKeys:
                                      @".jingdong.com", NSHTTPCookieDomain,
                                      @"/", NSHTTPCookiePath,
                                      [NSString stringWithFormat:@"%@",key],  NSHTTPCookieName,
                                      [NSDate dateWithTimeIntervalSinceNow:30*24*3600], NSHTTPCookieExpires,
                                      [NSString stringWithFormat:@"%@",[cookieDic objectForKey:key]], NSHTTPCookieValue,
                                      nil]];
        [[NSHTTPCookieStorage sharedHTTPCookieStorage] setCookie:txdaiCookie];
    }
}


///删除基本cookies
+(void)deleteBaseCookie{
    NSHTTPCookie *passportCookie = [NSHTTPCookie cookieWithProperties:
                                    [NSDictionary dictionaryWithObjectsAndKeys:
                                     @".baidu.com", NSHTTPCookieDomain,
                                     @"/", NSHTTPCookiePath,
                                     @"sfut",  NSHTTPCookieName,
                                     @"", NSHTTPCookieValue,
                                     nil]];
    [[NSHTTPCookieStorage sharedHTTPCookieStorage] deleteCookie:passportCookie];
    NSHTTPCookie *txdaiCookie = [NSHTTPCookie cookieWithProperties:
                                 [NSDictionary dictionaryWithObjectsAndKeys:
                                  @".jingdong.com", NSHTTPCookieDomain,
                                  @"/", NSHTTPCookiePath,
                                  @"sfut",  NSHTTPCookieName,
                                  @"", NSHTTPCookieValue,
                                  nil]];
    [[NSHTTPCookieStorage sharedHTTPCookieStorage] deleteCookie:txdaiCookie];
}



@end
