//
//  MyKeyChainHelper.h
//  KeychainTest
//
//  Created by YJ on 15/12/22.
//  Copyright © 2015年 YJ. All rights reserved.
//

#import <Foundation/Foundation.h>

#define APPID @"keychainTest.com.yuanshuai"
#define ACCOUNT_NUMBER @"account_number"

@interface MyKeyChainHelper : NSObject

- (void)saveAccountWithUserName:(NSString *)userName Password:(NSString *)userPassword Service:(NSString *)service;

- (NSString *)getUserPassword;

- (NSString *)getUserName;

@end
