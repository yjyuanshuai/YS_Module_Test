//
//  YSAudioRecorder.h
//  AudioRecordAndPlayerText
//
//  Created by YJ on 16/5/27.
//  Copyright © 2016年 YJ. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <AVFoundation/AVFoundation.h>
@class YSAudioModel;

@interface YSAudioRecorder : NSObject <AVAudioRecorderDelegate>


@property (nonatomic, strong, readonly) YSAudioModel *    audioModel;

@property (nonatomic, strong) AVAudioRecorder * audioRecorder;      // 音频录音机
@property (nonatomic, strong) NSTimer *         audioRecorderTimer; // 录音声波监控
@property (nonatomic, assign) float             audioPower;         // 录音声波值


- (void)startAudioRecorder;
- (void)pauseAudioRecorder;
- (void)resumeAudioRecorder;
- (void)cancleAudioRecorder;
- (void)finishAudioRecorder;

@end
