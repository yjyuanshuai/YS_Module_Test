//
//  AudioPlayerVC.m
//  YS_iOS_Other
//
//  Created by YJ on 16/11/23.
//  Copyright © 2016年 YJ. All rights reserved.
//

#import "AudioPlayerVC.h"

@interface AudioPlayerVC ()



@end

@implementation AudioPlayerVC

+ (instancetype)defaultAudioVC
{
    __block AudioPlayerVC * instance = nil;
    
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        instance = [[self alloc] init];
    });
    return instance;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
