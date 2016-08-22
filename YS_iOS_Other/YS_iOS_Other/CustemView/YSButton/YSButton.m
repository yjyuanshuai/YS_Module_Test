//
//  YSButton.m
//  YS_iOS_Other
//
//  Created by YJ on 16/8/18.
//  Copyright © 2016年 YJ. All rights reserved.
//

#import "YSButton.h"

@implementation YSButton

- (instancetype)initWithFrame:(CGRect)frame
{
    return [self initWithFrame:frame imagePostion:ImagePostionLeft];
}

- (instancetype)initWithFrame:(CGRect)frame imagePostion:(ImagePostion)postion
{
    if (self = [super initWithFrame:frame]) {
        
        [self initData:postion];
        [self createSubView];
        [self addOrUpdateConstraintForSubView:_margin space:_space];
        
    }
    return self;
}

#pragma mark - set
- (void)setSpace:(NSInteger)space
{
    _space = space;
    [self addOrUpdateConstraintForSubView:_margin space:_space];
}

- (void)setMargin:(NSInteger)margin
{
    _margin = margin;
    [self addOrUpdateConstraintForSubView:_margin space:_space];
}

- (void)setYsBtnTintColor:(UIColor *)ysBtnTintColor
{
    _ysBtnTintColor = ysBtnTintColor;
    self.backgroundColor = _ysBtnTintColor;
}

- (void)setYsTintColor:(UIColor *)ysTintColor
{
    _ysTintColor = ysTintColor;
    _btnTitle.textColor = ysTintColor;
}

- (void)setTintColor:(UIColor *)tintColor
{
    _ysTintColor = tintColor;
    _btnTitle.textColor = tintColor;
}

- (void)setImagePostion:(ImagePostion)postion
{
    _imagePostion = postion;
    [self addOrUpdateConstraintForSubView:_margin space:_space];
}

- (void)setConstraintsArr:(NSMutableArray *)constraintsArr
{
    if (constraintsArr == nil || [constraintsArr count] == 0) {
        // 废弃所有约束
        [self removeSelfAllContraints];
    }
}

#pragma mark - private
- (void)initData:(ImagePostion)postion
{
    _imagePostion = postion;
    _margin = 5;
    _space = 5;
    _constraintsArr = [NSMutableArray array];
    
    _ysBtnTintColor = [UIColor clearColor];
    self.backgroundColor = _ysBtnTintColor;
    
    _ysTintColor = [UIColor blackColor];
    _btnTitle.textColor = _ysTintColor;
}

- (void)createSubView
{
    _btnTitle = [UILabel new];
    _btnTitle.adjustsFontSizeToFitWidth = YES;
    _btnTitle.numberOfLines = 0;
    _btnTitle.translatesAutoresizingMaskIntoConstraints = NO;
    [self addSubview:_btnTitle];
    
    _btnImageView = [UIImageView new];
    _btnImageView.translatesAutoresizingMaskIntoConstraints = NO;
    [self addSubview:_btnImageView];
}

- (void)addOrUpdateConstraintForSubView:(NSInteger)yMargin space:(NSInteger)ySpace
{
    NSDictionary * metricDic = @{@"margin":@(yMargin), @"space":@(ySpace)};
    NSDictionary * viewsDic= @{@"_btnTitle":_btnTitle, @"_btnImageView":_btnImageView};
    
    [self removeSelfAllContraints];
    
    NSString * t_h_vfl_1 = @"";
    NSString * i_h_vfl_1 = @"";
    NSString * t_v_vfl_2 = @"";
    
    if (_imagePostion == ImagePostionTop) {
        
        t_h_vfl_1 = @"H:|-margin-[_btnImageView]-margin-|";
        i_h_vfl_1 = @"H:|-margin-[_btnTitle]-margin-|";
        t_v_vfl_2 = @"V:|-margin-[_btnImageView]-space-[_btnTitle]-margin-|";
    }
    else if (_imagePostion == ImagePostionRight) {
        
        t_h_vfl_1 = @"V:|-margin-[_btnTitle]-margin-|";
        i_h_vfl_1 = @"V:|-margin-[_btnImageView]-margin-|";
        t_v_vfl_2 = @"H:|-margin-[_btnTitle]-space-[_btnImageView]-margin-|";
    }
    else if (_imagePostion == ImagePostionBottem) {
        
        t_h_vfl_1 = @"H:|-margin-[_btnTitle]-margin-|";
        i_h_vfl_1 = @"H:|-margin-[_btnImageView]-margin-|";
        t_v_vfl_2 = @"V:|-margin-[_btnTitle]-space-[_btnImageView]-margin-|";
    }
    else {
        
        t_h_vfl_1 = @"V:|-margin-[_btnImageView]-margin-|";
        i_h_vfl_1 = @"V:|-margin-[_btnTitle]-margin-|";
        t_v_vfl_2 = @"H:|-margin-[_btnImageView]-space-[_btnTitle]-margin-|";
    }
    
    NSArray * c_1 = [NSLayoutConstraint constraintsWithVisualFormat:t_h_vfl_1
                                                            options:0
                                                            metrics:metricDic
                                                              views:viewsDic];
    
    NSArray * c_2 = [NSLayoutConstraint constraintsWithVisualFormat:i_h_vfl_1
                                                            options:0
                                                            metrics:metricDic
                                                              views:viewsDic];
    
    NSArray * c_3 = [NSLayoutConstraint constraintsWithVisualFormat:t_v_vfl_2
                                                            options:0
                                                            metrics:metricDic
                                                              views:viewsDic];
    [self addConstraints:c_1];
    [self addConstraints:c_2];
    [self addConstraints:c_3];
    
    [_constraintsArr addObjectsFromArray:@[c_1, c_2, c_3]];
}

- (void)removeSelfAllContraints
{
    if (_constraintsArr && [_constraintsArr count] > 0) {
        for (NSArray * arr in _constraintsArr) {
            [self removeConstraints:arr];
        }
        [_constraintsArr removeAllObjects];
    }
}

@end
