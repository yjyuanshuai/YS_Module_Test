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

@interface ViewController ()<UITableViewDelegate, UITableViewDataSource, UIImagePickerControllerDelegate, UINavigationControllerDelegate, ThreeCellDelegate>
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
- (void)updateImageWithIndex:(NSInteger)index
{
    UIAlertController * alertCon = [UIAlertController alertControllerWithTitle:nil message:nil preferredStyle:UIAlertControllerStyleActionSheet];
    UIAlertAction * cameraAlert = [UIAlertAction actionWithTitle:@"相机" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
        // 调用相机
        [self takeCamera];
        
    }];
//    cameraAlert.enabled= YES;
    [alertCon addAction:cameraAlert];
    
    UIAlertAction * libraryAlert = [UIAlertAction actionWithTitle:@"相册" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
        // 调用相册
        
    }];
    [alertCon addAction:libraryAlert];
    
    UIAlertAction * cancel = [UIAlertAction actionWithTitle:@"取消" style:UIAlertActionStyleCancel handler:^(UIAlertAction * _Nonnull action) {
        // 取消
    }];
    [alertCon addAction:cancel];
    
    [self presentViewController:alertCon animated:YES completion:nil];
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
    if ([UIImagePickerController isSourceTypeAvailable:UIImagePickerControllerSourceTypeCamera]) {
        
        // 相机
        UIImagePickerController * cameraPicker = [[UIImagePickerController alloc] init];
        cameraPicker.delegate = self;
        cameraPicker.sourceType = UIImagePickerControllerSourceTypeCamera;
//        cameraPicker.mediaTypes = @[(NSString *)kUTTypeImage];
//        cameraPicker.cameraDevice
        [self presentViewController:cameraPicker animated:YES completion:nil];
    }
    
    
    
    
    /**
     *  是否支持前置 / 后置摄像头
     *
     *  @param UIImagePickerControllerCameraDevice 
                    UIImagePickerControllerCameraDeviceRear,
                    UIImagePickerControllerCameraDeviceFront
     *
     *  @return
     */
//    [UIImagePickerController isCameraDeviceAvailable:UIImagePickerControllerCameraDeviceRear];
    
    
    
    /**
     *  是否支持闪光灯
     *
     *  @param UIImagePickerControllerCameraDevice 
                    UIImagePickerControllerCameraDeviceRear,
                    UIImagePickerControllerCameraDeviceFront
     *
     *  @return
     */
//    [UIImagePickerController isFlashAvailableForCameraDevice:UIImagePickerControllerCameraDeviceRear];
    
    
    
    /**
     *  返回拍摄类型
     *  UIImagePickerControllerCameraCaptureMode
                UIImagePickerControllerCameraCaptureModePhoto,
                UIImagePickerControllerCameraCaptureModeVideo
     */
//    [UIImagePickerController availableCaptureModesForCameraDevice:UIImagePickerControllerCameraDeviceRear];
    
    
    
    
}

#pragma mark - UIImagePickerControllerDelegate & UINavigationControllerDelegate
#pragma mark -
- (void)imagePickerControllerDidCancel:(UIImagePickerController *)picker
{
    [picker dismissViewControllerAnimated:YES completion:nil];
}

- (void)imagePickerController:(UIImagePickerController *)picker didFinishPickingMediaWithInfo:(NSDictionary<NSString *,id> *)info
{
    // 取到照片
    NSString * type = [info objectForKey:UIImagePickerControllerMediaType];
    
    
}

#pragma mark -
- (void)navigationController:(UINavigationController *)navigationController willShowViewController:(UIViewController *)viewController animated:(BOOL)animated
{
    
}




@end
