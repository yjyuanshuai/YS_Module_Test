//
//  RootVCCollectionViewCell.h
//  MulImagePickerTest
//
//  Created by YJ on 16/1/14.
//  Copyright © 2016年 YJ. All rights reserved.
//

#import <UIKit/UIKit.h>


@interface RootVCCollectionViewCell : UICollectionViewCell

@property (nonatomic, strong) UIButton * imageClick;
@property (nonatomic, assign) NSIndexPath * indexPath;

- (void)setContentWithImage:(UIImage *)image;

@end
