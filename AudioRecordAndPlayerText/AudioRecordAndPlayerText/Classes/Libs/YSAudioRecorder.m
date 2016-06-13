//
//  YSAudioRecorder.m
//  AudioRecordAndPlayerText
//
//  Created by YJ on 16/5/27.
//  Copyright © 2016年 YJ. All rights reserved.
//

#import "YSAudioRecorder.h"
#import "YSAudioModel.h"
#import <UIKit/UIKit.h>

const static NSTimeInterval updateTimeInterval = 0.1f;

@implementation YSAudioRecorder

+ (instancetype)shardYSAudioRecord
{
    __block YSAudioRecorder * audioRecorder;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        audioRecorder = [[YSAudioRecorder alloc] init];
    });
    return audioRecorder;
}

- (instancetype)init
{
    if (self = [super init]) {
        _audioModel = [[YSAudioModel alloc] init];
    }
    return self;
}

#pragma mark - 录音机操作 -
#pragma mark - 开始 / 暂停 / 恢复 / 取消 / 停止
- (void)startAudioRecorder
{
    if (_audioRecorder == nil) {
        [self initAudioRecorder];
    }
    
    if (![_audioRecorder isRecording]) {
        [_audioRecorder record];
        _audioRecorderTimer.fireDate = [NSDate distantPast];
    }
}

- (void)pauseAudioRecorder
{
    if ([_audioRecorder isRecording]) {
        [_audioRecorder pause];
        _audioRecorderTimer.fireDate = [NSDate distantFuture];
    }
}

- (void)resumeAudioRecorder
{
    // 恢复录音只需要再次调用record，AVAudioSession会帮助你记录上次录音位置并追加录音
    [self startAudioRecorder];
}

- (void)cancleAudioRecorder
{
    if ([_audioRecorder isRecording]) {
        [_audioRecorder stop];
    }
    
    [self invalidRecordTimer];
    _audioRecorder = nil;
    _audioModel = nil;
}

- (void)finishAudioRecorder
{
    if ([_audioRecorder isRecording]) {
        [_audioRecorder stop];
    }
    
    [self invalidRecordTimer];
}

#pragma mark - 录音机设置
#pragma mark - 初始化录音机 / 设置音频会话 / 获取录音文件保存路径 / 设置录音文件设置 / 获取录音对象
- (void)initAudioRecorder
{
    NSDateFormatter *formatter = [[NSDateFormatter alloc] init];
    [formatter setDateStyle:NSDateFormatterMediumStyle];
    [formatter setTimeStyle:NSDateFormatterShortStyle];
    [formatter setDateFormat:@"yyyyMMddHHmmssSSS"];
    
    NSTimeZone* timeZone = [NSTimeZone timeZoneWithName:@"Asia/Shanghai"];
    [formatter setTimeZone:timeZone];
    NSString * dateStr = [formatter stringFromDate:[NSDate date]];
    
    _audioModel.filePath = [NSString stringWithFormat:@"%@.caf", dateStr];
    
    [self createAudioSession];
    [self createAudioRecorder];
    [self createAudioRecorderTimer];
}

- (void)createAudioSession
{
    /*************  检测麦克风是否可用   ************************/
    if (![self microPhoneIsValid]) {
        
        // 获取引用名
        NSString *appName = [[[NSBundle mainBundle] infoDictionary] objectForKey:@"CFBundleExecutable"];
        
        [[[UIAlertView alloc] initWithTitle:@"麦克风禁用"
                                    message:[NSString stringWithFormat:@"%@ 被禁用您的麦克风", appName]
                                   delegate:nil
                          cancelButtonTitle:@"确认"
                          otherButtonTitles:nil] show];
    } else {
        
        /*************  设置为播放和录音状态  AVAudioSessionCategoryPlayAndRecord  ************************/
        NSError * error = nil;
        
        AVAudioSession * audioSession = [AVAudioSession sharedInstance];
        [audioSession setCategory:AVAudioSessionCategoryPlayAndRecord error:&error];
        
        if (error) {
            NSLog(@"YSAudioLog ------------ audioSession-SetCategory:%@    errorCode:%d    errorDesc:%@", [error domain], (int)[error code], [[error userInfo] description]);
            
            [[[UIAlertView alloc] initWithTitle:@"录音失败"
                                        message:@"请稍后再试"
                                       delegate:nil
                              cancelButtonTitle:@"确定"
                              otherButtonTitles:nil] show];
            return;
        }
        
        error = nil;
        
        [audioSession setActive:YES error:&error];
        
        if(error){
            NSLog(@"YSAudioLog ------------ audioSession-SetActive:%@    errorCode:%d    errorDesc:%@", [error domain], (int)[error code], [[error userInfo] description]);
            return;
        }
        
        BOOL audioAvailable = audioSession.inputAvailable;
        if (!audioAvailable) {
            [[[UIAlertView alloc] initWithTitle:nil
                                        message:@"输入无效"
                                       delegate:nil
                              cancelButtonTitle:@"确定"
                              otherButtonTitles:nil] show];
            return;
        }
    }
}

- (NSURL *)getSaveAudioFilePath
{
    NSString *urlStr=[NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES) lastObject];
    if (_audioModel != nil) {
        urlStr = [urlStr stringByAppendingPathComponent:_audioModel.filePath];
    } else {
        urlStr = @"";
    }
    NSLog(@"YSAudioLog --------------- file path:%@",urlStr);
    
    NSURL * audioFileUrl = [NSURL fileURLWithPath:urlStr];
    return audioFileUrl;
}

- (NSDictionary *)getAudioSetting
{
    NSMutableDictionary * recordSetting = [NSMutableDictionary dictionary];
    // 录音格式
    [recordSetting setValue:[NSNumber numberWithInt:kAudioFormatLinearPCM] forKey:AVFormatIDKey];
    // 录音采样率，8000是电话采样率
    [recordSetting setValue:[NSNumber numberWithFloat:16000.0] forKey:AVSampleRateKey];
    // 通道，1 表示单声道
    [recordSetting setValue:[NSNumber numberWithInt:1] forKey:AVNumberOfChannelsKey];
    // 每个采样点位数，分为 8、16、24、32
    [recordSetting setValue:@(8) forKey:AVLinearPCMBitDepthKey];
    // 是否使用浮点数采样
    [recordSetting setValue:@(YES) forKey:AVLinearPCMIsFloatKey];
    // 其他设置……
    
    return recordSetting;
}

- (AVAudioRecorder *)createAudioRecorder
{
    if (!_audioRecorder) {
        
        // 录音文件保存路径  _audioFileUrl
        NSURL * audioFileUrl = [self getSaveAudioFilePath];
        
        // 创建录音格式设置
        NSDictionary * settingDict = [self getAudioSetting];
        
        // 创建录音机
        NSError * error = nil;
        
        _audioRecorder = [[AVAudioRecorder alloc] initWithURL:audioFileUrl settings:settingDict error:&error];
        
        if(error){
            NSLog(@"YSAudioLog ------------ AudioRecorder:%@    errorCode:%d    errorDesc:%@", [error domain], (int)[error code], [[error userInfo] description]);
            return nil;
        }
        
        _audioRecorder.delegate = self;
        _audioRecorder.meteringEnabled = YES;   // 监控声波
    }
    return _audioRecorder;
}

/**
 *  判断麦克风是否可用
 */
- (BOOL)microPhoneIsValid
{
    __block BOOL microPhoneValid = NO;
    AVAudioSession * session = [AVAudioSession sharedInstance];
    
    if ([session respondsToSelector:@selector(requestRecordPermission:)]) {
        [session requestRecordPermission:^(BOOL granted) {
            if (granted) {
                microPhoneValid = YES;
            } else {
                microPhoneValid =  NO;
            }
        }];
    } else {
        microPhoneValid = NO;
    }
    return microPhoneValid;
}

#pragma mark - 录音声波监控定时器创建/消除 -
- (NSTimer *)createAudioRecorderTimer
{
    if (!_audioRecorderTimer) {
        _audioRecorderTimer = [NSTimer scheduledTimerWithTimeInterval:updateTimeInterval
                                                               target:self
                                                             selector:@selector(uptateAudioPowerChange)
                                                             userInfo:nil
                                                              repeats:YES];
    }
    return _audioRecorderTimer;
}

- (float)uptateAudioPowerChange
{
    if (_audioModel != nil) {
        _audioModel.timeInterval += updateTimeInterval;
    }
    
    [_audioRecorder updateMeters];  // 更新测量值
    float power = [_audioRecorder averagePowerForChannel:0];    //取得第一个通道的音频，注意音频强度范围是 -160到0
    _audioPower = (1.0 / 160.0)*(power + 160.0);
    return _audioPower;
}

- (void)invalidRecordTimer
{
    if (_audioRecorderTimer != nil) {
        [_audioRecorderTimer invalidate];
        _audioRecorderTimer = nil;
    }
}

#pragma mark - AVAudioRecorderDelegate -
- (void)audioRecorderDidFinishRecording:(AVAudioRecorder *)recorder successfully:(BOOL)flag
{
    // 录音完成
    
}

@end
