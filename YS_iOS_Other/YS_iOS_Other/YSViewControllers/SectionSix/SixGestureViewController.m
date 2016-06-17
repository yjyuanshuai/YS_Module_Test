//
//  SixGestureViewController.m
//  YS_iOS_Other
//
//  Created by YJ on 16/6/17.
//  Copyright © 2016年 YJ. All rights reserved.
//

#import "SixGestureViewController.h"
#import "YSCustemGesureRecognizer.h"

@interface SixGestureViewController ()

@property (nonatomic, strong) UITapGestureRecognizer *          ysTapGesure;            // 点按
@property (nonatomic, strong) UILongPressGestureRecognizer *    ysLongGesure;           // 长按
@property (nonatomic, strong) UISwipeGestureRecognizer *        ysSwipeGesture;         // 轻扫
@property (nonatomic, strong) UIPanGestureRecognizer *          ysPanGesture;           // 拖动
@property (nonatomic, strong) UIPinchGestureRecognizer *        ysPinchGesture;         // 捏合
@property (nonatomic, strong) UIRotationGestureRecognizer *     ysRotationGesture;      // 旋转

@property (nonatomic, strong) YSCustemGesureRecognizer *        ysCustemGesure;         // 自定义手势

@end

@implementation SixGestureViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    self.title = @"手势";
    
    
    _ysTapGesure = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(tapGesureAction)];
    _ysTapGesure.numberOfTapsRequired = 1;      // 点按的次数
    _ysTapGesure.numberOfTouchesRequired = 1;   // 手指数
    
    
    _ysLongGesure = [[UILongPressGestureRecognizer alloc] initWithTarget:self action:@selector(longGesureAction)];
    _ysLongGesure.numberOfTouchesRequired = 1;
    _ysLongGesure.numberOfTapsRequired = 0;
    _ysLongGesure.minimumPressDuration = 0.5;   // 最小的长按时间
    _ysLongGesure.allowableMovement = 10;       // 最大移动距离
    
    
    _ysSwipeGesture = [[UISwipeGestureRecognizer alloc] initWithTarget:self action:@selector(swipeGesureAction)];
    _ysSwipeGesture.numberOfTouchesRequired = 1;
    _ysSwipeGesture.direction = UISwipeGestureRecognizerDirectionLeft;  // 轻扫的方向
    
    
    _ysPanGesture = [[UIPanGestureRecognizer alloc] initWithTarget:self action:@selector(panGesureAction)];
    _ysPanGesture.minimumNumberOfTouches = 1;
    _ysPanGesture.maximumNumberOfTouches = 1;
    
    
    _ysPinchGesture = [[UIPinchGestureRecognizer alloc] initWithTarget:self action:@selector(pinGesureAction)];
    _ysPinchGesture.scale = 10;
    
    
    _ysRotationGesture = [[UIRotationGestureRecognizer alloc] initWithTarget:self action:@selector(rotationGesureAction)];
    _ysRotationGesture.rotation = M_PI/2;
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}



@end
