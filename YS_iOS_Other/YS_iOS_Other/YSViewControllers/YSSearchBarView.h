//
//  YSSearchBar.h
//  YS_iOS_Other
//
//  Created by YJ on 16/6/23.
//  Copyright © 2016年 YJ. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface YSSearchBarView : NSObject <UISearchBarDelegate>

@property (nonatomic, strong) UISearchBar * ysSearchBar;
@property (nonatomic, strong) UIView *      contentView;

@property (nonatomic, assign) CGFloat       pushViewAlpha;
@property (nonatomic, strong) UIColor *     pushViewBgColor;

@property (nonatomic, assign) BOOL          isShowInNavigationBar;

- (instancetype)initWithSearchBar:(UISearchBar *)searchBar viewController:(UIViewController *)viewController;

- (void)begainSearchAndShowPushView;
- (void)cancleSearchAndHidePushView;

@end
