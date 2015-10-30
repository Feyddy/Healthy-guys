//
//  MenuBookCell.h
//  项目三_Healthyguns
//
//  Created by mac on 15/10/24.
//  Copyright (c) 2015年 Janie. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "MenuListModel.h"
#import "ThemeImageView.h"
@interface MenuBookCell : UICollectionViewCell

@property (weak, nonatomic) IBOutlet UIImageView *menuImageView;

@property (weak, nonatomic) IBOutlet UILabel *menuNameLabel;
@property (nonatomic, strong)MenuListModel *model;
@end
