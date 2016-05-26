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



#pragma mark - 音频 model -
@interface YSAudioModel : NSObject

@property (nonatomic, copy)     NSString *          audioFilePath;      //路径
@property (nonatomic, assign)   NSTimeInterval      audioTimeInterval;  //时长

@end



@interface YSVoiceObject : NSObject <AVAudioRecorderDelegate, AVAudioPlayerDelegate>

@property (nonatomic, copy)   NSString *        audioCategoryType;  // 音频会话类型
@property (nonatomic, strong) AVAudioRecorder * audioRecorder;      // 音频录音机
@property (nonatomic, strong) NSTimer *         audioRecorderTimer; // 录音声波监控
@property (nonatomic, assign) float             audioPower;         // 录音声波值
@property (nonatomic, strong) YSAudioModel *    audioModel;


/**********************   播放器   **************************/
@property (nonatomic, strong) AVAudioPlayer *   audioPlayer;        // 音频播放器
@property (nonatomic, strong) NSTimer *         audioPlayTimer;     // 播放进度
@property (nonatomic, assign) float             audioPlayProgress;  // 播放进度



#pragma mark - 录音 -
- (void)startAudioRecorder;
- (void)pauseAudioRecorder;
- (void)resumeAudioRecorder;
- (void)cancleAudioRecorder;
- (void)stopAudioRecorder;

#pragma mark - 播放 -
- (void)playAudio;
- (void)pauseAudio;
- (void)stopAudio;

@end


