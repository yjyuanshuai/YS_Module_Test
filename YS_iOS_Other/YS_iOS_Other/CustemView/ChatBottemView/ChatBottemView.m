//
//  ChatBottemView.m
//  YS_iOS_Other
//
//  Created by YJ on 16/12/16.
//  Copyright © 2016年 YJ. All rights reserved.
//

#import "ChatBottemView.h"
#import "NSString+YSStringDo.h"

static CGFloat const CBViewMinHeight = 85;
static CGFloat const CBViewMaxHeight = 145;

@implementation ChatBottemView
{
    CGRect currentFrame;
}

- (instancetype)initWithFrame:(CGRect)frame
{
    if (self = [super initWithFrame:frame]) {
        
        [self checkFrame:frame];
        [self createSubViews];
        
    }
    return self;
}

- (CGFloat)getBottemViewHeight
{
    return self.frame.size.height;
}

- (void)receiveEmotionStr:(NSString *)emo
{
    // 获取表情
    
}

#pragma mark -
- (void)checkFrame:(CGRect)frame
{
    if (frame.size.height != CBViewMinHeight) {
        frame.size.height = CBViewMinHeight;
    }
    
    if (frame.size.width != kScreenWidth) {
        frame.size.width = kScreenWidth;
    }
    
    if (frame.origin.x != 0) {
        frame.origin.x = 0;
    }
    
    currentFrame = frame;
    self.frame = frame;
}

- (void)createSubViews
{
    self.chatTextView = [[UITextView alloc] initWithFrame:CGRectMake(5, 5, self.frame.size.width - 10, 40)];
    self.chatTextView.delegate = self;
    [self addSubview:self.chatTextView];
    
    self.emotionBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    self.emotionBtn.frame = CGRectMake(5, CGRectGetMaxY(self.chatTextView.frame) + 5, 30, 30);
    self.emotionBtn.tag = FunctionBtnTag + FunctionType_Emotion;
    [self.emotionBtn setBackgroundImage:[UIImage imageNamed:@"Expression_1"] forState:UIControlStateNormal];
    [self.emotionBtn addTarget:self action:@selector(clickShowEmotion:) forControlEvents:UIControlEventTouchUpInside];
    [self addSubview:_emotionBtn];
}

#pragma mark - click
- (void)clickShowEmotion:(UIButton *)btn
{
    [self.chatTextView resignFirstResponder];
    NSInteger tag = btn.tag - FunctionBtnTag;
    
    if (_delegate && [_delegate respondsToSelector:@selector(showFunctionViewWithTag:)]) {
        [_delegate showFunctionViewWithTag:tag];
    }
}

#pragma mark - UITextViewDelegate
- (BOOL)textViewShouldBeginEditing:(UITextView *)textView
{
    return YES;
}

- (BOOL)textView:(UITextView *)textView shouldChangeTextInRange:(NSRange)range replacementText:(NSString *)text
{
    if ([text isEqualToString:@"\n"]) {
        return YES;
    }
    
    return YES;
}

- (void)textViewDidChange:(UITextView *)textView
{
    NSString * currentText = textView.text;
    
    CGFloat currentHeight = [currentText calculateHeightWithMaxWidth:textView.frame.size.width font:textView.font miniHeight:40];
    if (currentHeight > 100) {
        currentHeight = 100;
    }
    
    // 刷新UI
    __weak typeof(self) weakSelf = self;
    
    dispatch_async(dispatch_get_main_queue(), ^{
        weakSelf.frame = CGRectMake(0, currentFrame.origin.y - (currentHeight - 40), currentFrame.size.width, currentHeight + 45);
        weakSelf.chatTextView.frame = CGRectMake(5, 5, kScreenWidth - 10, currentHeight);
    });
}

@end
