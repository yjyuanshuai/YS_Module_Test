//
//  ChatBottemView.h
//  YS_iOS_Other
//
//  Created by YJ on 16/12/16.
//  Copyright © 2016年 YJ. All rights reserved.
//

#import <UIKit/UIKit.h>
@class EmotionModel;

static NSInteger const FunctionBtnTag = 20161216;

typedef NS_ENUM(NSInteger, FunctionType)
{
    FunctionType_Emotion        // 表情
};

@protocol ChatBottemViewDelegate <NSObject>

// 显示功能界面
- (void)showFunctionViewWithTag:(FunctionType)functionType;

@end

@interface ChatBottemView : UIView <UITextViewDelegate>

@property (nonatomic, strong) UITextView * chatTextView;
@property (nonatomic, strong) UIButton * emotionBtn;
@property (nonatomic, weak) id<ChatBottemViewDelegate> delegate;
@property (nonatomic, assign) CGRect currentFrame;

- (instancetype)initWithFrame:(CGRect)frame;
- (CGFloat)getBottemViewHeight;
- (void)receviceEmoStr:(id)model;
- (void)clearChatText;

@end
