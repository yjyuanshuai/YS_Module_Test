//
//  SevenBaiduViewController.m
//  YS_iOS_Other
//
//  Created by YJ on 16/6/17.
//  Copyright © 2016年 YJ. All rights reserved.
//

#import "SevenBaiduViewController.h"
#import <BaiduMapAPI_Map/BMKMapComponent.h>

@interface SevenBaiduViewController () <BMKMapViewDelegate>

@property (nonatomic, strong) BMKMapView * mapView;

@end

@implementation SevenBaiduViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    self.title = @"百度地图";
    
    _mapView = [[BMKMapView alloc] initWithFrame:CGRectMake(0, 64, kScreenWidth, kScreenHeight - 64)];
    _mapView.mapType = BMKMapTypeNone;
    self.view = _mapView;
    
    
    UIBarButtonItem * rightBarBtn = [[UIBarButtonItem alloc] initWithTitle:@"操作" style:UIBarButtonItemStylePlain target:self action:@selector(MoreDoAction)];
    self.navigationItem.rightBarButtonItem = rightBarBtn;
}

- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    
    [_mapView viewWillAppear];
    _mapView.delegate = self;  // 此处记得不用的时候需要置nil，否则影响内存的释放
}

- (void)viewWillDisappear:(BOOL)animated
{
    [super viewWillDisappear:animated];
    
    [_mapView viewWillDisappear];
    _mapView.delegate = nil; // 不用时，置nil
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - BMKMapViewDelegate


#pragma mark - 
- (void)MoreDoAction
{
    
}

@end
