//
//  SecordViewController.m
//  AudioRecordAndPlayerText
//
//  Created by YJ on 16/5/27.
//  Copyright © 2016年 YJ. All rights reserved.
//

#import "SecordViewController.h"

@interface SecordViewController ()<UITableViewDelegate, UITableViewDataSource>

@property (weak, nonatomic) IBOutlet UIProgressView *audioPower;
- (IBAction)startOrPausePlayBtn:(UIButton *)sender;
- (IBAction)startOrPauseRecordBtn:(UIButton *)sender;
- (IBAction)finishBtn:(UIButton *)sender;
@property (weak, nonatomic) IBOutlet UITableView *audioListTableView;

@end

@implementation SecordViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - 
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return nil;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return 0;
}

#pragma mark -

- (IBAction)startOrPausePlayBtn:(UIButton *)sender {
}

- (IBAction)startOrPauseRecordBtn:(UIButton *)sender {
}

- (IBAction)finishBtn:(UIButton *)sender {
}
@end
