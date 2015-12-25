//
//  ThreeTableViewCell.m
//  StoryboardTest
//
//  Created by YJ on 15/12/24.
//  Copyright © 2015年 YJ. All rights reserved.
//

#import "ThreeTableViewCell.h"
#define BUTTON_TAG 1000

@implementation ThreeTableViewCell
{
    NSArray * _imageArr;
}
- (void)awakeFromNib {
    // Initialization code
    
    _imageArr = @[_imageView1, _imageView2, _imageView3, _imageView4, _imageView5];
    for (int i = 0; i < 5; i++) {
        UIImageView * imgView = _imageArr[i];
        UIButton * btn = [UIButton buttonWithType:UIButtonTypeCustom];
        btn.frame = CGRectMake(0, 0, imgView.frame.size.width, imgView.frame.size.height);
        btn.tag = BUTTON_TAG + i;
        [btn addTarget:self action:@selector(onClick:) forControlEvents:UIControlEventTouchUpInside];
        [imgView addSubview:btn];
    }
    
    
}

- (void)onClick:(UIButton *)btn
{
    NSLog(@"------------ btn : %d", (int)btn.tag);
    if (_delegate && [_delegate respondsToSelector:@selector(updateImageWithIndex:)]) {
        [_delegate updateImageWithIndex:btn.tag - BUTTON_TAG];
    }
}




- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
