//
//  YSButton.h
//  YS_iOS_Other
//
//  Created by YJ on 16/8/18.
//  Copyright © 2016年 YJ. All rights reserved.
//

#import <UIKit/UIKit.h>

typedef NS_ENUM(NSInteger, ImagePostion)
{
    ImagePostionTop,
    ImagePostionLeft,
    ImagePostionBottem,
    ImagePostionRight
};

@interface YSButton : UIControl

@property (nonatomic, strong) UILabel * btnTitle;
@property (nonatomic, strong) UIImageView * btnImageView;

@property (nonatomic, assign) ImagePostion imagePostion;

@property (nonatomic, strong) UIColor * ysBtnTintColor;
@property (nonatomic, strong) UIColor * ysTintColor;

@property (nonatomic, assign) NSInteger marginX;    // 左右距离边框距离
@property (nonatomic, assign) NSInteger marginY;    // 上下距离边框距离
@property (nonatomic, assign) NSInteger space;      // title 和 imageview 距离

@property (nonatomic, strong) NSMutableArray * constraintsArr;


- (instancetype)initWithFrame:(CGRect)frame;
- (instancetype)initWithFrame:(CGRect)frame imagePostion:(ImagePostion)postion;

@end
