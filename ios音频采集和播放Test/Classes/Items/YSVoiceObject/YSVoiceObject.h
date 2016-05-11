//
//  YSVoiceObject.h
//  ios音频采集和播放Test
//
//  Created by YJ on 16/5/5.
//  Copyright © 2016年 YJ. All rights reserved.
//

/**
 *  iOS 音频录制 和 播放
 */

#import <Foundation/Foundation.h>
#import <AVFoundation/AVFoundation.h>
#import <UIKit/UIKit.h>

@interface YSVoiceObject : NSObject <AVAudioRecorderDelegate>

@property (nonatomic, copy)   NSString *        audioCategoryType;  // 音频会话类型  AVAudioSessionCategoryRecord
@property (nonatomic, strong) AVAudioRecorder * audioRecorder;      // 音频录音机
@property (nonatomic, strong) AVAudioPlayer *   audioPlayer;        // 音频播放器
@property (nonatomic, strong) NSURL *           audioFileUrl;       // 音频文件的url
@property (nonatomic, assign) NSTimeInterval    audioTimeInterval;  // 录音时长
@property (nonatomic, strong) NSTimer *         audioTimer;         // 录音声波监控
@property (nonatomic, assign) float             audioPower;         // 录音声波值

#pragma mark - instance method -
- (void)startAudioRecorderWithPath:(NSString *)fileName;
- (void)cancleAudioRecorder;
- (void)stopAudioRecorder;
- (void)pauseAudioRecorder;
- (void)resumeAudioRecorder;

@end
