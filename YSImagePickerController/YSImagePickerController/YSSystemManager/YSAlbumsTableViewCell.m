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

- (void)setYSAlbumsCellContent:(UIImage *)image photosNumber:(NSInteger)photos
{
    
}

- (void)createSubViews
{
    _iconImageView = [[UIImageView alloc] initWithFrame:CGRectMake(0, 0, self.contentView.frame.size.width, self.contentView.frame.size.width)];
    [self.contentView addSubview:_iconImageView];
    
    _albumNameLabel = [[UILabel alloc] initWithFrame:CGRectMake(CGRectGetMaxX(_iconImageView.frame), 0, kMainScreenWidth - CGRectGetWidth(_iconImageView.frame) - 50, CGRectGetHeight(_iconImageView.frame))];
}

@end
