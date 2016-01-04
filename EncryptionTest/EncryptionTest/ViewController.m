//
//  ViewController.m
//  EncryptionTest
//
//  Created by YJ on 16/1/4.
//  Copyright © 2016年 YJ. All rights reserved.
//

#import "ViewController.h"
#import "EncryptionMethod.h"

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
    
    NSString * encryptionStr = [EncryptionMethod md5StringFromText:textToEncrypte];
    _text.text = encryptionStr;
    
}

- (IBAction)md5UnEncrypte:(id)sender {
    
    
}

#pragma mark - Base64
- (IBAction)base64Encrypte:(id)sender {
    
    NSString * encryptionStr = [EncryptionMethod base64StringFromText:_text.text];
    _text.text = encryptionStr;
}

- (IBAction)base64UnEncrypte:(id)sender {
    
    NSString * decryptionStr = [EncryptionMethod textFromBase64String:_text.text];
    _text.text = decryptionStr;
}

#pragma mark - DES
- (IBAction)desEncrypt:(id)sender {
    
    NSString * encryptionStr = [EncryptionMethod encryptSting:_text.text key:des_key andDesiv:des_key];
    _text.text = encryptionStr;
}

- (IBAction)desDecrypt:(id)sender {
    NSString * decryptionStr = [EncryptionMethod decryptWithDESString:_text.text key:des_key andiV:des_key];
    _text.text = decryptionStr;
}

#pragma mark - AES
- (IBAction)aesEncrypt:(id)sender {
    
    NSData * encryptionData = [EncryptionMethod AES128EncryptWithKey:aes_key iv:aes_key withNSData:[_text.text dataUsingEncoding:NSUTF8StringEncoding]];
    NSString * encryptionStr = [EncryptionMethod base64EncodedStringFrom:encryptionData];
    _text.text = encryptionStr;
    
}

- (IBAction)aesDecrypt:(id)sender {
    
    NSData * base64Data = [EncryptionMethod dataWithBase64EncodedString:_text.text];
    NSData * decryptionData = [EncryptionMethod AES128DecryptWithKey:aes_key iv:aes_key withNSData:base64Data];
    NSString * decrytionStr = [EncryptionMethod base64EncodedStringFrom:decryptionData];
    NSString * result = [EncryptionMethod textFromBase64String:decrytionStr];
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
