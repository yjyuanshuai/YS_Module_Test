//
//  ChooseDataCollectionViewCell.h
//  YS_iOS_Other
//
//  Created by YJ on 16/8/16.
//  Copyright © 2016年 YJ. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface ChooseDataCollectionViewCell : UICollectionViewCell

@property (nonatomic, strong) UILabel * weekdayLabel;
@property (nonatomic, strong) UILabel * dataLabel;
@property (nonatomic, strong) UILabel * timeLabel;

- (void)setCDCellContent:(NSIndexPath *)indexPath;

@end
