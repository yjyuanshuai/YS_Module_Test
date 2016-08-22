//
//  ChooseDataTableViewCell.h
//  YS_iOS_Other
//
//  Created by YJ on 16/8/16.
//  Copyright © 2016年 YJ. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "CDCollectionReusableView.h"

@interface ChooseDataTableViewCell : UITableViewCell

@property (nonatomic, strong) UILabel * cdLabel;

@property (nonatomic, strong) UICollectionView * cdCollectionView;
@property (nonatomic, strong) UIPageControl * cdPageControl;


- (instancetype)initWithStyle:(UITableViewCellStyle)style
              reuseIdentifier:(NSString *)reuseIdentifier
                    indexPath:(NSIndexPath *)indexPath;

- (void)setChooseDataIntroduce:(NSString *)introduceStr;

@end
