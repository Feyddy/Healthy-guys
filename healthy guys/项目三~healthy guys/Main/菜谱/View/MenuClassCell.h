//
//  MenuClassCell.h
//  项目三_Healthyguns
//
//  Created by mac on 15/10/20.
//  Copyright (c) 2015年 Janie. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "ThemeImageView.h"
@interface MenuClassCell : UITableViewCell
@property (weak, nonatomic) IBOutlet UILabel *titleLabel;
@property (weak, nonatomic) IBOutlet UILabel *descriptionLabel;
@property (weak, nonatomic) IBOutlet UIImageView *classImageName;
@end
