//
//  ChooseDataCollectionViewCell.h
//  YS_iOS_Other
//
//  Created by YJ on 16/8/16.
//  Copyright © 2016年 YJ. All rights reserved.
//

#import <UIKit/UIKit.h>

#define itemSize floorf((kScreenWidth)/8*100)/100
#define itemSpace kScreenWidth - 7*itemSize

@interface ChooseDataCollectionViewCell : UICollectionViewCell

@property (nonatomic, strong) UILabel * weekdayLabel;
@property (nonatomic, strong) UILabel * dataLabel;
@property (nonatomic, strong) UILabel * timeLabel;
@property (nonatomic, strong) UIView * xLine;
@property (nonatomic, strong) UIView * yLine;

- (void)setCDCellContent:(NSIndexPath *)indexPath;

+ (NSDate *)getDateDayDetail:(NSInteger)index;
+ (NSString *)getSectionTitleDateDay:(NSInteger)index;

@end
