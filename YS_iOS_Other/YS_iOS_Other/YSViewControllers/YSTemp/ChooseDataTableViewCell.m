//
//  ChooseDataTableViewCell.m
//  YS_iOS_Other
//
//  Created by YJ on 16/8/16.
//  Copyright © 2016年 YJ. All rights reserved.
//

#import "ChooseDataTableViewCell.h"

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
        
            UICollectionViewFlowLayout * flowLayout = [[UICollectionViewFlowLayout alloc] init];
            flowLayout.scrollDirection = UICollectionViewScrollDirectionHorizontal;
            flowLayout.minimumInteritemSpacing = 0;
            flowLayout.minimumLineSpacing = 0;
            flowLayout.sectionInset = UIEdgeInsetsMake(0, 0, 0, 0);
            
            _cdCollectionView = [[UICollectionView alloc] initWithFrame:CGRectMake(0, 0, kScreenWidth, 4*itemSize) collectionViewLayout:flowLayout];
            _cdCollectionView.bounces = NO;
            _cdCollectionView.pagingEnabled = YES;
            _cdCollectionView.backgroundColor = [UIColor whiteColor];
            _cdCollectionView.showsVerticalScrollIndicator = NO;
            _cdCollectionView.showsHorizontalScrollIndicator = NO;
            [self.contentView addSubview:_cdCollectionView];
            
            [_cdCollectionView registerClass:[ChooseDataCollectionViewCell class] forCellWithReuseIdentifier:@"cdCollectionViewCellID"];
            [_cdCollectionView registerClass:[CDCollectionReusableView class] forSupplementaryViewOfKind:UICollectionElementKindSectionHeader withReuseIdentifier:@"cdCollectionViewSectionHead"];
            [_cdCollectionView registerClass:[UICollectionReusableView class] forSupplementaryViewOfKind:UICollectionElementKindSectionFooter withReuseIdentifier:@"cdCollectionViewSectionFoot"];
            
            _cdPageControl = [[UIPageControl alloc] init];
            _cdPageControl.bounds = CGRectMake(0, 0, 100, 20);
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

@end
