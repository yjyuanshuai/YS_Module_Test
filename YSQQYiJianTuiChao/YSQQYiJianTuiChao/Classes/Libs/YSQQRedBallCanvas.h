//
//  YSQQRedBallCanvas.h
//  YSQQYiJianTuiChao
//
//  Created by YJ on 16/2/3.
//  Copyright © 2016年 YJ. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "YSCircle.h"

@interface YSQQRedBallCanvas : UIView

@property (nonatomic, strong) YSCircle * centerCircle;      //中心圆
@property (nonatomic, strong) YSCircle * touchCircle;       //拖拽的



@end
