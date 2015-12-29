//
//  YJLoadingView.m
//  MBProgressHudTest
//
//  Created by YJ on 15/12/25.
//  Copyright © 2015年 YJ. All rights reserved.
//

#import "YJLoadingView.h"
#define IMAGE_MAX_SIZE [[UIScreen mainScreen] bounds].size.width
#define FONT_HEL_15 [UIFont fontWithName:@"Helvetica" size:15.0f]

@implementation YJLoadingView
{
    NSMutableArray * _imagesArray;
    NSTimer * _timer;
    float _timeAllInterval;     // 定时器时间
    
    UIView * _indictatorView;   //
    UIImageView * _imageView;
    UILabel * _messageLabel;
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

#pragma mark - Class Methods
+ (void)showLoadingViewToView:(UIView *)view withAnimation:(BOOL)animation
{
//    YJLoadingView * loadView = [YJLoadingView sharedInstance];
    
}






#pragma mark - Instance Methods
- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        self.frame = frame;
        // 初始化数据
        [self initDate];
        [self updateIndicatorView];
        [self registerKVO];
    }
    
    return self;
}

- (void)dealloc
{
    [self unRegisterKVO];
}


- (void)initDate
{
    UIView * bgView = [[UIView alloc] initWithFrame:self.frame];
    bgView.backgroundColor = [UIColor blackColor];
    bgView.alpha = 0.5;
    [self addSubview:bgView];
    
    self.userInteractionEnabled = NO;
    
    _imagesArray = [NSMutableArray array];
    for (int i = 0; i < 8; i++) {
        [_imagesArray addObject:[UIImage imageNamed:[NSString stringWithFormat:@"%d", i+1]]];
    }
    
    _loadViewType = YJLoadingViewTypeImage;
    _alphaValue = 1.0;
    _loadViewSize = CGSizeMake(150, 150);
    _message = @"请稍后...";
    _timeOverInterval = 30;
    
}


- (void)updateIndicatorView
{
    if (_indictatorView != nil) {
        [self destroyIndictator];
    }
    
    if (_loadViewType == YJLoadingViewTypeText) {
        
        _indictatorView = [[UIView alloc] init];
        _indictatorView.bounds = CGRectMake(0, 0, _loadViewSize.width, 50);
        _indictatorView.center = CGPointMake(self.center.x, self.center.y);
        _indictatorView.layer.cornerRadius = 5;
        _indictatorView.alpha = 0.7;
        _indictatorView.backgroundColor = [UIColor blackColor];
        [self addSubview:_indictatorView];
        
        _messageLabel = [[UILabel alloc] init];
        _messageLabel.frame = CGRectMake(10, 10, _loadViewSize.width - 20, 30);
        _messageLabel.backgroundColor = [UIColor clearColor];
        _messageLabel.textColor = [UIColor whiteColor];
        _messageLabel.font = FONT_HEL_15;
        _messageLabel.text = _message;
        _messageLabel.textAlignment = NSTextAlignmentCenter;
        [_indictatorView addSubview:_messageLabel];
        
    }else if (_loadViewType == YJLoadingViewTypeImage){
        
        _indictatorView = [[UIView alloc] init];
        _indictatorView.bounds = CGRectMake(0, 0, _loadViewSize.width, _loadViewSize.height);
        _indictatorView.center = CGPointMake(self.center.x, self.center.y);
        _indictatorView.backgroundColor = [UIColor clearColor];
        [self addSubview:_indictatorView];
        
        _imageView = [[UIImageView alloc] init];
        _imageView.alpha = _alphaValue;
        _imageView.contentMode = UIViewContentModeScaleAspectFit;
        _imageView.layer.cornerRadius = 5;
        _imageView.backgroundColor = [UIColor clearColor];
        _imageView.frame = CGRectMake(0, 0, _loadViewSize.width, _loadViewSize.height);
        [_indictatorView addSubview:_imageView];
        
    }else if (_loadViewType == YJLoadingViewTypeTextAndImage){
    
        _indictatorView = [[UIView alloc] init];
        _indictatorView.bounds = CGRectMake(0, 0, _loadViewSize.width, _loadViewSize.height);
        _indictatorView.center = CGPointMake(self.center.x, self.center.y);
        _indictatorView.backgroundColor = [UIColor clearColor];
        [self addSubview:_indictatorView];
        
        _imageView = [[UIImageView alloc] init];
        _imageView.alpha = _alphaValue;
        _imageView.contentMode = UIViewContentModeScaleAspectFit;
        _imageView.frame = CGRectMake(15, 0, _loadViewSize.width - 30, _loadViewSize.height - 30);
        _imageView.backgroundColor = [UIColor clearColor];
        [_indictatorView addSubview:_imageView];
        
        
        _messageLabel = [[UILabel alloc] init];
        _messageLabel.frame = CGRectMake(0, CGRectGetMaxY(_imageView.frame), _loadViewSize.width, 30);
        _messageLabel.backgroundColor = [UIColor clearColor];
        _messageLabel.textColor = [UIColor blackColor];
        _messageLabel.font = FONT_HEL_15;
        _messageLabel.text = _message;
        _messageLabel.textAlignment = NSTextAlignmentCenter;
        [_indictatorView addSubview:_messageLabel];
        
    }
}

- (void)setLoadViewSize:(CGSize)loadViewSize
{
    if (loadViewSize.width < 100 || loadViewSize.height < 100) {
        
        _loadViewSize = CGSizeMake(100, 100);
        
    }else if (loadViewSize.width >= IMAGE_MAX_SIZE || loadViewSize.height >= IMAGE_MAX_SIZE){
        
        _loadViewSize = CGSizeMake(IMAGE_MAX_SIZE - 20, IMAGE_MAX_SIZE - 20);
        
    }else if (loadViewSize.width != loadViewSize.height){
        
        CGFloat size = (loadViewSize.width > loadViewSize.height) ? loadViewSize.width : loadViewSize.height;
        _loadViewSize = CGSizeMake(size, size);
        
    }else {
        
        _loadViewSize = CGSizeMake(loadViewSize.width, loadViewSize.height);
        
    }
    
}

- (void)setTimeOverInterval:(float)timeOverInterval
{
    if (timeOverInterval <= 0) {
        _timeOverInterval = 30;
    }else {
        _timeOverInterval = timeOverInterval;
    }
}


#pragma mark - KVO
- (NSArray *)keyPathArr
{
    return @[@"alphaValue", @"loadViewSize", @"timeOverInterval", @"loadViewType", @"message"];
}

- (void)registerKVO
{
    for (NSString * keyPath in [self keyPathArr]) {
        [self addObserver:self forKeyPath:keyPath options:NSKeyValueObservingOptionNew context:NULL];
    }
}

- (void)unRegisterKVO
{
    for (NSString * keyPath in [self keyPathArr]) {
        [self removeObserver:self forKeyPath:keyPath];
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
    if ([keyPath isEqualToString:@"alphaValue"] || [keyPath isEqualToString:@"loadViewSize"] || [keyPath isEqualToString:@"loadViewType"]) {
        
        [self updateIndicatorView];
        
    }else if ([keyPath isEqualToString:@"timeOverInterval"] || [keyPath isEqualToString:@"timeOverInterval"]){
    
    }
    
    [self setNeedsLayout];
    [self setNeedsDisplay];
}


#pragma mark - Show & Dismiss
- (void)showLoadingView
{
    if ([_imagesArray count] > 0) {
        
        _imageView.animationImages = _imagesArray;
        _imageView.animationRepeatCount = 0;
        _imageView.animationDuration = [_imagesArray count]*0.1;
        [_imageView startAnimating];
    }
    
    [self isTimeOver];
    
}

- (void)dismissLoadingView
{
    [UIView animateWithDuration:0.3f animations:^{
        
        self.alpha = 0;
        
    } completion:^(BOOL finished) {
        [_imageView stopAnimating];
        
        if (_timer) {
            [_timer invalidate];
            _timer = nil;
        }
        
        for (UIView * subView in self.subviews) {
            [self destroyIndictator];
            [subView removeFromSuperview];
        }
        [self removeFromSuperview];
    }];
    
}

- (void)isTimeOver
{
    _timer = [NSTimer scheduledTimerWithTimeInterval:1.0
                                              target:self
                                            selector:@selector(isShouldStopAnimation)
                                            userInfo:nil
                                             repeats:YES];
    _timeAllInterval = 0.0;
}

- (void)isShouldStopAnimation
{
    _timeAllInterval = _timeAllInterval + _timer.timeInterval;
    NSLog(@"----------- timer: %f", _timeAllInterval);
    
    if (_timeAllInterval >= _timeOverInterval) {    // 超时
        
        [self whenTimeOver];

    }
}

- (void)whenTimeOver
{
    // 超时
    _loadViewType = YJLoadingViewTypeText;
    _message = @"操作超时";
    [self updateIndicatorView];
    
    dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0), ^{
        sleep(1);
        dispatch_async(dispatch_get_main_queue(), ^{
            [self dismissLoadingView];
        });

    });
    
}


- (void)destroyIndictator
{
    for (UIView * subView in _indictatorView.subviews) {
        [subView removeFromSuperview];
    }
    [_indictatorView removeFromSuperview];
}

@end
