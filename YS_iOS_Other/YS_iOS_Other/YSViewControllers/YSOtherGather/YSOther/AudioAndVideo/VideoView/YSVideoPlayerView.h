//
//  YSVedioPlayerView.h
//  YS_iOS_Other
//
//  Created by YJ on 17/4/5.
//  Copyright © 2017年 YJ. All rights reserved.
//

#import <UIKit/UIKit.h>

@protocol YSVideoPlayerViewDelegate;

@interface YSVideoPlayerView : UIView

@property (nonatomic, assign) BOOL isLandScape; //是否横屏
@property (nonatomic, strong) UIImageView * imageView;
@property (nonatomic, strong) UIButton * spaceBtn;
@property (nonatomic, weak) id<YSVideoPlayerViewDelegate> delegate;

+ (instancetype)shareVideoPlayerView;
- (void)updateVideoPlayerViewWithFrame:(CGRect)frame;
- (void)updateVideoPlayerViewWithIsLandScape:(BOOL)isLandScape;

@end



@protocol YSVideoPlayerViewDelegate <NSObject>

- (void)clickSpaceBtn;

@end
