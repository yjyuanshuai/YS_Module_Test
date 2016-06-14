//
//  OneHorizontalTableViewController.m
//  YS_iOS_Other
//
//  Created by YJ on 16/6/14.
//  Copyright © 2016年 YJ. All rights reserved.
//

#import "OneHorizontalTableViewController.h"
#import "OneHorizontalTableViewCell.h"
#import "CollectionTestModel.h"

static NSString * cell_id = @"one_horizontal_tableView_cell_id";

@interface OneHorizontalTableViewController ()<UITableViewDelegate, UITableViewDataSource>

@property (nonatomic, strong) UITableView * horizontalTableView;

@end

@implementation OneHorizontalTableViewController
{
    NSMutableArray * _modelsArr;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    
    self.title = @"横向Tableview";
//    self.view.backgroundColor = [UIColor whiteColor];
    
    
    _modelsArr = [NSMutableArray arrayWithArray:@[[self getCollectionModle:@"1" title:@"主题" desc:@"详情"],
                                                  [self getCollectionModle:@"2" title:@"主题" desc:@"详情"],
                                                  [self getCollectionModle:@"3" title:@"主题" desc:@"详情"],
                                                  [self getCollectionModle:@"4" title:@"主题" desc:@"详情"],
                                                  [self getCollectionModle:@"5" title:@"主题" desc:@"详情"],
                                                  [self getCollectionModle:@"6" title:@"主题" desc:@"详情"],
                                                  [self getCollectionModle:@"7" title:@"主题" desc:@"详情"],
                                                  [self getCollectionModle:@"8" title:@"主题" desc:@"详情"],
                                                  [self getCollectionModle:@"9" title:@"主题" desc:@"详情"]]];
    
    
    
    
    _horizontalTableView = [[UITableView alloc] initWithFrame:CGRectMake(0, 64, 130, [[UIScreen mainScreen] bounds].size.width) style:UITableViewStylePlain];
    _horizontalTableView.center = CGPointMake([[UIScreen mainScreen] bounds].size.width/2, 64+130/2);
    _horizontalTableView.backgroundColor = [UIColor yellowColor];
    _horizontalTableView.delegate = self;
    _horizontalTableView.dataSource = self;
    _horizontalTableView.showsHorizontalScrollIndicator = NO;
    _horizontalTableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    [self.view addSubview:_horizontalTableView];
    [_horizontalTableView registerClass:[OneHorizontalTableViewCell class] forCellReuseIdentifier:cell_id];
    
    // 转向
    _horizontalTableView.transform = CGAffineTransformMakeRotation(-M_PI/2);
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - 
- (CollectionTestModel *)getCollectionModle:(NSString *)imageName title:(NSString *)title desc:(NSString *)desc
{
    CollectionTestModel * model = [[CollectionTestModel alloc] initWithImageName:imageName title:title desc:desc];
    return model;
}


#pragma mark - 
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return [_modelsArr count];
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    OneHorizontalTableViewCell * cell = [tableView dequeueReusableCellWithIdentifier:cell_id];
    
    CollectionTestModel * model = [_modelsArr objectAtIndex:indexPath.row];
    
    [cell setCellContent:model];
    
    return cell;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 100;
}

@end
