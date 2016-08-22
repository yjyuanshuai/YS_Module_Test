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
        [self addOrUpdateConstraintForSubViewWithMarginX:_marginX marginY:_marginY space:_space];
        
    }
    return self;
}

#pragma mark - set
- (void)setSpace:(NSInteger)space
{
    _space = space;
    [self setNeedsUpdateConstraints];
}

- (void)setMarginX:(NSInteger)marginX
{
    _marginX = marginX;
    [self setNeedsUpdateConstraints];
}

- (void)setMarginY:(NSInteger)marginY
{
    _marginY = marginY;
    [self setNeedsUpdateConstraints];
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
    [self setNeedsUpdateConstraints];
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
    _marginX = 5;
    _marginY = 5;
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

- (void)addOrUpdateConstraintForSubViewWithMarginX:(NSInteger)xMargin marginY:(NSInteger)yMargin space:(NSInteger)ySpace
{
    NSDictionary * metricDic = @{@"marginX":@(xMargin), @"marginY":@(yMargin), @"space":@(ySpace)};
    NSDictionary * viewsDic= @{@"_btnTitle":_btnTitle, @"_btnImageView":_btnImageView};
    
    [self removeSelfAllContraints];
    
    NSString * t_h_vfl_1 = @"";
    NSString * i_h_vfl_1 = @"";
    NSString * t_v_vfl_2 = @"";
    
    if (_imagePostion == ImagePostionTop) {
        
        t_h_vfl_1 = @"H:|-marginX-[_btnImageView]-marginX-|";
        i_h_vfl_1 = @"H:|-marginX-[_btnTitle]-marginX-|";
        t_v_vfl_2 = @"V:|-marginY-[_btnImageView]-space-[_btnTitle]-marginY-|";
    }
    else if (_imagePostion == ImagePostionRight) {
        
        t_h_vfl_1 = @"V:|-marginY-[_btnTitle]-marginY-|";
        i_h_vfl_1 = @"V:|-marginY-[_btnImageView]-marginY-|";
        t_v_vfl_2 = @"H:|-marginX-[_btnTitle]-space-[_btnImageView]-marginX-|";
    }
    else if (_imagePostion == ImagePostionBottem) {
        
        t_h_vfl_1 = @"H:|-marginX-[_btnTitle]-marginX-|";
        i_h_vfl_1 = @"H:|-marginX-[_btnImageView]-marginX-|";
        t_v_vfl_2 = @"V:|-marginY-[_btnTitle]-space-[_btnImageView]-marginY-|";
    }
    else {
        
        t_h_vfl_1 = @"V:|-marginY-[_btnImageView]-marginY-|";
        i_h_vfl_1 = @"V:|-marginY-[_btnTitle]-marginY-|";
        t_v_vfl_2 = @"H:|-marginX-[_btnImageView]-space-[_btnTitle]-marginX-|";
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

- (void)updateConstraints
{
    [self addOrUpdateConstraintForSubViewWithMarginX:_marginX marginY:_marginY space:_space];
    [super updateConstraints];
}

@end
