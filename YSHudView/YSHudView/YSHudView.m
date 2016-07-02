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
    static YSHudView * instance = nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        instance = [[self alloc] init];
    });
    return instance;
}

- (instancetype)init
{
    if (self = [super init]) {
        
    }
    return self;
}

#pragma mark - class method -
+ (void)yiBaoHUDShowWithUserEnable
{
    [[YSHudView sharedYSHudView] showYiBaoHUDWithUserEnable];
}

+ (void)yiBaoHUDShowWithUserUnenable
{
    [[YSHudView sharedYSHudView] showYiBaoHUDWithUserUnenable];
}

+ (void)yiBaoHUDStopOrShowWithMsg:(NSString*)msg finsh:(void (^)(void))finshBlock
{
    [[YSHudView sharedYSHudView] stopOrShowHUDWithMsg:msg finsh:finshBlock];
}

#pragma mark - instance method -
- (void)showYiBaoHUDWithUserUnenable
{
    _isUserEnable = NO;
    [self showYiBaoHUD];
}

- (void)showYiBaoHUDWithUserEnable
{
    _isUserEnable = YES;
    [self showYiBaoHUD];
}

- (void)showYiBaoHUD
{
    [self hideHUD];
    [self initTimer];
    
    CGSize hudSize = CGSizeMake(100, 100);
    
    if (_hudView == nil) {
        
        _hudView = [[UIView alloc] initWithFrame:CGRectMake(0, 64, _DEVICE_WIDTH, _DEVICE_HEIGHT_NO_64)];
        _hudSubView = [[UIView alloc] initWithFrame:CGRectMake((_DEVICE_WIDTH - hudSize.width)/2, (_DEVICE_HEIGHT - hudSize.height)/2 - 64, hudSize.width, hudSize.height)];
        [_hudView addSubview:_hudSubView];
        [_APP_KEYWINDOW addSubview:_hudView];
        
        if (_isUserEnable == YES) {
            _hudView.userInteractionEnabled = NO;
        }
    
//        _hudView.backgroundColor = [UIColor yellowColor];
//        _hudView.alpha = 0.6;
    
    _mbProgressHud = [MBProgressHUD showHUDAddedTo:_hudSubView animated:YES];
    _mbProgressHud.mode = MBProgressHUDModeCustomView;
    _mbProgressHud.margin = 0.0;
    _mbProgressHud.minSize = hudSize;
    _mbProgressHud.backgroundView.style = MBProgressHUDBackgroundStyleSolidColor;
    _mbProgressHud.bezelView.style = MBProgressHUDBackgroundStyleSolidColor;
    _mbProgressHud.bezelView.color = [UIColor clearColor];
    _mbProgressHud.bezelView.alpha = 0.7;
    
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
}

- (void)showHUDWithNetWorkUnavailable {
    _mbProgressHud = [MBProgressHUD showHUDAddedTo:_APP_KEYWINDOW animated:YES];
    _mbProgressHud.mode = MBProgressHUDModeText;
    _mbProgressHud.label.text = @"网络连接错误，请稍后重试";
    [_mbProgressHud hideAnimated:YES afterDelay:1.0];
}

- (void)stopOrShowHUDWithMsg:(NSString*)msg finsh:(void (^)(void))finshBlock
{
    [self makeTimerInvalid];
    [self hideHUD];
    
    if (!([msg isEqualToString:@""] ||
          [msg isKindOfClass:[NSNull class]] ||
          msg == nil ||
          msg == NULL ||
          [msg isEqualToString:@"<null>"] ||
          [msg isEqualToString:@"(null)"] ||
          [[msg stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceCharacterSet]] length]==0)) {
        
        _mbProgressHud = [MBProgressHUD showHUDAddedTo:_APP_KEYWINDOW animated:YES];
        _mbProgressHud.mode = MBProgressHUDModeText;
        _mbProgressHud.detailsLabel.text = msg;
        _mbProgressHud.backgroundView.backgroundColor = [UIColor redColor];
        _mbProgressHud.backgroundView.alpha = 0.5;
        
        if (msg.length > 12) {
            _mbProgressHud.detailsLabel.font = [UIFont fontWithName:@"Helvetica" size:14];
        } else {
            _mbProgressHud.detailsLabel.font = [UIFont fontWithName:@"Helvetica" size:16];
        }
    
        dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(1.5 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
            
            [MBProgressHUD hideHUDForView:_APP_KEYWINDOW animated:YES];
            
            if (finshBlock) {
                finshBlock();
            }
        });
    } else {
        if (finshBlock) {
            finshBlock();
        }
    }
}

#pragma mark - hide -
- (void)hideHUD
{
    [self makeTimerInvalid];
    
    if (_hudView) {
        [_hudView removeFromSuperview];
        _hudView = nil;
        [_mbProgressHud hideAnimated:YES];
    }
    
    [self hideAllMBProHUD];
}

- (void)hideAllMBProHUD
{
    [MBProgressHUD hideHUDForView:_APP_KEYWINDOW animated:YES];
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
    
    _mbProgressHud = [MBProgressHUD showHUDAddedTo:_APP_KEYWINDOW animated:YES];
    _mbProgressHud.mode = MBProgressHUDModeText;
    _mbProgressHud.detailsLabel.text = @"操作超时，请重试!";
    _mbProgressHud.detailsLabel.font = [UIFont fontWithName:@"Helvetica" size:14];
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
