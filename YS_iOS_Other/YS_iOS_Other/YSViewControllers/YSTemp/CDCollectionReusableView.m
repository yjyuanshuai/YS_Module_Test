//
//  CDCollectionReusableView.m
//  YS_iOS_Other
//
//  Created by YJ on 16/8/22.
//  Copyright © 2016年 YJ. All rights reserved.
//

#import "CDCollectionReusableView.h"

@implementation CDCollectionReusableView

- (instancetype)initWithFrame:(CGRect)frame
{
    if (self = [super initWithFrame:frame]) {
        
        UIView * leftLine = [[UIView alloc] initWithFrame:CGRectMake(0, 0, 1, 4*itemSize)];
        leftLine.backgroundColor = [UIColor lightGrayColor];
        [self addSubview:leftLine];
        
        UIView * topLine = [[UIView alloc] initWithFrame:CGRectMake(0, 0, itemSize, 1)];
        topLine.backgroundColor = [UIColor lightGrayColor];
        [self addSubview:topLine];
        
        UIView * line1 = [[UIView alloc] initWithFrame:CGRectMake(0, itemSize - 1, itemSize, 1)];
        line1.backgroundColor = [UIColor lightGrayColor];
        [self addSubview:line1];
        
        UIView * line2 = [[UIView alloc] initWithFrame:CGRectMake(0, 2*itemSize - 1, itemSize, 1)];
        line2.backgroundColor = [UIColor lightGrayColor];
        [self addSubview:line2];
        
        UIView * line3 = [[UIView alloc] initWithFrame:CGRectMake(0, 3*itemSize - 1, itemSize, 1)];
        line3.backgroundColor = [UIColor lightGrayColor];
        [self addSubview:line3];
        
        UIView * bottemLine = [[UIView alloc] initWithFrame:CGRectMake(0, 4*itemSize - 1, itemSize, 1)];
        bottemLine.backgroundColor = [UIColor lightGrayColor];
        [self addSubview:bottemLine];
        
        UILabel * label1 = [[UILabel alloc] initWithFrame:CGRectMake(1, itemSize, itemSize, itemSize - 1)];
        label1.text = @"上午";
        label1.textAlignment = NSTextAlignmentCenter;
        [self addSubview:label1];
        
        UILabel * label2 = [[UILabel alloc] initWithFrame:CGRectMake(1, 2*itemSize, itemSize, itemSize - 1)];
        label2.text = @"下午";
        label2.textAlignment = NSTextAlignmentCenter;
        [self addSubview:label2];
        
        UILabel * label3 = [[UILabel alloc] initWithFrame:CGRectMake(1, 3*itemSize, itemSize, itemSize - 1)];
        label3.text = @"夜间";
        label3.textAlignment = NSTextAlignmentCenter;
        [self addSubview:label3];
        
//        label1.backgroundColor = [UIColor redColor];
//        label2.backgroundColor = [UIColor lightGrayColor];
//        label3.backgroundColor = [UIColor redColor];
    }
    return self;
}

@end
