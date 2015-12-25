//
//  YJLoadingView.m
//  MBProgressHudTest
//
//  Created by YJ on 15/12/25.
//  Copyright © 2015年 YJ. All rights reserved.
//

#import "YJLoadingView.h"
#define SelfWidth self.frame.size.height
#define SelfHeight self.frame.size.width
static CGFloat miniSize = 50;
static CGFloat maxSize = 200;

@implementation YJLoadingView
{
    UIView * _contentView;
    UIImageView * _imageView;
    UILabel * _loadingLabel;
}


+ (instancetype)sharedInstance
{
    static YJLoadingView * sharedInstance;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        sharedInstance = [[YJLoadingView alloc] init];
    });
    return sharedInstance;
}

+ (void)showWithImages:(NSArray *)imageArr andText:(NSString *)loadingText
{
    
}

- (instancetype)init
{
    if (self = [super init]) {
        _alphaValue = 1.0;
        _viewSize = CGSizeMake(100, 100);
    }
    
    return self;
}


- (void)createContentView
{
    if (_viewSize.height < miniSize || _viewSize.width < miniSize) {
        _viewSize = CGSizeMake(miniSize, miniSize);
    }
    if (_viewSize.height > maxSize || _viewSize.width > maxSize) {
        _viewSize = CGSizeMake(maxSize, maxSize);
    }
    if (_viewSize.height != _viewSize.width) {
        CGFloat widthOrHeight = (_viewSize.height > _viewSize.width) ? _viewSize.height : _viewSize.width;
        _viewSize = CGSizeMake(widthOrHeight, widthOrHeight);
    }

    
    _contentView = [[UIView alloc] init];
    _contentView.bounds = CGRectMake(0, 0, _viewSize.width, _viewSize.height);
    _contentView.center = CGPointMake(SelfWidth/2, SelfHeight/2);
    _contentView.clipsToBounds = YES;
    _contentView.layer.cornerRadius = 5;
    _contentView.alpha = _alphaValue;
    _contentView.backgroundColor = [UIColor redColor];
    
    [self addSubview:_contentView];
    
    _imageView = [[UIImageView alloc] init];
    _imageView.bounds = CGRectMake(0, 0, _viewSize.width, _viewSize.height);
    _imageView.center = CGPointMake(SelfWidth/2, SelfHeight/2);
    _imageView.hidden = YES;
    [self addSubview:_imageView];
    
    _loadingText = [[UILabel alloc] init];
}

@end
