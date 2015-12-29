//
//  ThreeTableViewCell.h
//  StoryboardTest
//
//  Created by YJ on 15/12/24.
//  Copyright © 2015年 YJ. All rights reserved.
//

#import <UIKit/UIKit.h>

@protocol ThreeCellDelegate <NSObject>

- (void)updateImageWithIndex:(UIImageView *)index cell:(id)cell;

@end

@interface ThreeTableViewCell : UITableViewCell

@property (weak, nonatomic) IBOutlet UIScrollView *scrollView;
@property (weak, nonatomic) IBOutlet UIImageView *imageView1;
@property (weak, nonatomic) IBOutlet UIImageView *imageView2;
@property (weak, nonatomic) IBOutlet UIImageView *imageView3;
@property (weak, nonatomic) IBOutlet UIImageView *imageView4;
@property (weak, nonatomic) IBOutlet UIImageView *imageView5;

@property (nonatomic, weak) id<ThreeCellDelegate>delegate;

@end
