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

- (instancetype)initWithStyle:(UITableViewCellStyle)style
              reuseIdentifier:(NSString *)reuseIdentifier
                    indexPath:(NSIndexPath *)indexPath
{
    if (self = [super initWithStyle:style reuseIdentifier:reuseIdentifier]) {
    
        if (indexPath.section == 0) {

            _cdLabel = [[UILabel alloc] initWithFrame:CGRectMake(0, 0, kScreenWidth, 30)];
            _cdLabel.backgroundColor = [UIColor redColor];
            [self.contentView addSubview:_cdLabel];
            
        }
        else {
            
            self.selectionStyle = UITableViewCellSelectionStyleNone;
            [self createTimeLevel];
        
            UICollectionViewFlowLayout * flowLayout = [[UICollectionViewFlowLayout alloc] init];
            flowLayout.scrollDirection = UICollectionViewScrollDirectionHorizontal;
            flowLayout.minimumInteritemSpacing = 0;
            flowLayout.minimumLineSpacing = 0;
            flowLayout.sectionInset = UIEdgeInsetsMake(0, 0, 0, 0);
            
            _cdCollectionView = [[UICollectionView alloc] initWithFrame:CGRectMake(itemSpace, 0, 7*itemSize, 4*itemSize) collectionViewLayout:flowLayout];
            _cdCollectionView.bounces = NO;
            _cdCollectionView.pagingEnabled = YES;
            _cdCollectionView.backgroundColor = [UIColor whiteColor];
            _cdCollectionView.showsVerticalScrollIndicator = NO;
            _cdCollectionView.showsHorizontalScrollIndicator = NO;
            [self.contentView addSubview:_cdCollectionView];
            
            [_cdCollectionView registerClass:[ChooseDataCollectionViewCell class] forCellWithReuseIdentifier:@"cdCollectionViewCellID"];
//            [_cdCollectionView registerClass:[UICollectionReusableView class] forSupplementaryViewOfKind:UICollectionElementKindSectionHeader withReuseIdentifier:@"cdCollectionViewSectionHead"];
//            [_cdCollectionView registerClass:[UICollectionReusableView class] forSupplementaryViewOfKind:UICollectionElementKindSectionFooter withReuseIdentifier:@"cdCollectionViewSectionFoot"];
            
            _cdPageControl = [[UIPageControl alloc] init];
            _cdPageControl.bounds = CGRectMake(0, 0, kScreenWidth, 20);
            _cdPageControl.center = CGPointMake(self.contentView.center.x, CGRectGetMaxY(_cdCollectionView.frame) + 10);
            _cdPageControl.currentPageIndicatorTintColor = [UIColor redColor];
            _cdPageControl.pageIndicatorTintColor = [UIColor lightGrayColor];
            _cdPageControl.numberOfPages = 2;
            _cdPageControl.currentPage = 0;
            [self.contentView addSubview:_cdPageControl];
            
            _cdPageControl.backgroundColor = [UIColor blueColor];
        }
    }
    return self;
}

// 简介
- (void)setChooseDataIntroduce:(NSString *)introduceStr
{
    
}

- (void)createTimeLevel
{
    UIView * leftLine = [[UIView alloc] initWithFrame:CGRectMake(0, 0, 1, 4*itemSize)];
    leftLine.backgroundColor = [UIColor lightGrayColor];
    [self.contentView addSubview:leftLine];
    
    UIView * rightLine = [[UIView alloc] initWithFrame:CGRectMake(itemSpace - 1, 0, 1, 4*itemSize)];
    rightLine.backgroundColor = [UIColor lightGrayColor];
    [self.contentView addSubview:rightLine];
    
    UIView * topLine = [[UIView alloc] initWithFrame:CGRectMake(0, 0, itemSpace, 1)];
    topLine.backgroundColor = [UIColor lightGrayColor];
    [self.contentView addSubview:topLine];
    
    UIView * line1 = [[UIView alloc] initWithFrame:CGRectMake(0, itemSize - 1, itemSpace, 1)];
    line1.backgroundColor = [UIColor lightGrayColor];
    [self.contentView addSubview:line1];
    
    UIView * line2 = [[UIView alloc] initWithFrame:CGRectMake(0, 2*itemSize - 1, itemSpace, 1)];
    line2.backgroundColor = [UIColor lightGrayColor];
    [self.contentView addSubview:line2];
    
    UIView * line3 = [[UIView alloc] initWithFrame:CGRectMake(0, 3*itemSize - 1, itemSpace, 1)];
    line3.backgroundColor = [UIColor lightGrayColor];
    [self.contentView addSubview:line3];
    
    UIView * bottemLine = [[UIView alloc] initWithFrame:CGRectMake(0, 4*itemSize - 1, itemSpace, 1)];
    bottemLine.backgroundColor = [UIColor lightGrayColor];
    [self.contentView addSubview:bottemLine];
    
    UILabel * label1 = [[UILabel alloc] initWithFrame:CGRectMake(1, itemSize, itemSpace, itemSize - 1)];
    label1.text = @"上午";
    label1.textAlignment = NSTextAlignmentCenter;
    [self.contentView addSubview:label1];
    
    UILabel * label2 = [[UILabel alloc] initWithFrame:CGRectMake(1, 2*itemSize, itemSpace, itemSize - 1)];
    label2.text = @"下午";
    label2.textAlignment = NSTextAlignmentCenter;
    [self.contentView addSubview:label2];
    
    UILabel * label3 = [[UILabel alloc] initWithFrame:CGRectMake(1, 3*itemSize, itemSpace, itemSize - 1)];
    label3.text = @"夜间";
    label3.textAlignment = NSTextAlignmentCenter;
    [self.contentView addSubview:label3];
}

@end
