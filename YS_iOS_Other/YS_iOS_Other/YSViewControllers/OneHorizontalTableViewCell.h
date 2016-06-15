//
//  OneHorizontalTableViewCell.h
//  YS_iOS_Other
//
//  Created by YJ on 16/6/14.
//  Copyright © 2016年 YJ. All rights reserved.
//

#import <UIKit/UIKit.h>
@class CollectionTestModel;


@protocol OneHorizontalTableViewCellDelegate <NSObject>

- (void)panGesureWithView:(NSIndexPath *)indexPath panGesure:(UIGestureRecognizer *)gesure view:(UIView *)view;

@end

@interface OneHorizontalTableViewCell : UITableViewCell

@property (nonatomic, strong) UIImageView * ysImageView;
@property (nonatomic, strong) UILabel * itemTitle;
@property (nonatomic, strong) UILabel * itemDesc;

@property (nonatomic, strong) UIPanGestureRecognizer * longGesure;

@property (nonatomic, weak) id<OneHorizontalTableViewCellDelegate>delegate;

- (void)setCellContent:(CollectionTestModel *)model indexPath:(NSIndexPath *)indexPath;

@end
