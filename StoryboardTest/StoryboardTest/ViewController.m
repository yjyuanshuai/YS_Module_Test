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
#import "ThreeTableViewCell.h"

#import <AVFoundation/AVFoundation.h>


@interface ViewController ()<UITableViewDelegate, UITableViewDataSource, UIImagePickerControllerDelegate, UINavigationControllerDelegate, ThreeCellDelegate>
@property (weak, nonatomic) IBOutlet UITableView *tableView;

@end

@implementation ViewController
{
    UIImageView * _imageView;
}
- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}



#pragma mark - UITableViewDelegate && UITableViewDataSource

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return 3;
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
        ThreeTableViewCell * cell = [tableView dequeueReusableCellWithIdentifier:@"CELLIDTHREE"];
        cell.delegate = self;
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

#pragma mark - ThreeCellDelegate
- (void)updateImageWithIndex:(UIImageView *)indexImageView
{
    _imageView = indexImageView;
    
    UIAlertController * alertCon = [UIAlertController alertControllerWithTitle:nil message:nil preferredStyle:UIAlertControllerStyleActionSheet];
    UIAlertAction * cameraAlert = [UIAlertAction actionWithTitle:@"相机" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
        // 调用相机
        [self takeCamera];
        
    }];
    [alertCon addAction:cameraAlert];
    
    UIAlertAction * libraryAlert = [UIAlertAction actionWithTitle:@"相册" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
        // 调用相册
        [self takeLabrary];
    }];
    [alertCon addAction:libraryAlert];
    
    UIAlertAction * cancel = [UIAlertAction actionWithTitle:@"取消" style:UIAlertActionStyleCancel handler:^(UIAlertAction * _Nonnull action) {
        // 取消
    }];
    [alertCon addAction:cancel];
    
    [self presentViewController:alertCon animated:YES completion:nil];
}

- (void)displayImageWithIndex:(NSInteger)index
{
    // 显示选中照片
}


#pragma mark -

- (void)takeCamera
{
    NSLog(@"--------- take camera");
    /**
     *
     *  @param UIImagePickerControllerSourceType
                    UIImagePickerControllerSourceTypePhotoLibrary,          // 相册
                    UIImagePickerControllerSourceTypeCamera,                // 相机
                    UIImagePickerControllerSourceTypeSavedPhotosAlbum
     *  @return
     */
    if (![UIImagePickerController isSourceTypeAvailable:UIImagePickerControllerSourceTypeCamera]) {
        
        // 设备不支持相机
        UIAlertController * unSubort = [UIAlertController alertControllerWithTitle:nil message:@"当前设备不支持相机" preferredStyle:UIAlertControllerStyleAlert];
        UIAlertAction * sure = [UIAlertAction actionWithTitle:@"确定" style:UIAlertActionStyleDefault handler:nil];
        [unSubort addAction:sure];
        
        [self presentViewController:unSubort animated:YES completion:nil];
        
    }else {
        
        // 获取应用名称
        NSString * appName = [[[NSBundle mainBundle] infoDictionary] objectForKey:@"CFBundleExecutable"];

        // 判断相机状态
        NSString * mediaType = AVMediaTypeVideo;
        AVAuthorizationStatus authStatus = [AVCaptureDevice authorizationStatusForMediaType:mediaType];
        if (authStatus == AVAuthorizationStatusRestricted || authStatus == AVAuthorizationStatusDenied) {
            
            // AVAuthorizationStatusDenied      用户拒绝App使用
            // AVAuthorizationStatusRestricted  未授权，且用户无法更新，如家长监控情况下
            
            UIAlertController * unUse = [UIAlertController alertControllerWithTitle:nil message:[NSString stringWithFormat:@"相机被禁用，请在隐私设置中，为%@开启相机", appName] preferredStyle:UIAlertControllerStyleAlert];
            UIAlertAction * sure = [UIAlertAction actionWithTitle:@"确认" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
            }];
            [unUse addAction:sure];
            
            [self presentViewController:unUse animated:YES completion:nil];
            
        }else if (authStatus == AVAuthorizationStatusNotDetermined){
        
            // 未进行授权选择
            
        
        }else if (authStatus == AVAuthorizationStatusAuthorized){
            
            // 授权成功，跳转相机界面
            UIImagePickerController * cameraPicker = [[UIImagePickerController alloc] init];
            cameraPicker.delegate = self;
            cameraPicker.sourceType = UIImagePickerControllerSourceTypeCamera;
            [self presentViewController:cameraPicker animated:YES completion:nil];
            
        }
    
    }
    
}

- (void)takeLabrary
{
    if ([UIImagePickerController isSourceTypeAvailable:UIImagePickerControllerSourceTypePhotoLibrary]) {
        
        UIImagePickerController * libraryPicker = [[UIImagePickerController alloc] init];
        libraryPicker.sourceType = UIImagePickerControllerSourceTypePhotoLibrary;
        libraryPicker.delegate = self;
        [self presentViewController:libraryPicker animated:YES completion:nil];
    }
}

#pragma mark - UIImagePickerControllerDelegate & UINavigationControllerDelegate
#pragma mark -
- (void)imagePickerControllerDidCancel:(UIImagePickerController *)picker
{
    [picker dismissViewControllerAnimated:YES completion:nil];
}

- (void)imagePickerController:(UIImagePickerController *)picker didFinishPickingMediaWithInfo:(NSDictionary<NSString *,id> *)info
{
    if (picker.sourceType == UIImagePickerControllerSourceTypeCamera) {
        
    }else if (picker.sourceType == UIImagePickerControllerSourceTypePhotoLibrary) {
        
    }
    
    // 取到照片
    UIImage * obtainImage = [info objectForKey:UIImagePickerControllerOriginalImage];
    UIImageWriteToSavedPhotosAlbum(obtainImage, self, nil, nil);      // 存到相册
    
    _imageView.image = obtainImage;
    [_tableView reloadData];
    [self dismissViewControllerAnimated:YES completion:nil];
}

#pragma mark -
- (void)navigationController:(UINavigationController *)navigationController willShowViewController:(UIViewController *)viewController animated:(BOOL)animated
{
    
}




@end
