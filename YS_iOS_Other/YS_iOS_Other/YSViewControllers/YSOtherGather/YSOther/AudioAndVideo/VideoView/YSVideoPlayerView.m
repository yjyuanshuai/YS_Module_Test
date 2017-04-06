//
//  YSVedioPlayerView.m
//  YS_iOS_Other
//
//  Created by YJ on 17/4/5.
//  Copyright © 2017年 YJ. All rights reserved.
//

#import "YSVideoPlayerView.h"

static YSVideoPlayerView * instance = nil;

@implementation YSVideoPlayerView

+ (instancetype)shareVideoPlayerView
{
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        instance = [[YSVideoPlayerView alloc] initWithFrame:CGRectMake(0, 0, kScreenWidth, 0.75*kScreenWidth)];
    });
    return instance;
}

- (void)updateVideoPlayerViewWithFrame:(CGRect)frame
{
    instance.frame = frame;
}

- (void)updateVideoPlayerViewWithIsLandScape:(BOOL)isLandScape
{
    _isLandScape = isLandScape;
}





#pragma mark - 
+ (instancetype)allocWithZone:(struct _NSZone *)zone
{
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        instance = [super allocWithZone:zone];
    });
    return instance;
}

- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        self.backgroundColor = [UIColor greenColor];
        _isLandScape = NO;
        [self createSubViews];
    }
    return self;
}

- (void)createSubViews
{
    self.spaceBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    [self.spaceBtn setBackgroundImage:[UIImage imageNamed:@"tab_fiv_sel"] forState:UIControlStateNormal];
    [self.spaceBtn addTarget:self action:@selector(clickBtn) forControlEvents:UIControlEventTouchUpInside];
    [self addSubview:self.spaceBtn];
    
    _imageView = [UIImageView new];
    _imageView.image = [UIImage imageWithContentsOfFile:[[NSBundle mainBundle] pathForResource:@"5" ofType:@"jpg"]];
    [self addSubview:_imageView];
    
    [self.spaceBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.size.mas_equalTo(CGSizeMake(40, 40));
        make.right.equalTo(self);
        make.bottom.equalTo(self);
    }];
    
    [_imageView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.size.mas_equalTo(CGSizeMake(200, 200));
        make.center.equalTo(self);
    }];
}

- (void)clickBtn
{
    if (_delegate && [_delegate respondsToSelector:@selector(clickSpaceBtn)]) {
        [_delegate clickSpaceBtn];
    }
}



@end
