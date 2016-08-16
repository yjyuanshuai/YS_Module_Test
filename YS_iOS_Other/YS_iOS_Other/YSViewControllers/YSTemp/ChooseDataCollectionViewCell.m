//
//  ChooseDataCollectionViewCell.m
//  YS_iOS_Other
//
//  Created by YJ on 16/8/16.
//  Copyright © 2016年 YJ. All rights reserved.
//

#import "ChooseDataCollectionViewCell.h"

@implementation ChooseDataCollectionViewCell
{
    CGFloat _itemSize;
}

- (instancetype)initWithFrame:(CGRect)frame
{
    if (self = [super initWithFrame:frame]) {
        
        _itemSize = (kScreenWidth)/7;
        
        _weekdayLabel = [[UILabel alloc] initWithFrame:CGRectMake(0, 0, _itemSize, _itemSize/2)];
        _weekdayLabel.textAlignment = NSTextAlignmentCenter;
        _weekdayLabel.backgroundColor = [UIColor whiteColor];
        [self.contentView addSubview:_weekdayLabel];
        
        _dataLabel = [[UILabel alloc] initWithFrame:CGRectMake(0, _itemSize/2, _itemSize, _itemSize/2)];
        _dataLabel.textAlignment = NSTextAlignmentCenter;
        _dataLabel.backgroundColor = [UIColor whiteColor];
        [self.contentView addSubview:_dataLabel];
        
        _timeLabel = [[UILabel alloc] initWithFrame:CGRectMake(0, 0, _itemSize, _itemSize)];
        _timeLabel.textAlignment = NSTextAlignmentCenter;
        _timeLabel.backgroundColor = [UIColor orangeColor];
        [self.contentView addSubview:_timeLabel];
    }
    return self;
}

- (void)setCDCellContent:(NSIndexPath *)indexPath
{
    
    
    if (indexPath.row == 0) {
        
        _timeLabel.hidden = YES;
        _weekdayLabel.hidden = NO;
        _dataLabel.hidden = NO;
        
        _weekdayLabel.text = [self getWeekday:indexPath];
        
    }
    else {
        
        _weekdayLabel.hidden = YES;
        _dataLabel.hidden = YES;
        
        
        
        // 当前有号源时
        _timeLabel.hidden = NO;
        
        if (indexPath.row == 1) {
            _timeLabel.text = @"上午";
        }
        else if (indexPath.row == 2) {
            _timeLabel.text = @"下午";
        }
        else if (indexPath.row == 3) {
            _timeLabel.text = @"夜间";
        }
    }
}

#pragma mark - 
- (NSString *)getWeekday:(NSIndexPath *)indexPath
{
    NSInteger sectionNum = indexPath.section % 7;
    switch (sectionNum) {
        case 0:
        {
            return @"周日";
        }
            break;
        case 1:
        {
            return @"周一";
        }
            break;
        case 2:
        {
            return @"周二";
        }
            break;
        case 3:
        {
            return @"周三";
        }
            break;
        case 4:
        {
            return @"周四";
        }
            break;
        case 5:
        {
            return @"周五";
        }
            break;
        case 6:
        {
            return @"周六";
        }
            break;
    }
    return @"";
}

@end
