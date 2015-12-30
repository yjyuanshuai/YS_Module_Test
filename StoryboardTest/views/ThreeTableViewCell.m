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
    UILongPressGestureRecognizer * longGesture = [[UILongPressGestureRecognizer alloc] initWithTarget:self action:@selector(longTouch:)];
    [_scrollView addGestureRecognizer:longGesture];
    
}

- (void)onClick:(UIButton *)btn
{
    if (_delegate && [_delegate respondsToSelector:@selector(displayImageWithIndex:)]) {
        [_delegate displayImageWithIndex:btn.tag - BUTTON_TAG];
    }
}

- (void)longTouch:(id)gesture
{
    UILongPressGestureRecognizer * tempGesture = (UILongPressGestureRecognizer *)gesture;
    
    CGPoint point = [tempGesture locationInView:_scrollView];
    NSLog(@"-------- %f", point.x);
    int x = point.x / _imageView1.frame.size.width;
    
    if (_delegate && [_delegate respondsToSelector:@selector(updateImageWithIndex:)]) {
        [_delegate updateImageWithIndex:[_imageArr objectAtIndex:x]];
    }
}



- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
