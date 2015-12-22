//
//  ViewController.m
//  KeychainTest
//
//  Created by YJ on 15/12/22.
//  Copyright © 2015年 YJ. All rights reserved.
//

#import "ViewController.h"
#import "MyKeyChainHelper.h"

#define kService [NSBundle mainBundle].bundleIdentifier

@interface ViewController ()
@property (weak, nonatomic) IBOutlet UITextField *userNum;
@property (weak, nonatomic) IBOutlet UITextField *userPass;
- (IBAction)login:(UIButton *)sender;

@end

@implementation ViewController
{
    MyKeyChainHelper * keychain;
}
- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
    
    
    
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}



- (IBAction)login:(UIButton *)sender {
    
    //
    if (![_userNum.text isEqualToString:@""] && ![_userPass.text isEqualToString:@""]) {
        
        keychain = [[MyKeyChainHelper alloc] init];
        [keychain saveAccountWithUserName:_userNum.text Password:_userPass.text Service:kService];
        
        NSLog(@"------- user: %@  -------- %@", [keychain getUserName], [keychain getUserPassword]);
        
    }
    
}



@end
