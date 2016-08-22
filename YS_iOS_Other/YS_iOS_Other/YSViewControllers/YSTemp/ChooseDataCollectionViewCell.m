//
//  ChooseDataCollectionViewCell.m
//  YS_iOS_Other
//
//  Created by YJ on 16/8/16.
//  Copyright © 2016年 YJ. All rights reserved.
//

#import "ChooseDataCollectionViewCell.h"
#import "NSDate+Utilities.h"

static NSInteger LineTag = 20160817;

@implementation ChooseDataCollectionViewCell

- (instancetype)initWithFrame:(CGRect)frame
{
    if (self = [super initWithFrame:frame]) {
        
//        NSLog(@"----------- itemSize:%f ----------- itemSpace: %f",itemSize, itemSpace);
        
        _weekdayLabel = [[UILabel alloc] initWithFrame:CGRectMake(0, 0, itemSize, itemSize/2)];
        _weekdayLabel.textAlignment = NSTextAlignmentCenter;
        _weekdayLabel.backgroundColor = [UIColor clearColor];
        [self.contentView addSubview:_weekdayLabel];
        
        _dataLabel = [[UILabel alloc] initWithFrame:CGRectMake(0, itemSize/2, itemSize, itemSize/2)];
        _dataLabel.textAlignment = NSTextAlignmentCenter;
        _dataLabel.backgroundColor = [UIColor clearColor];
        [self.contentView addSubview:_dataLabel];
        
        _timeLabel = [[UILabel alloc] initWithFrame:CGRectMake(0, 0, itemSize, itemSize)];
        _timeLabel.textAlignment = NSTextAlignmentCenter;
        _timeLabel.backgroundColor = [UIColor whiteColor];
        [self.contentView addSubview:_timeLabel];
        
        UIView * leftLine = [[UIView alloc] initWithFrame:CGRectMake(0, 0, 1, itemSize)];
        leftLine.backgroundColor = [UIColor lightGrayColor];
        [self.contentView addSubview:leftLine];
        
        UIView * bottemLine = [[UIView alloc] initWithFrame:CGRectMake(0, itemSize - 1, itemSize, 1)];
        bottemLine.backgroundColor = [UIColor lightGrayColor];
        [self.contentView addSubview:bottemLine];
        
        _topLine = [[UIView alloc] initWithFrame:CGRectMake(0, 0, itemSize, 1)];
        _topLine.backgroundColor = [UIColor lightGrayColor];
        _topLine.hidden = YES;
        [self.contentView addSubview:_topLine];
        
        _rightLine = [[UIView alloc] initWithFrame:CGRectMake(0, itemSize - 1, 3, itemSize)];
        _rightLine.backgroundColor = [UIColor lightGrayColor];
        _rightLine.hidden = NO;
        [self.contentView addSubview:_rightLine];
    }
    return self;
}

- (void)setCDCellContent:(NSIndexPath *)indexPath
{
    if (indexPath.section == 13) {
        _rightLine.hidden = NO;
    }
    else {
        _rightLine.hidden = YES;
    }
    
    if (indexPath.row == 0) {
        
        _topLine.hidden = NO;
        _timeLabel.hidden = YES;
        _weekdayLabel.hidden = NO;
        _dataLabel.hidden = NO;
        
        _weekdayLabel.text = [self getWeekday:indexPath.section];
        _dataLabel.text = [self getDateDay:indexPath.section];
        
    }
    else {
        
        _topLine.hidden = YES;
        _weekdayLabel.hidden = YES;
        _dataLabel.hidden = YES;
        
        // 有号源
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

/**
 *  获取日期
 *
 */
+ (NSDate *)getDateDayDetail:(NSInteger)index
{
    NSDate * todayDate = [[NSDate date] dateAtStartOfDay];
    NSInteger weekday = todayDate.weekday;
    
    if (index >= weekday - 1) {
        return [NSDate dateWithDaysFromNow:index - weekday + 1];
    }
    else {
        return [NSDate dateWithDaysBeforeNow:weekday - 1 - index];
    }
}

#pragma mark - private
- (NSString *)getDateDay:(NSInteger)index
{
    NSDate * currentDate = [ChooseDataCollectionViewCell getDateDayDetail:index];
    
    if (currentDate.month < 10) {
        return [currentDate stringFromFormatterString:@"M-dd"];
    }
    return [currentDate stringFromFormatterString:@"MM-dd"];
}

- (NSString *)getWeekday:(NSInteger)index
{
    switch (index % 7) {
        case 0:
        {
            return @"周日";
        }
        case 1:
        {
            return @"周一";
        }
        case 2:
        {
            return @"周二";
        }
        case 3:
        {
            return @"周三";
        }
        case 4:
        {
            return @"周四";
        }
        case 5:
        {
            return @"周五";
        }
        case 6:
        {
            return @"周六";
        }
    }
    return @"";
}

- (void)createLines
{
    CGFloat lineWidth = 0.5;
    
    UIView * topLine = [[UIView alloc]initWithFrame:CGRectMake(0, 0, itemSize, lineWidth)];
    topLine.backgroundColor = [UIColor blackColor];
    topLine.tag = LineTag;
    [self.contentView addSubview:topLine];
    
    UIView * leftLine = [[UIView alloc] initWithFrame:CGRectMake(0, 0, lineWidth, itemSize)];
    leftLine.backgroundColor = [UIColor blackColor];
    leftLine.tag = LineTag + 1;
    [self.contentView addSubview:leftLine];
    
    UIView * bottemLine = [[UIView alloc] initWithFrame:CGRectMake(0, itemSize - lineWidth, itemSize, lineWidth)];
    bottemLine.backgroundColor = [UIColor blackColor];
    bottemLine.tag = LineTag + 2;
    [self.contentView addSubview:bottemLine];
    
    UIView * rightLine = [[UIView alloc] initWithFrame:CGRectMake(itemSize - lineWidth, 0, lineWidth, itemSize)];
    rightLine.backgroundColor = [UIColor blackColor];
    rightLine.tag = LineTag + 3;
    [self.contentView addSubview:rightLine];
}

@end
