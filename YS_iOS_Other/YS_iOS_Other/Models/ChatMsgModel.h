//
//  ChatMsgModel.h
//  YS_iOS_Other
//
//  Created by YJ on 16/12/19.
//  Copyright © 2016年 YJ. All rights reserved.
//

#import <Foundation/Foundation.h>

typedef NS_ENUM(NSInteger, ChatMsgType)
{
    ChatMsgTypeText,
    ChatMsgTypeImage,
    ChatMsgTypeAudio,
    ChatMsgTypeVideo
};

@interface ChatMsgModel : NSObject

@property (nonatomic, strong) NSString * msgId;
@property (nonatomic, strong) NSString * msgTime;
@property (nonatomic, assign) ChatMsgType msgType;
@property (nonatomic, strong) NSString * userName;
@property (nonatomic, strong) NSString * userHeadImage;

@end
