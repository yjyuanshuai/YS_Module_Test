//
//  YSSearchBar.m
//  YS_iOS_Other
//
//  Created by YJ on 16/6/23.
//  Copyright © 2016年 YJ. All rights reserved.
//

#import "YSSearchBarView.h"

@interface YSSearchBarView()

@property (nonatomic, strong) UIView * searchingPushView;
@property (nonatomic, strong) UITapGestureRecognizer * pushTapGesure;
@property (nonatomic, weak)   UIViewController * viewController;

@end

@implementation YSSearchBarView

- (instancetype)initWithSearchBar:(UISearchBar *)searchBar viewController:(UIViewController *)viewController
{
    if (self = [super init]) {
        
        _viewController = viewController;
        [self initProperty];
        [self setupSearchBar:searchBar];
        [self createPushView];
        [self createContentView];
    }
    return self;
}

- (void)dealloc
{

}

#pragma mark - 
- (void)setIsShowInNavigationBar:(BOOL)isShowInNavigationBar
{
    _isShowInNavigationBar = isShowInNavigationBar;
    
    if (isShowInNavigationBar) {
        if ([_ysSearchBar isDescendantOfView:_viewController.view]) {
            [_ysSearchBar removeFromSuperview];
            _viewController.navigationItem.titleView = _ysSearchBar;
        }
    } else {
        if (![_ysSearchBar isDescendantOfView:_viewController.view]) {
            [_ysSearchBar removeFromSuperview];
            [_viewController.view addSubview:_ysSearchBar];
        }
    }
}

#pragma mark -
- (void)initProperty
{
    _isShowInNavigationBar = NO;
    _pushViewAlpha = 0.5;
    _pushViewBgColor = [UIColor blackColor];
    _ysSearchBar = nil;
}

- (void)setupSearchBar:(UISearchBar *)searchBar
{
    _ysSearchBar = searchBar;
    [_viewController.view addSubview:_ysSearchBar];
    
    if ([_ysSearchBar respondsToSelector:@selector(searchBarShouldBeginEditing:)]) {
        [self begainSearchAndShowPushView];
    }
}

- (void)createContentView
{
    _contentView = [[UIView alloc] initWithFrame:CGRectMake(0, 64, kScreenWidth, kScreenHeight - 64)];
    _contentView.backgroundColor = [UIColor whiteColor];
    _contentView.hidden = YES;
    [_viewController.view addSubview:_contentView];
}

- (void)createPushView
{
    _searchingPushView = [[UIView alloc] initWithFrame:CGRectMake(0, kScreenHeight, kScreenWidth, kScreenHeight - 64)];
    _searchingPushView.backgroundColor = _pushViewBgColor;
    _searchingPushView.alpha = _pushViewAlpha;
    [_viewController.view addSubview:_searchingPushView];
    
    _pushTapGesure = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(cancleSearch:)];
    _pushTapGesure.numberOfTapsRequired = 1;
    _pushTapGesure.numberOfTouchesRequired = 1;
    [_searchingPushView addGestureRecognizer:_pushTapGesure];
}

#pragma mark - 
- (void)cancleSearch:(UITapGestureRecognizer *)tapGesure
{
    [self cancleSearchAndHidePushView];
}

- (void)begainSearchAndShowPushView
{
    if (_isShowInNavigationBar) {
        
        [UIView animateWithDuration:0.5 animations:^{
            _searchingPushView.transform = CGAffineTransformMakeTranslation(0, -(kScreenHeight - 64));
            _ysSearchBar.showsCancelButton = YES;
        }];
        
    } else {
        
        [UIView animateWithDuration:0.5 animations:^{
            _viewController.navigationController.navigationBar.transform = CGAffineTransformMakeTranslation(0, -64);
            CGFloat searchBarOriginY = _ysSearchBar.frame.origin.y;
            
            if (_viewController.navigationController.navigationBar.translucent == NO) {
                _ysSearchBar.transform = CGAffineTransformMakeTranslation(0, -(searchBarOriginY + 44));
            } else {
                _ysSearchBar.transform = CGAffineTransformMakeTranslation(0, -(searchBarOriginY - 44));
            }
            
            _searchingPushView.transform = CGAffineTransformMakeTranslation(0, -(kScreenHeight - 64));
            _ysSearchBar.showsCancelButton = YES;
        }];
        
    }
}

- (void)cancleSearchAndHidePushView
{
    if (_isShowInNavigationBar) {
        
        [UIView animateWithDuration:0.5 animations:^{
            _searchingPushView.transform = CGAffineTransformMakeTranslation(0, kScreenHeight - 64);
            [_ysSearchBar endEditing:YES];
            _ysSearchBar.showsCancelButton = NO;
        }];
        
    } else {
        
        [UIView animateWithDuration:0.5 animations:^{
            _viewController.navigationController.navigationBar.transform = CGAffineTransformIdentity;
            _ysSearchBar.transform = CGAffineTransformIdentity;
            _ysSearchBar.showsCancelButton = NO;
            [_ysSearchBar endEditing:YES];
        }];
        
    }
}


@end
