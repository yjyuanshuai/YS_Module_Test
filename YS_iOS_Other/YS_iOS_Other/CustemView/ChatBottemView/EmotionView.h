//
//  EmotionView.h
//  YS_iOS_Other
//
//  Created by YJ on 16/12/16.
//  Copyright © 2016年 YJ. All rights reserved.
//

/**
 
 30 * 30
 3*7
 
 */

#import <UIKit/UIKit.h>

typedef void(^SelectEmoBlock) (NSString * emoStr);

@interface EmotionView : UIView <UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout>

@property (nonatomic, strong) NSMutableArray * emotionsArr;
@property (nonatomic, strong) SelectEmoBlock returnSelectBlock;

@property (nonatomic, strong) UICollectionView * emotionCollectionView;
//@property (nonatomic, strong) UIPageControl * pageControl;

@property (nonatomic, strong) UIView * selectEmotionView;
@property (nonatomic, strong) UIButton * sendBtn;

+ (instancetype)shareEmotionView;
- (CGFloat)getEmotionViewHeight;

@end
