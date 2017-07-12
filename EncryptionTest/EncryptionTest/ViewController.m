//
//  ViewController.m
//  EncryptionTest
//
//  Created by YJ on 16/1/4.
//  Copyright © 2016年 YJ. All rights reserved.
//

#import "ViewController.h"
#import "YSEnDecryptionMethod.h"

static NSString * des_key = @"DES_KEY";
static NSString * aes_key = @"AES_KEY";


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
    
    NSString * encryptionStr = [YSEnDecryptionMethod encryptMD5StrForString: textToEncrypte];
    _text.text = encryptionStr;
    
}

- (IBAction)md5UnEncrypte:(id)sender {
    
    
}

#pragma mark - Base64
- (IBAction)base64Encrypte:(id)sender {
    
    NSString * encryptionStr = [YSEnDecryptionMethod encryptBase64StrForString: _text.text];
    _text.text = encryptionStr;
}

- (IBAction)base64UnEncrypte:(id)sender {
    
    NSString * decryptionStr = [YSEnDecryptionMethod decryptBase64StrForString:_text.text];
    _text.text = decryptionStr;
}

#pragma mark - DES
- (IBAction)desEncrypt:(id)sender {
    
    NSString * encryptionStr = [YSEnDecryptionMethod encryptDESStrForSting:_text.text key:des_key andDesiv:des_key];
    _text.text = encryptionStr;
}

- (IBAction)desDecrypt:(id)sender {
    NSString * decryptionStr = [YSEnDecryptionMethod decryptDESStrForString:_text.text key:des_key andiV:des_key];
    _text.text = decryptionStr;
}

#pragma mark - AES
- (IBAction)aesEncrypt:(id)sender {
    
//    NSData * encryptionData = [YSEnDecryptionMethod encryptAES128DataForData:[_text.text dataUsingEncoding:NSUTF8StringEncoding] Key:aes_key iv:aes_key];
//    
//    NSString * encryptionStr = [YSEnDecryptionMethod encryptbase64StrforData:encryptionData];
    
    NSString * encryptionStr = [YSEnDecryptionMethod encryptAES128StrForString:_text.text Key:aes_key iv:aes_key];
    _text.text = encryptionStr;
}

- (IBAction)aesDecrypt:(id)sender {

//    NSData * base64Data = [YSEnDecryptionMethod decryptBase64DataForString:_text.text];
//    NSData * decryptionData = [YSEnDecryptionMethod decryptAES128DataForData:base64Data Key:aes_key iv:aes_key];
//    NSString * decrytionStr = [YSEnDecryptionMethod  encryptbase64StrforData:decryptionData];
//    NSString * result = [YSEnDecryptionMethod decryptBase64StrForString:decrytionStr];
    
    NSString * result = [YSEnDecryptionMethod decryptAES128StrForString:_text.text Key:aes_key iv:aes_key];
    _text.text = result;

}


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

- (void)textFieldDidEndEditing:(UITextField *)textField
{
    [textField resignFirstResponder];
}


@end
