//
//  ViewController.m
//  调用系统铃声Test
//
//  Created by YJ on 16/3/9.
//  Copyright © 2016年 YJ. All rights reserved.
//

#import "ViewController.h"
#import <AudioToolbox/AudioToolbox.h>

@interface ViewController ()
- (IBAction)voiceBtn:(id)sender;


@end

@implementation ViewController
{
    SystemSoundID soundID;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (IBAction)voiceBtn:(id)sender {
    
    [self systemShake];
    [self createSystemSoundWithName:@"alarm" soundType:@"caf"];
}

//调用震动
-(void)systemShake
{
    AudioServicesPlaySystemSound(kSystemSoundID_Vibrate);
}

//调用铃声
-(void)createSystemSoundWithName:(NSString *)soundName soundType:(NSString *)soundType
{
    NSString *path = [NSString stringWithFormat:@"/System/Library/Audio/UISounds/%@.%@",soundName,soundType];
    if (path) {
        AudioServicesCreateSystemSoundID((__bridge CFURLRef)[NSURL fileURLWithPath:path], &soundID);
        AudioServicesPlaySystemSound(soundID);
        
    }
}
@end
