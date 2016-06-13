//
//  ImageLoadingView.h
//  HUDTest2
//
//  Created by YJ on 15/12/31.
//  Copyright © 2015年 YJ. All rights reserved.
//

#import <UIKit/UIKit.h>

typedef NS_ENUM(NSInteger, ImageLoadingViewMode)
{
    ImageLoadingViewModeImage
};

@interface ImageLoadingView : UIView

@property (weak, nonatomic) IBOutlet UIImageView *loadingImage;

//+ (void)showLoadingViewInView:(UIViewController *)viewController;

@end
