//
//  AudioTableViewCell.m
//  YS_iOS_Other
//
//  Created by YJ on 16/7/28.
//  Copyright © 2016年 YJ. All rights reserved.
//

#import "AudioOrVideoTableViewCell.h"
#import "YSSongModel.h"

@implementation AudioOrVideoTableViewCell

- (instancetype)initWithStyle:(UITableViewCellStyle)style
              reuseIdentifier:(NSString *)reuseIdentifier
{
    if (self = [super initWithStyle:style reuseIdentifier:reuseIdentifier]) {
        [self addSubViews];
        [self addConstraintsToSelf];
    }
    
    return self;
}

- (void)addSubViews
{
    _videoImageView = [UIImageView new];
    [self.contentView addSubview:_videoImageView];
    
    _audioNameLabel = [UILabel new];
    [self.contentView addSubview:_audioNameLabel];
}

- (void)addConstraintsToSelf
{
    [_videoImageView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.contentView.mas_left).offset(10);
        make.top.equalTo(self.contentView.mas_top).offset(5);
        make.bottom.equalTo(self.contentView.mas_bottom).offset(-5);
    }];
    
    [_audioNameLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(_videoImageView.mas_right).offset(10);
        make.top.equalTo(self.contentView.mas_top).offset(5);
        make.bottom.equalTo(self.contentView.mas_bottom).offset(-5);
        make.right.equalTo(self.contentView.mas_right).offset(-10);
    }];
}

- (void)setCellContent:(CellType)celltype model:(id)model
{
    if (celltype == CellTypeAudio) {
        
        _videoImageView.hidden = YES;
        [_audioNameLabel mas_updateConstraints:^(MASConstraintMaker *make) {
            make.left.equalTo(self.contentView.mas_left).offset(10);
        }];
        
        YSSongModel * songModel = (YSSongModel *)model;
        _audioNameLabel.text = songModel.name;
        
    }
    else if (celltype == CellTypeVideo) {
    
        _videoImageView.hidden = NO;
        
        _videoImageView.image = [UIImage imageNamed:@"btn1"];
        
    }
}

@end
