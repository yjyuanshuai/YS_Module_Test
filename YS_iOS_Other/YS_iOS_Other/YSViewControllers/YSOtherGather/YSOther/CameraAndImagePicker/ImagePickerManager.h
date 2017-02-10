//
//  ImagePickerManager.h
//  YS_iOS_Other
//
//  Created by YJ on 17/2/10.
//  Copyright © 2017年 YJ. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <QBImagePickerController/QBImagePickerController.h>

typedef NS_ENUM(NSInteger, PickType){
    PickTypeSystemImageLibrary,
    PickTypeSystemCamera,
    PickTypeQBImagePickerImageLibrary,
    PickTypeQBImagePickerCamera
};

//typedef void(^MediaBackBlock)(id mediaSet, UIViewController * viewControl);


@interface ImagePickerManager : NSObject

@property (nonatomic, strong) UIImagePickerController * imagePickerCon;
@property (nonatomic, strong) QBImagePickerController * QBImagePC;

- (instancetype)initWithPickerType:(PickType)type
                listViewController:(UIViewController *)viewController;

@end
