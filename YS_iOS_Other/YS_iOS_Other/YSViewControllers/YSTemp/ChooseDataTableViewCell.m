//
//  ChooseDataTableViewCell.m
//  YS_iOS_Other
//
//  Created by YJ on 16/8/16.
//  Copyright © 2016年 YJ. All rights reserved.
//

#import "ChooseDataTableViewCell.h"
#import "ChooseDataCollectionViewCell.h"

@implementation ChooseDataTableViewCell
{
    CGFloat _itemSize;
}

- (instancetype)initWithStyle:(UITableViewCellStyle)style
              reuseIdentifier:(NSString *)reuseIdentifier
                    indexPath:(NSIndexPath *)indexPath
{
    if (self = [super initWithStyle:style reuseIdentifier:reuseIdentifier]) {
        if (indexPath.section == 0) {
            //
            _cdLabel = [[UILabel alloc] initWithFrame:CGRectMake(0, 0, kScreenWidth, 30)];
            _cdLabel.backgroundColor = [UIColor redColor];
            [self.contentView addSubview:_cdLabel];
            
        }
        else {
            
            // 选择日期
            _itemSize = (kScreenWidth)/7;
            
            UICollectionViewFlowLayout * flowLayout = [[UICollectionViewFlowLayout alloc] init];
            flowLayout.scrollDirection = UICollectionViewScrollDirectionHorizontal;
            
            _cdCollectionView = [[UICollectionView alloc] initWithFrame:CGRectMake(0, 0, kScreenWidth, 4*_itemSize) collectionViewLayout:flowLayout];
            _cdCollectionView.scrollEnabled = NO;
            _cdCollectionView.pagingEnabled = YES;
            _cdCollectionView.backgroundColor = [UIColor whiteColor];
            _cdCollectionView.showsVerticalScrollIndicator = NO;
            _cdCollectionView.showsHorizontalScrollIndicator = NO;
            [self.contentView addSubview:_cdCollectionView];
            
            [_cdCollectionView registerClass:[ChooseDataCollectionViewCell class] forCellWithReuseIdentifier:@"cdCollectionViewCellID"];
            
            [self createLines];
        }
    }
    return self;
}

// 简介
- (void)setChooseDataIntroduce:(NSString *)introduceStr
{
    
}

- (void)createLines
{
    CAShapeLayer * shapeLayer = [CAShapeLayer layer];
    UIBezierPath * bezierPath = [UIBezierPath bezierPath];
    
    CGPoint h_l_1 = CGPointMake(0, _itemSize);
    CGPoint h_l_2 = CGPointMake(0, 2*_itemSize);
    CGPoint h_l_3 = CGPointMake(0, 3*_itemSize);
    
    CGPoint h_r_1 = CGPointMake(kScreenWidth, _itemSize);
    CGPoint h_r_2 = CGPointMake(kScreenWidth, 2*_itemSize);
    CGPoint h_r_3 = CGPointMake(kScreenWidth, 3*_itemSize);
    
    CGPoint v_u_1 = CGPointMake(_itemSize, 0);
    CGPoint v_u_2 = CGPointMake(2*_itemSize, 0);
    CGPoint v_u_3 = CGPointMake(3*_itemSize, 0);
    CGPoint v_u_4 = CGPointMake(4*_itemSize, 0);
    CGPoint v_u_5 = CGPointMake(5*_itemSize, 0);
    CGPoint v_u_6 = CGPointMake(6*_itemSize, 0);
    
    CGPoint v_d_1 = CGPointMake(_itemSize, 4*_itemSize);
    CGPoint v_d_2 = CGPointMake(2*_itemSize, 4*_itemSize);
    CGPoint v_d_3 = CGPointMake(3*_itemSize, 4*_itemSize);
    CGPoint v_d_4 = CGPointMake(4*_itemSize, 4*_itemSize);
    CGPoint v_d_5 = CGPointMake(5*_itemSize, 4*_itemSize);
    CGPoint v_d_6 = CGPointMake(6*_itemSize, 4*_itemSize);
    
    [bezierPath moveToPoint:h_l_1];
    [bezierPath addLineToPoint:h_r_1];
    [bezierPath moveToPoint:h_r_2];
    [bezierPath addLineToPoint:h_l_2];
    [bezierPath moveToPoint:h_l_3];
    [bezierPath addLineToPoint:h_r_3];
    
    shapeLayer.path = bezierPath.CGPath;
    shapeLayer.borderColor = [UIColor blackColor].CGColor;
    shapeLayer.borderWidth = 1.0;
    
    [self.layer insertSublayer:shapeLayer above:self.contentView.layer];
}

@end
