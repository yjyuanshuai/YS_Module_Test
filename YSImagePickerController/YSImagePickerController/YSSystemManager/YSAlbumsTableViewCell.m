//
//  YSAlbumsTableViewCell.m
//  YSImagePickerController
//
//  Created by YJ on 17/2/14.
//  Copyright © 2017年 YJ. All rights reserved.
//

#import "YSAlbumsTableViewCell.h"
#import "YSImagePickerHead.h"

@implementation YSAlbumsTableViewCell

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    if (self = [super initWithStyle:style reuseIdentifier:reuseIdentifier]) {
        
        self.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
        [self createSubViews];
        
    }
    return self;
}

- (void)setYSAlbumsCellContent:(UIImage *)image albumName:(NSString *)albumName photosNumber:(NSInteger)photos
{
    if (!image) {
        _iconImageView.image = [UIImage imageWithContentsOfFile:[[NSBundle mainBundle] pathForResource:@"defalut_image" ofType:@"png"]];
    }
    else {
        _iconImageView.image = image;
    }
    
    if (photos > 0) {
        _albumNameLabel.text = [NSString stringWithFormat:@"%@ - %ld", albumName, photos];
    }
    else {
        _albumNameLabel.text = [NSString stringWithFormat:@"%@", albumName];
    }
}

- (void)createSubViews
{
    _iconImageView = [[UIImageView alloc] initWithFrame:CGRectMake(0, 0, thumbImageWidth, thumbImageWidth)];
    [self.contentView addSubview:_iconImageView];
    
    _albumNameLabel = [[UILabel alloc] initWithFrame:CGRectMake(CGRectGetMaxX(_iconImageView.frame), 0, kMainScreenWidth - CGRectGetWidth(_iconImageView.frame) - 50, CGRectGetHeight(_iconImageView.frame))];
    _albumNameLabel.textAlignment = NSTextAlignmentLeft;
    _albumNameLabel.font = [UIFont systemFontOfSize:16.0];
    _albumNameLabel.textColor = [UIColor colorWithRed:233/255 green:233/255 blue:233/255 alpha:1];
    [self.contentView addSubview:_albumNameLabel];
}

@end
