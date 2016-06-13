//
//  RootVCCollectionViewCell.m
//  MulImagePickerTest
//
//  Created by YJ on 16/1/14.
//  Copyright © 2016年 YJ. All rights reserved.
//

#import "RootVCCollectionViewCell.h"

#define Image_Tag 1111

@implementation RootVCCollectionViewCell

/**/
- (instancetype)initWithFrame:(CGRect)frame
{
    if (self = [super initWithFrame:frame]) {
        self.backgroundColor = [UIColor whiteColor];
        
        _imageClick = [[UIButton alloc] init];
        _imageClick.backgroundColor = [UIColor colorWithWhite:1.000 alpha:0.500];
        _imageClick.contentMode = UIViewContentModeScaleAspectFill;
        _imageClick.userInteractionEnabled = NO;
        _imageClick.tag = Image_Tag + _indexPath.row;
        NSLog(@"--------- cell indexPath:%d", (int)_indexPath.row);
        [_imageClick setBackgroundImage:[UIImage imageNamed:@"AlbumAddBtn"] forState:UIControlStateNormal];
//        [_imageClick addTarget:self action:@selector(showImage:) forControlEvents:UIControlEventTouchUpInside];
        [self addSubview:_imageClick];
        self.clipsToBounds = YES;
    }
    return self;
}
 

- (void)layoutSubviews
{
    [super layoutSubviews];
    _imageClick.frame = self.bounds;
//    NSLog(@"-------- boundsWidth: %f +++++++ boundsHeight: %f", _imageClick.frame.size.width, _imageClick.frame.size.height);
}

- (void)setContentWithImage:(UIImage *)image
{
    [_imageClick setBackgroundImage:image forState:UIControlStateNormal];
}

@end
