//
//  OneTableViewCell.h
//  StoryboardTest
//
//  Created by YJ on 15/12/24.
//  Copyright © 2015年 YJ. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface OneTableViewCell : UITableViewCell
@property (weak, nonatomic) IBOutlet UIImageView *headerImage;
@property (weak, nonatomic) IBOutlet UILabel *name;
@property (weak, nonatomic) IBOutlet UILabel *other;

@end
