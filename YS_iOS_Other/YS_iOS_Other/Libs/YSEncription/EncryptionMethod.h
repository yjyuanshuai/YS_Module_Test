//
//  EncryptionMethod.h
//  EncryptionTest
//
//  Created by YJ on 16/1/4.
//  Copyright © 2016年 YJ. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface EncryptionMethod : UIViewController

/*******    加密  ************/
+ (NSString *)md5StringFromText:(NSString *)str;
+ (NSString *)base64StringFromText:(NSString *)text;
+ (NSString *)base64EncodedStringFrom:(NSData *)data;
+ (NSString *)encryptSting:(NSString *)sText key:(NSString *)key andDesiv:(NSString *)ivDes;
+ (NSData *)AES128EncryptWithKey:(NSString *)key iv:(NSString *)iv withNSData:(NSData *)data;
+ (NSData *)dataWithBase64EncodedString:(NSString *)string;

/*******    解密  ************/
+ (NSString *)textFromBase64String:(NSString *)base64;
+ (NSString *)decryptWithDESString:(NSString *)sText key:(NSString *)key andiV:(NSString *)iv;
+ (NSData *)AES128DecryptWithKey:(NSString *)key iv:(NSString *)iv withNSData:(NSData *)data;


@end
