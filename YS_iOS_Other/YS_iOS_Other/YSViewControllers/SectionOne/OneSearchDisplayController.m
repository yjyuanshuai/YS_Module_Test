//
//  OneSearchDisplayController.m
//  YS_iOS_Other
//
//  Created by YJ on 16/6/16.
//  Copyright © 2016年 YJ. All rights reserved.
//

#import "OneSearchDisplayController.h"

@interface OneSearchDisplayController ()<UISearchBarDelegate, UISearchDisplayDelegate, UITableViewDelegate, UITableViewDataSource>

@property (nonatomic, strong) UISearchBar * ysSearchBar;
@property (nonatomic, strong) UISearchDisplayController * ysSearchDisplayVC;

@property (nonatomic, strong) UISearchBar * ysNoNavSearchBar;
@property (nonatomic, strong) UISearchDisplayController * ysNoNavSearchDisplayVC;

@end

@implementation OneSearchDisplayController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    
    self.view.backgroundColor = [UIColor whiteColor];
    self.navigationController.navigationBar.translucent = NO;
    
    _ysSearchBar = [[UISearchBar alloc] initWithFrame:CGRectZero];
    _ysSearchBar.delegate = self;
    _ysSearchBar.showsCancelButton = NO;
    _ysSearchBar.placeholder = @"导航栏搜索";
    [_ysSearchBar sizeToFit];
    self.navigationItem.titleView = _ysSearchBar;
    
    _ysSearchDisplayVC = [[UISearchDisplayController alloc] initWithSearchBar:_ysSearchBar contentsController:self];
    _ysSearchDisplayVC.delegate = self;
    _ysSearchDisplayVC.searchResultsDataSource = self;
    _ysSearchDisplayVC.searchResultsDelegate = self;
    _ysSearchDisplayVC.searchResultsTableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    _ysSearchDisplayVC.displaysSearchBarInNavigationBar = YES;
    
    
    _ysNoNavSearchBar = [[UISearchBar alloc] init];
    _ysNoNavSearchBar.delegate = self;
    _ysNoNavSearchBar.showsCancelButton = YES;
    _ysNoNavSearchBar.placeholder = @"一般搜索";
    [_ysNoNavSearchBar sizeToFit];
    [self.view addSubview:_ysNoNavSearchBar];
    
    _ysNoNavSearchDisplayVC = [[UISearchDisplayController alloc] initWithSearchBar:_ysNoNavSearchBar contentsController:self];
    _ysNoNavSearchDisplayVC.delegate = self;
    _ysNoNavSearchDisplayVC.searchResultsDataSource = self;
    _ysNoNavSearchDisplayVC.searchResultsDataSource = self;
    _ysNoNavSearchDisplayVC.searchResultsTableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    
    
    // 通知
    [[NSNotificationCenter defaultCenter] addObserver:self
                                             selector:@selector(KeyBoardWillShow)
                                                 name:UIKeyboardWillShowNotification
                                               object:nil];
    [[NSNotificationCenter defaultCenter] addObserver:self
                                             selector:@selector(KeyBoardWillHide)
                                                 name:UIKeyboardWillHideNotification
                                               object:nil];
    
    
    //
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - 
- (void)KeyBoardWillShow
{
    if (_ysSearchBar.isFirstResponder) {
        
        // 导航栏
        
        
    } else if (_ysNoNavSearchBar.isFirstResponder) {
    
        // 非导航栏
        
        
    }
}

- (void)KeyBoardWillHide
{

}

#pragma mark -
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return 2;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    NSString * cell_id = @"cell_id";
    UITableViewCell * cell = [tableView dequeueReusableCellWithIdentifier:cell_id];
    if (cell == nil) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cell_id];
    }
    cell.textLabel.text = @"测试测试测试测试";
    return cell;
}

#pragma mark -

#pragma mark -
- (void)searchDisplayControllerWillBeginSearch:(UISearchDisplayController *)controller {
    

    
    
}

- (void)resetSearchDisplayView:(id)searchDisplayController custemView:(UIView *)view
{
    if ([searchDisplayController isKindOfClass:[UISearchDisplayController class]]) {
        
        UISearchDisplayController * ysSearchDisplayView = (UISearchDisplayController *)searchDisplayController;
        
        UITapGestureRecognizer * tapGesure = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(hideKeyWindow:)];
        
        ysSearchDisplayView.searchResultsTableView.superview.backgroundColor = [UIColor yellowColor];
        
        UIView * disViewSuperView = nil;
        
        if (ysSearchDisplayView.displaysSearchBarInNavigationBar) {
            
            disViewSuperView = ysSearchDisplayView.searchResultsTableView.superview.superview;
            
            
            [disViewSuperView addGestureRecognizer:tapGesure];
            
            for (UIView * subView in disViewSuperView.subviews) {
                for (UIView * subsubView in subView.subviews) {
                    if ([subsubView isKindOfClass:NSClassFromString(@"_UISearchDisplayControllerDimmingView")]) {
                        NSLog(@"+++++++++++++++ ");
                        subView.frame = CGRectZero;
                        subView.hidden = YES;
                        
                        if (![view isDescendantOfView:disViewSuperView]) {
                            [disViewSuperView addSubview:view];
                        }
                    }
                    
                }
            }
            
        } else {
            
            disViewSuperView = ysSearchDisplayView.searchResultsTableView.superview;
            [disViewSuperView addGestureRecognizer:tapGesure];
            
            for (UIView * subView in disViewSuperView.subviews) {
                
                if ([subView isKindOfClass:NSClassFromString(@"_UISearchDisplayControllerDimmingView")]) {
                    
                    NSLog(@"--------------- ");
                    subView.frame = CGRectZero;
                    subView.hidden = YES;
                    
                    if (![view isDescendantOfView:disViewSuperView]) {
                        [disViewSuperView addSubview:view];
                    }
                }
            }
            
        }
        
    }
}

- (UIView *)ysCustemView
{
    UIView * tempView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, self.view.frame.size.width, self.view.frame.size.height)];
    
    UIButton * btn = [UIButton buttonWithType:UIButtonTypeCustom];
    btn.frame = CGRectMake(100, 100, 100, 100);
    [btn addTarget:self action:@selector(clickBtn) forControlEvents:UIControlEventTouchUpInside];
    [btn setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
    btn.layer.borderColor = [UIColor blackColor].CGColor;
    btn.layer.borderWidth = 1.0;
    [btn setBackgroundImage:[UIImage imageNamed:@"btn1"] forState:UIControlStateNormal];
    [tempView addSubview:btn];
    
    return tempView;
}

- (void)clickBtn
{
    NSLog(@"+++++++++++++++++++++++");
}

- (void)hideKeyWindow:(UITapGestureRecognizer *)tapGesure
{
    [self.view endEditing:YES];
    [self.navigationController.navigationBar endEditing:YES];
}

@end
