//
//  YSVoiceObject.m
//  ios音频采集和播放Test
//
//  Created by YJ on 16/5/5.
//  Copyright © 2016年 YJ. All rights reserved.
//

#import "YSVoiceObject.h"

const static NSTimeInterval updateTimeInterval = 0.05;

@implementation YSVoiceObject

#pragma mark - 录音机操作
#pragma mark - 开始录音
- (void)startAudioRecorderWithPath:(NSString *)fileName
{
    [self createAudioSession];
    [self getAudioSetting];
    [self getSaveAudioFilePath:fileName];
    [self audioRecorder];
    
    if ([_audioRecorder isRecording]) {
        [self stopAudioRecorder];
    }
    [_audioRecorder record];
    _audioTimer.fireDate = [NSDate distantPast];
}

#pragma mark - 暂停
- (void)pauseAudioRecorder
{
    if ([_audioRecorder isRecording]) {
        [_audioRecorder pause];
        _audioTimer.fireDate = [NSDate distantFuture];
    }
}

#pragma mark - 恢复
- (void)resumeAudioRecorder
{
    // 恢复录音只需要再次调用record，AVAudioSession会帮助你记录上次录音位置并追加录音
}

#pragma mark - 取消
- (void)cancleAudioRecorder
{
    if ([_audioRecorder isRecording]) {
        [self invalidTimer];
        [_audioRecorder stop];
        _audioRecorder = nil;
    }
}

#pragma mark - 停止
- (void)stopAudioRecorder
{
    [_audioRecorder stop];
    _audioTimer.fireDate = [NSDate distantFuture];
}

#pragma mark - 录音机设置
#pragma mark - 设置音频会话
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

#pragma mark - 获取录音文件保存路径
- (NSURL *)getSaveAudioFilePath:(NSString *)path
{
    NSString *urlStr=[NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES) lastObject];
    
    urlStr = [urlStr stringByAppendingPathComponent:path];
    NSLog(@"YSAudioLog --------------- file path:%@",urlStr);
    _audioFileUrl = [NSURL fileURLWithPath:urlStr];
    return _audioFileUrl;
}

#pragma mark - 设置录音文件设置
- (NSDictionary *)getAudioSetting
{
    NSMutableDictionary * recordSetting = [NSMutableDictionary dictionary];
    // 录音格式
    [recordSetting setValue:[NSNumber numberWithInt:kAudioFormatAppleIMA4] forKey:AVFormatIDKey];
    // 录音采样率，8000是电话采样率
    [recordSetting setValue:[NSNumber numberWithFloat:16000.0] forKey:AVSampleRateKey];
    // 通道，1 表示单声道
    [recordSetting setValue:[NSNumber numberWithInt:1] forKey:AVNumberOfChannelsKey];
    // 每个采样点位数，分为 8、16、24、32
    [recordSetting setValue:@(8) forKey:AVLinearPCMBitDepthKey];
    // 是否使用浮点数采样
    [recordSetting setValue:@(YES) forKey:AVLinearPCMIsFloatKey];
    return recordSetting;
}

#pragma mark - 获取录音对象
- (AVAudioRecorder *)audioRecorder
{
    if (_audioRecorder) {
        [_audioRecorder stop];
        _audioRecorder = nil;
    }

    NSError * error = nil;
    
    _audioRecorder = [[AVAudioRecorder alloc] initWithURL:_audioFileUrl settings:[self getAudioSetting] error:&error];
    if(!_audioRecorder){
        NSLog(@"YSAudioLog ------------ AudioRecorder:%@    errorCode:%d    errorDesc:%@", [error domain], (int)[error code], [[error userInfo] description]);
        return nil;
    }
    _audioRecorder.delegate = self;
    _audioRecorder.meteringEnabled = YES;   // 监控声波
    
    return _audioRecorder;
}

#pragma mark - AVAudioRecorderDelegate -
- (void)audioRecorderDidFinishRecording:(AVAudioRecorder *)recorder successfully:(BOOL)flag
{
    // 录音完成
    
}

#pragma mark - 播放器设置
#pragma mark - 播放器
- (AVAudioPlayer *)audioPlayer
{
    if (!_audioPlayer) {
        NSError * error = nil;
        _audioPlayer = [[AVAudioPlayer alloc] initWithContentsOfURL:_audioFileUrl error:&error];
        _audioPlayer.numberOfLoops = 0;
        [_audioPlayer prepareToPlay];
        
        if (error) {
            NSLog(@"YSAudioLog ------------ AudioPlayer:%@    errorCode:%d    errorDesc:%@", [error domain], (int)[error code], [[error userInfo] description]);
            return nil;
        }
    }
    return _audioPlayer;
}

#pragma mark - 判断麦克风是否可用 -
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
- (NSTimer *)getAudioTimer
{
    [self invalidTimer];
    
    _audioTimer = [NSTimer scheduledTimerWithTimeInterval:updateTimeInterval
                                                   target:self
                                                 selector:@selector(uptateAudioPowerChange)
                                                 userInfo:nil
                                                  repeats:YES];
    return _audioTimer;
}

- (void)invalidTimer
{
    if (_audioTimer) {
        [_audioTimer invalidate];
        _audioTimer = nil;
    }
}

- (float)uptateAudioPowerChange
{
    _audioTimeInterval += updateTimeInterval;
    [_audioRecorder updateMeters];  // 更新测量值
    _audioPower = [_audioRecorder averagePowerForChannel:0];    //取得第一个通道的音频，注意音频强度范围是 -160到0
    return _audioPower;
}

@end
