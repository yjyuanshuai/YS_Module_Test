//
//  ViewController.m
//  StoryboardTest
//
//  Created by YJ on 15/12/23.
//  Copyright © 2015年 YJ. All rights reserved.
//

#import "ViewController.h"

static NSString * cell_id = @"CELLID";

@interface ViewController ()<UITableViewDelegate, UITableViewDataSource>
@property (weak, nonatomic) IBOutlet UITableView *tableView;

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
    
    
//    [_tableView registerClass:[UITableViewCell class] forCellReuseIdentifier:cell_id];
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}



#pragma mark - UITableViewDelegate && UITableViewDataSource

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return 10;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    
    UITableViewCell * cell;
    if (indexPath.row %2 == 0) {
        cell = [tableView dequeueReusableCellWithIdentifier:[NSString stringWithFormat:@"%@"] forIndexPath:<#(nonnull NSIndexPath *)#>];
    }else {
    
    }
    
    
    if (!cell) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cell_id];
    }
    
    
    return cell;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 60;
}

- (CGFloat)tableView:(UITableView *)tableView estimatedHeightForHeaderInSection:(NSInteger)section
{
    return 80;
}

@end
