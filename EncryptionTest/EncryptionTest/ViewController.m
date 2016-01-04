//
//  ViewController.m
//  EncryptionTest
//
//  Created by YJ on 16/1/4.
//  Copyright © 2016年 YJ. All rights reserved.
//

#import "ViewController.h"
#import "NSString+Utility.h"
#import <CommonCrypto/CommonDigest.h>

@interface ViewController ()<UITextFieldDelegate>

@property (weak, nonatomic) IBOutlet UITextField *text;
- (IBAction)md5Encrypte:(id)sender;
- (IBAction)md5UnEncrypte:(id)sender;
- (IBAction)base64Encrypte:(id)sender;
- (IBAction)base64UnEncrypte:(id)sender;
- (IBAction)desEncrypt:(id)sender;
- (IBAction)desDecrypt:(id)sender;
- (IBAction)aesEncrypt:(id)sender;
- (IBAction)aesDecrypt:(id)sender;



@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


#pragma mark - MD5
- (IBAction)md5Encrypte:(id)sender {
    NSString * textToEncrypte = _text.text;
    
    NSString * encryptionStr = [NSString md5StringFromText:textToEncrypte];
    _text.text = encryptionStr;
    
}

- (IBAction)md5UnEncrypte:(id)sender {
    
    
}

#pragma mark - Base64
- (IBAction)base64Encrypte:(id)sender {
    
    NSString * encryptionStr = [NSString base64StringFromText:_text.text];
    _text.text = encryptionStr;
}

- (IBAction)base64UnEncrypte:(id)sender {
    
    NSString * decryptionStr = [NSString textFromBase64String:_text.text];
    _text.text = decryptionStr;
}

- (IBAction)desEncrypt:(id)sender {
    
    
}

- (IBAction)desDecrypt:(id)sender {
}

- (IBAction)aesEncrypt:(id)sender {
}

- (IBAction)aesDecrypt:(id)sender {
}

#pragma mark - 加密算法
// 1、 MD5
//+ (NSString *)md5WithString:(NSString *)str{
//    
//    /*
//     1、导入头文件  <CommonCrypto/CommonDigest.h>
//     2、CC_MD5 函数
//     */
//    if ([NSString isBlankString:str]) {
//        return nil;
//    }
//    
//    const char * cStr = [str UTF8String];
//    unsigned char result[16];
//    CC_MD5(cStr, (CC_LONG)strlen(cStr), result);
//    return [NSString stringWithFormat:@"%X%X%X%X%X%X%X%X%X%X%X%X%X%X%X%X", result[0], result[1], result[2], result[3], result[4], result[5], result[6], result[7], result[8], result[9], result[10], result[11], result[12], result[13], result[14], result[15]];
//}


// 2、Base64

// 3、DES

// 4、AES



#pragma mark - UITextFeildDelegate
- (BOOL)textFieldShouldBeginEditing:(UITextField *)textField
{
    return YES;
}

- (BOOL)textFieldShouldReturn:(UITextField *)textField
{
    [textField resignFirstResponder];
    return YES;
}

- (void)textFieldDidBeginEditing:(UITextField *)textField
{

}

- (void)textFieldDidEndEditing:(UITextField *)textField
{
    [textField resignFirstResponder];
}

#pragma mark -

- (BOOL)isBlankString:(NSString *)str
{
    if ([str isEqualToString:@""] || [str isKindOfClass:[NSNull class]] || [str isEqual:nil]) {
        return YES;
    }
    return NO;
}



@end
