//
//  YSAudioModel.h
//  AudioRecordAndPlayerText
//
//  Created by YJ on 16/5/27.
//  Copyright © 2016年 YJ. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface YSAudioModel : NSObject

@property (nonatomic, copy)   NSString *        filePath;       //路径
@property (nonatomic, copy)   NSString *        audioName;      //音频名
@property (nonatomic, assign) NSTimeInterval    timeInterval;   //时长
@property (nonatomic, copy)   NSString *        audioDate;      //录音时间“年/月/日”

@end
