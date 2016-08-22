//
//  ChooseDataCollectionViewCell.h
//  YS_iOS_Other
//
//  Created by YJ on 16/8/16.
//  Copyright © 2016年 YJ. All rights reserved.
//

#import <UIKit/UIKit.h>

#define itemSize (kScreenWidth)/7 //floorf((kScreenWidth)/7)
#define itemSpace (kScreenWidth - 7*itemSize)/8//(kScreenWidth - 7*itemSize)/8

@interface ChooseDataCollectionViewCell : UICollectionViewCell

@property (nonatomic, strong) UILabel * weekdayLabel;
@property (nonatomic, strong) UILabel * dataLabel;
@property (nonatomic, strong) UILabel * timeLabel;
@property (nonatomic, strong) UIView * rightLine;
@property (nonatomic, strong) UIView * topLine;

- (void)setCDCellContent:(NSIndexPath *)indexPath;

+ (NSDate *)getDateDayDetail:(NSInteger)index;

@end
