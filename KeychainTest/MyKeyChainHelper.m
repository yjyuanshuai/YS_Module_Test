//
//  MyKeyChainHelper.m
//  KeychainTest
//
//  Created by YJ on 15/12/22.
//  Copyright © 2015年 YJ. All rights reserved.
//

#import "MyKeyChainHelper.h"
#import "KeychainItemWrapper.h"

@implementation MyKeyChainHelper
{
    KeychainItemWrapper * _wrapper;
}


- (void)saveAccountWithUserName:(NSString *)userName Password:(NSString *)userPassword Service:(NSString *)service
{
    _wrapper = [[KeychainItemWrapper alloc] initWithIdentifier:ACCOUNT_NUMBER accessGroup:nil];
    
    [_wrapper setObject:userName forKey:(id)kSecAttrAccount];
    [_wrapper setObject:userPassword forKey:(id)kSecValueData];
    [_wrapper setObject:service forKey:(id)kSecAttrService];
}


- (NSString *)getUserPassword
{
    return [_wrapper objectForKey:(id)kSecValueData];
}


- (NSString *)getUserName
{
    return [_wrapper objectForKey:(id)kSecAttrAccount];
}

@end
