//
//  FileOrCodeViewController.m
//  YS_iOS_Other
//
//  Created by YJ on 16/8/19.
//  Copyright © 2016年 YJ. All rights reserved.
//

#import "FileOrCodeViewController.h"

@interface FileOrCodeViewController ()

@property (nonatomic, strong) Class viewClass;

@end

@implementation FileOrCodeViewController

- (instancetype)initWithTitle:(NSString *)title viewClass:(Class)viewClass
{
    if (self = [super init]) {
        self.title = title;
        _viewClass = viewClass;
    }
    return self;
}

- (void)loadView
{
    self.view = [_viewClass new];
    self.view.backgroundColor = [UIColor whiteColor];
}

#ifdef __IPHONE_7_0
- (UIRectEdge)edgesForExtendedLayout {
    return UIRectEdgeNone;
}
#endif

@end
