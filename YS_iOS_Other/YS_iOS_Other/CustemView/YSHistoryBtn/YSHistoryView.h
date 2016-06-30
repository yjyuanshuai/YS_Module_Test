//
//  YSHistoryView.h
//  YS_iOS_Other
//
//  Created by YJ on 16/6/30.
//  Copyright © 2016年 YJ. All rights reserved.
//

#import <UIKit/UIKit.h>
@class YSHistoryBtn;

@interface YSHistoryView : UIView

@property (nonatomic, strong) YSHistoryBtn * historyBtn;

+ (instancetype)historyViewShowWithFrame:(CGRect)frame stringArr:(NSArray *)stringArr;
+ (void)historyViewHide;
+ (void)historyViewUpdate;

@end
