//
//  YSActivityIndicator.m
//  加载动画Test
//
//  Created by YJ on 16/4/28.
//  Copyright © 2016年 YJ. All rights reserved.
//

#import "YSActivityIndicator.h"

@implementation YSActivityIndicator
{
    UILabel * _titleLabel;
    UILabel * _descLabel;
    NSTimer * _loadingTimer;
}

#pragma mark - class method -

+ (instancetype)showInViewController:(UIViewController *)viewController
{
    YSActivityIndicator * loadingView = [[YSActivityIndicator alloc] init];
    viewController.navigationItem.titleView = loadingView;
    [loadingView initTimer];
    loadingView.blongToViewController = viewController;
    return loadingView;
}

+ (void)hideInViewController:(UIViewController *)viewController
{
    NSString * viewTitleStr = viewController.title;
    UIView * viewTitle = viewController.navigationItem.titleView;
    if (viewTitle != nil && [viewTitle isKindOfClass:[YSActivityIndicator class]]) {
        YSActivityIndicator * indicator = (YSActivityIndicator *)viewTitle;
        [indicator invalidTimer];
        indicator.ysType = YSLoadViewTypeTextDefault;
        indicator.titleFont = [UIFont boldSystemFontOfSize:17.0];
        indicator.titleStr = viewTitleStr;
    }
}

#pragma mark - init/dealloc -
- (instancetype)init
{
    return [self initWithFrame:CGRectMake(0, 0, 120, 44)];
}

- (instancetype)initWithFrame:(CGRect)frame
{
    if (self = [super initWithFrame:frame]) {
        self.ysType = YSLoadViewTypeSystemActIndicatorDefault;
        self.ysActivityIndicatorStyle = UIActivityIndicatorViewStyleWhiteLarge;
        self.titleFont = [UIFont boldSystemFontOfSize:18.0];
        self.titleTextColor = [UIColor blackColor];
        self.titleStr = @"加载中...";
        self.descFont = [UIFont systemFontOfSize:14.0];
        self.descTextColor = [UIColor blackColor];
        self.descStr = @"数据正在加载，请稍后";
        self.overTimeInterval = 5;
        
        [self createLabels];
        [self createSystemActivityIndicator];
        [self updateLoadingView];
        [self registerKVO];
        
    }
    return self;
}

- (void)dealloc
{
    [self unregisterKVO];
}

#pragma mark - private method -
- (void)createLabels
{
    _titleLabel = [[UILabel alloc] initWithFrame:CGRectZero];
    _titleLabel.textColor       = [UIColor whiteColor];
    _titleLabel.textAlignment   = NSTextAlignmentCenter;
    _titleLabel.font            = _titleFont;
    _titleLabel.textColor       = _titleTextColor;
    _titleLabel.text            = _titleStr;
    [self addSubview:_titleLabel];
    
    _descLabel = [[UILabel alloc] initWithFrame:CGRectZero];
    _descLabel.textColor        = [UIColor whiteColor];
    _descLabel.textAlignment    = NSTextAlignmentCenter;
    _descLabel.font             = _descFont;
    _descLabel.textColor        = _descTextColor;
    _descLabel.text             = _descStr;
    [self addSubview:_descLabel];
}

- (void)createSystemActivityIndicator
{
    _ysAcitityIndicator = [[UIActivityIndicatorView alloc] initWithFrame:CGRectZero];
    [_ysAcitityIndicator setActivityIndicatorViewStyle:_ysActivityIndicatorStyle];
    [self addSubview:_ysAcitityIndicator];
}

- (void)initTimer
{
    if (_loadingTimer != nil) {
        [_loadingTimer invalidate];
        _loadingTimer = nil;
    }
    
    _loadingTimer = [NSTimer scheduledTimerWithTimeInterval:_overTimeInterval
                                                     target:self
                                                   selector:@selector(overTime)
                                                   userInfo:nil
                                                    repeats:NO];
    [[NSRunLoop currentRunLoop] addTimer:_loadingTimer forMode:NSRunLoopCommonModes];
}

- (void)invalidTimer
{
    if (_loadingTimer != nil) {
        [_loadingTimer invalidate];
        _loadingTimer = nil;
    }
}

#pragma mark - 超时 -
- (void)overTime
{
    [YSActivityIndicator hideInViewController:_blongToViewController];
}

#pragma mark - layout -
- (void)layoutSubviews
{
    CGRect screenBound  = [[UIScreen mainScreen] bounds];
    CGFloat maxWidth    = screenBound.size.width - 180;
    CGFloat maxHeight   = 44;
    
    CGSize selfSize     = CGSizeMake(maxWidth, maxHeight);
    CGPoint selfPoint   = CGPointMake(self.frame.origin.x, self.frame.origin.y);
    self.frame          = CGRectMake(selfPoint.x, selfPoint.y, selfSize.width, selfSize.height);
    
    self.autoresizingMask = UIViewAutoresizingFlexibleWidth | UIViewAutoresizingFlexibleLeftMargin | UIViewAutoresizingFlexibleRightMargin;
    self.autoresizesSubviews = YES;
    
    if (_ysType == YSLoadViewTypeSystemActIndicatorDefault) {
        
        CGSize titleSize = [_titleStr sizeWithAttributes:@{NSFontAttributeName:_titleFont}];
        
        _ysAcitityIndicator.frame = CGRectMake((selfSize.width - 40 - titleSize.width)/2, (selfSize.height - 30)/2, 30, 30);
        
        CGFloat titleHeight = MIN(titleSize.height, 30);
        _titleLabel.frame = CGRectMake(CGRectGetMaxX(_ysAcitityIndicator.frame) + 5, (selfSize.height - titleHeight)/2, titleSize.width, titleHeight);
        
    } else if (_ysType == YSLoadViewTypeSystemActIndicatorDetail) {
        
        CGSize titleSize    = [_titleStr sizeWithAttributes:@{NSFontAttributeName:_titleFont}];
        CGSize descSize     = [_descStr sizeWithAttributes:@{NSFontAttributeName:_descFont}];
        
        CGFloat titleHeight = MIN(titleSize.height, 30);
        CGFloat descHeight  = MIN(descSize.height, selfSize.height - titleHeight);
        
        CGFloat labelWidth  = MAX(titleSize.width, descSize.width);
        
        _ysAcitityIndicator.frame = CGRectMake((selfSize.width - 40 - labelWidth)/2, (selfSize.height - 30)/2, 30, 30);
        
        _titleLabel.frame = CGRectMake(CGRectGetMaxX(_ysAcitityIndicator.frame) + 5, (selfSize.height - titleHeight - descHeight)/2, labelWidth, titleHeight);
        
        _descLabel.frame = CGRectMake(CGRectGetMaxX(_ysAcitityIndicator.frame) + 5, CGRectGetMaxY(_titleLabel.frame), labelWidth, descHeight);
        
    } else if (_ysType == YSLoadViewTypeTextDefault) {
        
        CGSize titleSize = [_titleStr sizeWithAttributes:@{NSFontAttributeName:_titleFont}];
        
        CGFloat titleHeight = MIN(titleSize.height, 30);
        _titleLabel.frame = CGRectMake(0, (selfSize.height - titleHeight)/2, selfSize.width, titleHeight);
    
    } else if (_ysType == YSLoadViewTypeTextDetail) {
    
        CGSize titleSize    = [_titleStr sizeWithAttributes:@{NSFontAttributeName:_titleFont}];
        CGSize descSize     = [_descStr sizeWithAttributes:@{NSFontAttributeName:_descFont}];
        
        CGFloat titleHeight = MIN(titleSize.height, 30);
        CGFloat descHeight  = MIN(descSize.height, selfSize.height - titleHeight);
        
        _titleLabel.frame = CGRectMake(0, (selfSize.height - titleHeight - descHeight)/2, selfSize.width, titleHeight);
        
        _descLabel.frame = CGRectMake(0, CGRectGetMaxY(_titleLabel.frame), selfSize.width, descHeight);
        
    }
}

#pragma mark - KVO -

- (NSArray *)propertyArr
{
    NSArray * propertyArr = @[@"ysActivityIndicatorStyle", @"ysType", @"titleStr", @"titleFont", @"titleTextColor",  @"descStr", @"descFont", @"descTextColor", @"ysCustomView"];
    return propertyArr;
}

- (void)registerKVO
{
    NSArray * propertyArr = [self propertyArr];
    
    for (NSString * propertyStr in propertyArr) {
        [self addObserver:self
               forKeyPath:propertyStr
                  options:NSKeyValueObservingOptionNew
                  context:nil];
    }
}

- (void)unregisterKVO
{
    NSArray * propertyArr = [self propertyArr];
    
    for (NSString * propertyStr in propertyArr) {
        [self removeObserver:self forKeyPath:propertyStr];
    }
}

- (void)observeValueForKeyPath:(NSString *)keyPath ofObject:(id)object change:(NSDictionary<NSString *,id> *)change context:(void *)context
{
    if (![NSThread isMainThread]) {
        [self performSelectorOnMainThread:@selector(updateUIWithKeyPath:) withObject:keyPath waitUntilDone:NO];
    }else {
        [self updateUIWithKeyPath:keyPath];
    }
}

- (void)updateUIWithKeyPath:(NSString *)keyPath
{
    if ([keyPath isEqualToString:@"ysType"] || [keyPath isEqualToString:@"ysCustomView"]) {
        
        [self updateLoadingView];
        
    } else if ([keyPath isEqualToString:@"titleStr"]) {
        
        _titleLabel.text = self.titleStr;
    
    } else if ([keyPath isEqualToString:@"titleFont"]) {
        
        _titleLabel.font = self.titleFont;
    
    } else if ([keyPath isEqualToString:@"titleTextColor"]) {
        
        _titleLabel.textColor = self.titleTextColor;
    
    } else if ([keyPath isEqualToString:@"descStr"]) {
        
        _descLabel.text = self.descStr;
        
    } else if ([keyPath isEqualToString:@"descFont"]) {
        
        _descLabel.font = self.descFont;
        
    } else if ([keyPath isEqualToString:@"descTextColor"]) {
        
        _descLabel.textColor = self.descTextColor;
        
    } else if ([keyPath isEqualToString:@"ysActivityIndicatorStyle"]) {
        
        if (_ysAcitityIndicator != nil) {
            
            [_ysAcitityIndicator setActivityIndicatorViewStyle:self.ysActivityIndicatorStyle];
            
        }
    }
    
    [self setNeedsLayout];
}

- (void)updateLoadingView
{
    if (_ysType == YSLoadViewTypeSystemActIndicatorDefault) {
        
        if (!_ysAcitityIndicator.isAnimating) {
            [_ysAcitityIndicator startAnimating];
        }
        
        _descLabel.hidden = YES;
        
    } else if (_ysType == YSLoadViewTypeSystemActIndicatorDetail) {
        
        if (!_ysAcitityIndicator.isAnimating) {
            [_ysAcitityIndicator startAnimating];
        }
        _descLabel.hidden = NO;
    
    } else if (_ysType == YSLoadViewTypeCustom) {
        
        [_ysAcitityIndicator removeFromSuperview];
        [_descLabel removeFromSuperview];
        [_titleLabel removeFromSuperview];
        
    } else if (_ysType == YSLoadViewTypeTextDefault) {
    
        [_ysAcitityIndicator removeFromSuperview];
        [_descLabel removeFromSuperview];
        
    } else if (_ysType == YSLoadViewTypeTextDetail) {
        
        [_ysAcitityIndicator removeFromSuperview];
    
    }
}

@end
