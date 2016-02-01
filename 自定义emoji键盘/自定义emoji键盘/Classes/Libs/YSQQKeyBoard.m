//
//  YSQQKeyBoard.m
//  自定义emoji键盘
//
//  Created by YJ on 16/2/1.
//  Copyright © 2016年 YJ. All rights reserved.
//

#import "YSQQKeyBoard.h"

#define YSKeyBoard_Screen_Width [[UIScreen mainScreen] bounds].size.width
#define YSKeyBoard_Screen_Height [[UIScreen mainScreen] bounds].size.height

#define HEL_15 [UIFont fontWithName:@"Helvetica" size:15.0f]

static CGFloat YSKeyBoard_BGImageView_Origin_Height = 49 * 2;
static CGFloat YSKeyBoard_ToolBar_Height = 49;
static CGFloat YSKeyBoard_TextView_Origin_Height = 49;
static CGFloat padding_x = 10;
static CGFloat padding_y = 7;

@implementation YSQQKeyBoard
{
    UIBarButtonItem * _voiceItem;
    UIBarButtonItem * _vedioItem;
    UIBarButtonItem * _photoLibraryItem;
    UIBarButtonItem * _photoCamareItem;
    UIBarButtonItem * _emojiItem;
    UIBarButtonItem * _functionsItem;
    
    UIViewController * _viewController;
}


- (instancetype)init
{
    if (self = [super init]) {
        
        [self initUI];
        [self addObserverOfKeyBoard];
    
    }
    return self;
}

- (void)dealloc
{
    //移除所有通知
    [[NSNotificationCenter defaultCenter] removeObserver:self];
}

- (void)addInViewController:(UIViewController *)viewController
{
    _viewController = viewController;
    [self updateToolBarItemsImage];
    [_viewController.view addSubview:self.bgImageView];
}

#pragma mark - UITextViewDelegate -
- (BOOL)textViewShouldBeginEditing:(UITextView *)textView
{
    [textView becomeFirstResponder];
    return YES;
}

- (void)textViewDidChange:(UITextView *)textView
{

}

- (void)textViewDidEndEditing:(UITextView *)textView
{
    [textView resignFirstResponder];
}

#pragma mark - toolBar上的功能方法 -
/**
 *  发送语音
 */
- (void)sendVoice
{

}

/**
 *  发送视频，调用相机录像
 */
- (void)sendVedio
{

}

/**
 *  发送照片，调用相册
 */
- (void)sendPhotoFromLibrary
{

}

/**
 *  发送照片，调用相机
 */
- (void)sendPhotoFromCamare
{

}

/**
 *  发送表情
 */
- (void)sendEmoji
{

}

/**
 *  查看全部功能
 */
- (void)checkAllFunction
{

}

#pragma mark - 内部方法 -
- (void)initUI
{
    // 背景
    self.bgImageView = [[UIImageView alloc] initWithFrame:CGRectMake(0, YSKeyBoard_Screen_Height - YSKeyBoard_BGImageView_Origin_Height, YSKeyBoard_Screen_Width, YSKeyBoard_BGImageView_Origin_Height)];
    self.bgImageView.backgroundColor = [UIColor redColor];
    self.bgImageView.userInteractionEnabled = YES;
    
    
    // textView
    self.ysTextView = [[UITextView alloc] initWithFrame:CGRectMake(padding_x    , padding_y, YSKeyBoard_Screen_Width - padding_x * 2, YSKeyBoard_TextView_Origin_Height - padding_y * 2)];
    self.ysTextView.layer.masksToBounds = YES;
    self.ysTextView.layer.cornerRadius = 5;
    self.ysTextView.font = HEL_15;
    self.ysTextView.textAlignment = NSTextAlignmentLeft;
    self.ysTextView.delegate = self;
    [self.bgImageView addSubview:self.ysTextView];
    
    
    // toolBar
    self.ysToolBar = [[UIToolbar alloc] initWithFrame:CGRectMake(0, YSKeyBoard_BGImageView_Origin_Height - YSKeyBoard_ToolBar_Height, YSKeyBoard_Screen_Width, YSKeyBoard_ToolBar_Height)];
    self.ysToolBar.barStyle = UIBarStyleDefault;
    self.ysToolBar.barTintColor = [UIColor clearColor];
    self.ysToolBar.translucent = NO;
//    self.ysToolBar.backgroundColor = [UIColor clearColor];
    
    
    // -- 占位
    UIBarButtonItem * spaceItem = [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemFlexibleSpace target:self action:nil];
    
    UIImage * commonImage = [self getOriginImage:@"toolBar"];
    // -- 语音
    _voiceItem = [[UIBarButtonItem alloc] initWithImage:commonImage style:UIBarButtonItemStylePlain target:self action:@selector(sendVoice)];
    
    // -- 视频
    _vedioItem = [[UIBarButtonItem alloc] initWithImage:commonImage style:UIBarButtonItemStylePlain target:self action:@selector(sendVedio)];
    
    // -- 相册
    _photoLibraryItem = [[UIBarButtonItem alloc] initWithImage:commonImage style:UIBarButtonItemStylePlain target:self action:@selector(sendPhotoFromLibrary)];
    
    // -- 相机
    _photoCamareItem = [[UIBarButtonItem alloc] initWithImage:commonImage style:UIBarButtonItemStylePlain target:self action:@selector(sendPhotoFromCamare)];
    
    // -- 表情（emoji / qq）
    _emojiItem = [[UIBarButtonItem alloc] initWithImage:commonImage style:UIBarButtonItemStylePlain target:self action:@selector(sendEmoji)];
    
    // -- 全部功能
    _functionsItem = [[UIBarButtonItem alloc] initWithImage:commonImage style:UIBarButtonItemStylePlain target:self action:@selector(checkAllFunction)];
    
    self.ysToolBar.items = @[spaceItem, _voiceItem, spaceItem, _vedioItem, spaceItem, _photoLibraryItem, spaceItem, _photoCamareItem, spaceItem, _emojiItem, spaceItem, _functionsItem, spaceItem];
    [self.bgImageView addSubview:self.ysToolBar];
    
}

- (UIImage *)getOriginImage:(NSString *)imageStr
{
    UIImage * image = [UIImage imageNamed:imageStr];
    return [image imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal];
}

- (void)addObserverOfKeyBoard
{
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(keyBoardWillShow:) name:UIKeyboardWillShowNotification object:nil];
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(keyBoardWillHide:) name:UIKeyboardWillHideNotification object:nil];
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(textViewDidChange:) name:UITextViewTextDidChangeNotification object:nil];
}

- (void)updateToolBarItemsImage
{
    // toolBar 图标
    if (self.toolBarImageArr && [self.toolBarImageArr count] >= 6) {
        _voiceItem.image = [self.toolBarImageArr objectAtIndex:0];
        _vedioItem.image = [self.toolBarImageArr objectAtIndex:1];
        _photoLibraryItem.image = [self.toolBarImageArr objectAtIndex:2];
        _photoCamareItem.image = [self.toolBarImageArr objectAtIndex:3];
        _emojiItem.image = [self.toolBarImageArr objectAtIndex:4];
        _functionsItem.image = [self.toolBarImageArr objectAtIndex:5];
    }
}

- (void)updateFrameWithKeyBoardRect:(CGRect)keyBoardRect
{
    if (keyBoardRect.origin.x == 0 && keyBoardRect.origin.y && keyBoardRect.size.width == 0 && keyBoardRect.size.height == 0) {
        
        dispatch_async(dispatch_get_main_queue(), ^{
            self.bgImageView.frame = CGRectMake(0, YSKeyBoard_Screen_Height - YSKeyBoard_BGImageView_Origin_Height, YSKeyBoard_Screen_Width, YSKeyBoard_BGImageView_Origin_Height);
        });
        
    }else {
        
        dispatch_async(dispatch_get_main_queue(), ^{
           self.bgImageView.frame = CGRectMake(0, YSKeyBoard_Screen_Height - YSKeyBoard_BGImageView_Origin_Height - keyBoardRect.size.height, YSKeyBoard_Screen_Width, YSKeyBoard_BGImageView_Origin_Height);
        });
        
    }
}

#pragma mark - 键盘通知方法 -
- (void)keyBoardWillShow:(NSNotification *)keyBoard
{
    // 键盘将出，调整frame
    
    // 得到键盘 rect
    CGRect keyBoardRect = [[[keyBoard userInfo] objectForKey:UIKeyboardFrameEndUserInfoKey] CGRectValue];
    
    [self updateFrameWithKeyBoardRect:keyBoardRect];
}

- (void)keyBoardWillHide:(NSNotification *)keyBoard
{
    [self updateFrameWithKeyBoardRect:CGRectZero];
}

@end
