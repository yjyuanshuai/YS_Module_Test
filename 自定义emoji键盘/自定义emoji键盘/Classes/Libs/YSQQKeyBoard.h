//
//  YSQQKeyBoard.h
//  自定义emoji键盘
//
//  Created by YJ on 16/2/1.
//  Copyright © 2016年 YJ. All rights reserved.
//

/**
 *
 */

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>

@interface YSQQKeyBoard : NSObject <UITextViewDelegate>

@property (nonatomic, strong) UIToolbar * ysToolBar;
@property (nonatomic, strong) UIImageView * bgImageView;    //背景
@property (nonatomic, strong) UITextView * ysTextView;
@property (nonatomic, strong) NSArray * toolBarImageArr;    //toolBar图片
//@property (nonatomic, )

- (void)addInViewController:(UIViewController *)viewController;

@end
