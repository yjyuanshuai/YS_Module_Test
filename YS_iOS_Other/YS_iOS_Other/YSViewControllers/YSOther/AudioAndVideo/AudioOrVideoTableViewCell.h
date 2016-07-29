//
//  AudioTableViewCell.h
//  YS_iOS_Other
//
//  Created by YJ on 16/7/28.
//  Copyright © 2016年 YJ. All rights reserved.
//

#import <UIKit/UIKit.h>

typedef NS_ENUM(NSInteger, CellType)
{
    CellTypeAudio,
    CellTypeVideo
};

@interface AudioOrVideoTableViewCell : UITableViewCell

@property (nonatomic, strong) UIImageView * audioImage;     // 缩略图
@property (nonatomic, copy) NSString * audioName;           // 名称
@property (nonatomic, copy) NSString * audioDate;           // 录制完成的时间
@property (nonatomic, copy) NSString * audioTime;           // 音频长度

- (void)setCellContent:(CellType)celltype model:(id)model;

@end

