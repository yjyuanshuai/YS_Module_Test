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
    
    self.title = @"相机/相册案例";
    [self initUI];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


- (void)initUI
{
#if 0
    if (![self.title isEqualToString:@""] && ![self.title isEqual:nil]) {

        UIView * CustomtitleView = [[UIView alloc] init];
        CustomtitleView.bounds = CGRectMake(0, 0, 200, 44);
        CustomtitleView.center = CGPointMake(self.navigationController.navigationBar.frame.size.width, self.navigationController.navigationBar.frame.size.height);
        CustomtitleView.backgroundColor = [UIColor clearColor];
        self.navigationItem.titleView = CustomtitleView;
        
        
        UILabel * titleLabel = [[UILabel alloc] initWithFrame:CGRectMake(0, 0, CustomtitleView.frame.size.width, CustomtitleView.frame.size.height)];
        titleLabel.text = self.title;
        titleLabel.textAlignment = NSTextAlignmentCenter;
        titleLabel.textColor = [UIColor whiteColor];
        titleLabel.backgroundColor = [UIColor clearColor];
        [CustomtitleView addSubview:titleLabel];
        
    }
#else 
    self.navigationController.navigationBar.titleTextAttributes = @{NSFontAttributeName:[UIFont fontWithName:@"Helvetica" size:16.0f], NSForegroundColorAttributeName:[UIColor whiteColor]};
    
#endif
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
        imagePicker.allowsEditing = YES;
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
//    NSLog(@"------ info : %@", info);
    UIImage * newImage = [info objectForKey:UIImagePickerControllerOriginalImage];
    self.imageShow.image = newImage;
    
    // 存到相册
//    UIImageWriteToSavedPhotosAlbum(newImage, nil, nil, nil);
    
    [picker dismissViewControllerAnimated:YES completion:nil];
}

- (void)imagePickerControllerDidCancel:(UIImagePickerController *)picker
{
    [picker dismissViewControllerAnimated:YES completion:nil];
}

- (void)navigationController:(UINavigationController *)navigationController willShowViewController:(UIViewController *)viewController animated:(BOOL)animated
{
    navigationController.navigationBar.titleTextAttributes = @{NSFontAttributeName:[UIFont fontWithName:@"Helvetica" size:16.0f], NSForegroundColorAttributeName:[UIColor whiteColor]};
}


@end
