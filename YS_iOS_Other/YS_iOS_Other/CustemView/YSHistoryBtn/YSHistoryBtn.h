//
//  YSHistoryBtn.h
//  YS_iOS_Other
//
//  Created by YJ on 16/6/30.
//  Copyright © 2016年 YJ. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface YSHistoryBtn : UIButton

@property (nonatomic, assign) BOOL isDelete;
@property (nonatomic, strong) UIColor * borderColor;
@property (nonatomic, assign) CGFloat * borderWidth;
@property (nonatomic, assign) CGFloat * corderRadus;

- (instancetype)initWithFrame:(CGRect)frame;

@end
