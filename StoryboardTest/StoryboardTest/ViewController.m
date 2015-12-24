//
//  ViewController.m
//  StoryboardTest
//
//  Created by YJ on 15/12/23.
//  Copyright © 2015年 YJ. All rights reserved.
//

#import "ViewController.h"
#import "OneTableViewCell.h"
#import "TWOTableViewCell.h"

@interface ViewController ()<UITableViewDelegate, UITableViewDataSource>
@property (weak, nonatomic) IBOutlet UITableView *tableView;

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
    
    

    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}



#pragma mark - UITableViewDelegate && UITableViewDataSource

//- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
//{
//    return 5;
//}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return 10;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    
    if (indexPath.row % 3 == 1) {
        static NSString * oneCell = @"CELLIDTWO";
        TWOTableViewCell * cell = [tableView dequeueReusableCellWithIdentifier:oneCell];
        cell.textView.text = [NSString stringWithFormat:@"这是第%d个 cell 详情", (int)indexPath.row / 2 + 1];
        
        return cell;
    }else if(indexPath.row % 3 == 0){
        static NSString * twoCell = @"CELLIDONE";
        OneTableViewCell * cell = [tableView dequeueReusableCellWithIdentifier:twoCell];
        cell.name.text = [NSString stringWithFormat:@"name - %d", (int)indexPath.row / 2 + 1];
        cell.other.text = [NSString stringWithFormat:@"other information"];
        return cell;
    }else {
        UITableViewCell * cell = [tableView dequeueReusableCellWithIdentifier:@"CELLIDTHREE"];
        return cell;
    }
    
    
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (indexPath.row % 3 == 0) {
        return 60;
    }else if(indexPath.row % 3 == 1){
        return 100;
    }else {
        return 200;
    }
}

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section
{
    return 0.01;
}
@end
