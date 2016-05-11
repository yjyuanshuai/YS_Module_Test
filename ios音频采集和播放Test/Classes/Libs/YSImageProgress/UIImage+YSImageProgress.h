//
//  NSDate+YSImageProgress.h
//  ios音频采集和播放Test
//
//  Created by YJ on 16/5/6.
//  Copyright © 2016年 YJ. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UIImage (YSImageProgress)

- (UIImage *) partialImageWithPercentage:(float)percentage
                                vertical:(BOOL)vertical
                           grayscaleRest:(BOOL)grayscaleRest;

@end
