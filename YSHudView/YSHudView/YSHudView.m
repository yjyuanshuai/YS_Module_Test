//
//  YSHudView.m
//  HudDemo
//
//  Created by YJ on 16/5/31.
//  Copyright © 2016年 Matej Bukovinski. All rights reserved.
//

#import "YSHudView.h"

@implementation YSHudView
{
    UIView * _hudSubView;
    NSTimer * _timer;
}

+ (instancetype)sharedYSHudView
{
    __block YSHudView * instance = nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        instance = [[self alloc] init];
    });
    return instance;
}

#pragma mark -
- (void)initMBHudWithLoadingView
{
    CGSize hudSize = CGSizeMake(100, 100);
    
    if (_hudView == nil) {
        if (_isUserEnable == YES) {
            _hudView = [[UIView alloc] initWithFrame:CGRectMake((_DEVICE_WIDTH - hudSize.width)/2, (_DEVICE_HEIGHT - hudSize.height)/2, hudSize.width, hudSize.height)];
            _mbProgressHud = [MBProgressHUD showHUDAddedTo:_hudView animated:YES];
        } else {
            _hudView = [[UIView alloc] initWithFrame:CGRectMake(0, 64, _DEVICE_WIDTH, _DEVICE_HEIGHT_NO_64)];
            _hudSubView = [[UIView alloc] initWithFrame:CGRectMake((_DEVICE_WIDTH - hudSize.width)/2, (_DEVICE_HEIGHT - hudSize.height)/2 - 64, hudSize.width, hudSize.height)];
            [_hudView addSubview:_hudSubView];
            _mbProgressHud = [MBProgressHUD showHUDAddedTo:_hudSubView animated:YES];
        }
    }
    
    _mbProgressHud.mode = MBProgressHUDModeCustomView;
    _mbProgressHud.margin = 0.0;
    _mbProgressHud.minSize = hudSize;
    _mbProgressHud.bezelView.color = [UIColor clearColor];
    [_APP_KEYWINDOW addSubview:_hudView];
    
    NSArray* imageArr = [NSArray arrayWithObjects:@"1", @"2", @"3", @"4", @"5", @"6", @"7", @"8", nil];
    UIImageView* custemImageView = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"1"]];
    
    NSMutableArray* arr = [NSMutableArray array];
    
    for (int i = 0; i < [imageArr count]; i++) {
        NSString* imagePath = [[NSBundle mainBundle] pathForResource:imageArr[i] ofType:@"png"];
        UIImage* image      = [UIImage imageWithContentsOfFile:imagePath];
        [arr addObject:image];
    }
    
    custemImageView.animationImages      = [NSArray arrayWithArray:arr];
    custemImageView.animationDuration    = [imageArr count] * 0.1;
    custemImageView.animationRepeatCount = 0;
    [custemImageView startAnimating];
    
    _mbProgressHud.customView = custemImageView;
}

- (void)initMBHudBecauseNetWorkUnavailable {
    _mbProgressHud = [MBProgressHUD showHUDAddedTo:[UIApplication sharedApplication].keyWindow animated:YES];
    _mbProgressHud.mode = MBProgressHUDModeText;
    _mbProgressHud.label.text = @"网络连接错误，请稍后重试";
    [_mbProgressHud hideAnimated:YES afterDelay:1.0];
}

- (void)stopOrDisplayMBHudWithmsg:(NSString*)msg finsh:(void (^)(void))finshBlock
{
    [self makeTimerInvalid];
    [self hideHUD];
    
    if (![msg isEqualToString:@""]) {
        
        _mbProgressHud = [MBProgressHUD showHUDAddedTo:[UIApplication sharedApplication].keyWindow animated:YES];
        _mbProgressHud.mode = MBProgressHUDModeText;
        _mbProgressHud.detailsLabel.text = msg;
        
        if (msg.length > 12) {
//            _mbProgressHud.detailsLabelFont = HEL_14;
        } else {
//            _mbProgressHud.detailsLabelFont = HEL_16;
        }
        
        [_mbProgressHud showAnimated:YES];
        [_mbProgressHud hideAnimated:YES afterDelay:1.5];
    }
    
    if (finshBlock) {
        finshBlock();
    }
}

- (void)hideHUD
{
    [self makeTimerInvalid];
    
    if (_hudView) {
        [_hudView removeFromSuperview];
        _hudView = nil;
        [_mbProgressHud hideAnimated:YES];
    }
}

#pragma mark - 定时器 -
- (void)initTimer
{
    if (!_timer) {
        _timer = [NSTimer scheduledTimerWithTimeInterval:30.0
                                                  target:self
                                                selector:@selector(overTime)
                                                userInfo:nil
                                                 repeats:NO];
        [[NSRunLoop currentRunLoop]addTimer:_timer forMode:NSRunLoopCommonModes];
    }
}

- (void)overTime
{
    [self hideHUD];
    
    _mbProgressHud = [MBProgressHUD showHUDAddedTo:[UIApplication sharedApplication].keyWindow animated:YES];
    _mbProgressHud.mode = MBProgressHUDModeText;
    _mbProgressHud.detailsLabel.text = @"操作超时，请重试!";
//    _mbProgressHud.detailsLabelFont = HEL_14;
    [_mbProgressHud hideAnimated:YES afterDelay:1.0];
}

- (void)makeTimerInvalid
{
    if (_timer) {
        [_timer invalidate];
        _timer = nil;
    }
}

@end
