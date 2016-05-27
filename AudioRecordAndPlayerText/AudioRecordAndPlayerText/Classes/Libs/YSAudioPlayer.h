//
//  YSAudioPlayer.h
//  AudioRecordAndPlayerText
//
//  Created by YJ on 16/5/27.
//  Copyright © 2016年 YJ. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <AVFoundation/AVFoundation.h>
@class YSAudioModel;

@interface YSAudioPlayer : NSObject <AVAudioPlayerDelegate>

@property (nonatomic, strong) YSAudioModel *    audioModel;

@property (nonatomic, strong) AVAudioPlayer *   audioPlayer;        // 音频播放器
@property (nonatomic, strong) NSTimer *         audioPlayTimer;     // 播放进度监控
@property (nonatomic, assign) float             audioPlayProgress;  // 播放进度


@end
