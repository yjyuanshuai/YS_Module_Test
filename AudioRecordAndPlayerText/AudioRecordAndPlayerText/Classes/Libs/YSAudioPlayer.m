//
//  YSAudioPlayer.m
//  AudioRecordAndPlayerText
//
//  Created by YJ on 16/5/27.
//  Copyright © 2016年 YJ. All rights reserved.
//

#import "YSAudioPlayer.h"
#import "YSAudioModel.h"
#import <UIKit/UIKit.h>

@implementation YSAudioPlayer

+ (instancetype)shardYSAudioPlayer
{
    __block YSAudioPlayer * audioPlayer;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        audioPlayer = [[YSAudioPlayer alloc] init];
    });
    return audioPlayer;
}

- (instancetype)initWithYSAudio:(YSAudioModel *)audioModel
{
    if (self = [super init]) {
        _audioModel = audioModel;
    }
    return self;
}

#pragma mark - 播放 / 暂停
- (void)playAudio
{
    if (_audioModel != nil) {
        if (_audioPlayer == nil) {
            [self createAudioPlayer];
            [self createAudioPlayTimer];
        }
        
        if (![_audioPlayer isPlaying]) {
            [_audioPlayer play];
            _audioPlayTimer.fireDate = [NSDate distantPast];    // 恢复定时器
        }
    } else {
        [[[UIAlertView alloc] initWithTitle:nil
                                    message:@"空的播放源！"
                                   delegate:nil
                          cancelButtonTitle:@"确定"
                          otherButtonTitles:nil] show];
    }
}

- (void)pauseAudio
{
    if ([_audioPlayer isPlaying]) {
        [_audioPlayer pause];
        _audioPlayTimer.fireDate = [NSDate distantFuture];  // 暂停定时器
    }
}

- (void)stopAudio
{
    [_audioPlayer stop];
    [self initValidPlayerTimer];
}

#pragma mark - 创建播放器 / 播放进度定时器
- (AVAudioPlayer *)createAudioPlayer
{
    if (!_audioPlayer) {
        NSError * error = nil;
        _audioPlayer = [[AVAudioPlayer alloc] initWithContentsOfURL:[self getSaveAudioFilePath] error:&error];
        
        if (error) {
            NSLog(@"YSAudioLog ------------ AudioPlayer:%@    errorCode:%d    errorDesc:%@", [error domain], (int)[error code], [[error userInfo] description]);
            return nil;
        }
        
        _audioPlayer.numberOfLoops = 0;     // 0 为不循环
        _audioPlayer.delegate = self;
        [_audioPlayer prepareToPlay];       // 加载音频文件到缓存
    }
    return _audioPlayer;
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

- (NSTimer *)createAudioPlayTimer
{
    if (!_audioPlayer) {
        _audioPlayTimer = [NSTimer scheduledTimerWithTimeInterval:0.5
                                                           target:self
                                                         selector:@selector(updateProgress)
                                                         userInfo:nil
                                                          repeats:YES];
    }
    return _audioPlayTimer;
}

- (void)updateProgress
{
    _audioPlayProgress = _audioPlayer.currentTime / _audioPlayer.duration;
}

- (void)initValidPlayerTimer
{
    if (_audioPlayTimer != nil) {
        [_audioPlayTimer invalidate];
        _audioPlayTimer = nil;
    }
}

#pragma mark - AVAudioPlayerDelegate -
- (void)audioPlayerDidFinishPlaying:(AVAudioPlayer *)player successfully:(BOOL)flag
{
    // 音频播放完毕
}

@end
