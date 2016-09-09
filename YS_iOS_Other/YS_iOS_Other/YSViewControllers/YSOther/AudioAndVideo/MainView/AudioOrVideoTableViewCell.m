//
//  AudioTableViewCell.m
//  YS_iOS_Other
//
//  Created by YJ on 16/7/28.
//  Copyright © 2016年 YJ. All rights reserved.
//

#import "AudioOrVideoTableViewCell.h"
#import "AudioAndVideoModel.h"

@implementation AudioOrVideoTableViewCell

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    if (self = [super initWithStyle:style reuseIdentifier:reuseIdentifier]) {
        
    }
    
    return self;
}

- (void)setCellContent:(CellType)celltype model:(id)model
{
    if (celltype == CellTypeAudio) {
        
        AudioModel * audioModel = (AudioModel *)model;
        
    }
    else if (celltype == CellTypeVideo) {
    
        VideoModel * videoModel = (VideoModel *)model;
        
    }
}

@end
