//
//  RootViewController.m
//  CameraAndLibraryTest
//
//  Created by YJ on 16/1/5.
//  Copyright © 2016年 YJ. All rights reserved.
//

#import "RootViewController.h"
#import <AVFoundation/AVFoundation.h>

@interface RootViewController ()<UIImagePickerControllerDelegate, UINavigationControllerDelegate>
@property (weak, nonatomic) IBOutlet UIImageView *imageShow;
- (IBAction)takeCameraBtn:(id)sender;

- (IBAction)takePhotoLibraryBtn:(id)sender;

@end

@implementation RootViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (IBAction)takeCameraBtn:(id)sender {
    
    [self takeCamera];
    
}

- (IBAction)takePhotoLibraryBtn:(id)sender {
    
    [self takePhotoLibrary];
}

- (void)takeCamera
{
    //
    if (![UIImagePickerController isSourceTypeAvailable:UIImagePickerControllerSourceTypeCamera]) {
        
        [self showAlertViewWithTitle:nil message:@"不支持相机功能"];
        return;
    }
    
    NSString * mediaType = AVMediaTypeVideo;
    AVAuthorizationStatus status = [AVCaptureDevice authorizationStatusForMediaType:mediaType];
    if (status == AVAuthorizationStatusNotDetermined) {
        
        [self showAlertViewWithTitle:nil message:@"未进行授权选择"];
        
    }else if (status == AVAuthorizationStatusRestricted){
    
        [self showAlertViewWithTitle:nil message:@"未授权"];
        
    }else if (status == AVAuthorizationStatusDenied){
    
        [self showAlertViewWithTitle:nil message:@"用户拒绝"];
        
    }else if (status == AVAuthorizationStatusAuthorized){
    
        UIImagePickerController * imagePicker = [[UIImagePickerController alloc] init];
        imagePicker.delegate = self;
        imagePicker.sourceType = UIImagePickerControllerSourceTypeCamera;
        
        [self presentViewController:imagePicker animated:YES completion:nil];
    }
    
}

- (void)takePhotoLibrary
{
    if (![UIImagePickerController isSourceTypeAvailable:UIImagePickerControllerSourceTypePhotoLibrary]) {
        
        [self showAlertViewWithTitle:nil message:@"相册不可用"];
        return;
    }
    
    UIImagePickerController * imagePicker = [[UIImagePickerController alloc] init];
    imagePicker.delegate = self;
    imagePicker.sourceType = UIImagePickerControllerSourceTypePhotoLibrary;
    [self presentViewController:imagePicker animated:YES completion:nil];
}

- (void)showAlertViewWithTitle:(NSString *)title message:(NSString *)message
{
    UIAlertController * alertCon = [UIAlertController alertControllerWithTitle:title message:message preferredStyle:UIAlertControllerStyleAlert];
    
    UIAlertAction * cancle = [UIAlertAction actionWithTitle:@"取消" style:UIAlertActionStyleCancel handler:^(UIAlertAction * _Nonnull action) {
        
    }];
    [alertCon addAction:cancle];
    
    UIAlertAction * sure = [UIAlertAction actionWithTitle:@"确认" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
        
    }];
    [alertCon addAction:sure];

    [self presentViewController:alertCon animated:YES completion:nil];
}

#pragma mark - 
- (void)imagePickerController:(UIImagePickerController *)picker didFinishPickingMediaWithInfo:(NSDictionary<NSString *,id> *)info
{
    NSLog(@"------ info : %@", info);
    UIImage * newImage = [info objectForKey:UIImagePickerControllerOriginalImage];
    self.imageShow.image = newImage;
    [picker dismissViewControllerAnimated:YES completion:nil];
}

- (void)imagePickerControllerDidCancel:(UIImagePickerController *)picker
{
    [picker dismissViewControllerAnimated:YES completion:nil];
}


@end
