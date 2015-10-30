//
//  MenuBookCell.m
//  项目三_Healthyguns
//
//  Created by mac on 15/10/24.
//  Copyright (c) 2015年 Janie. All rights reserved.
//

#import "MenuBookCell.h"
#import "MenuListModel.h"
@implementation MenuBookCell
-  (void)setModel:(MenuListModel *)model {
    if (_model != model) {
        _model = model;
        _menuNameLabel.text = model.name;
//        _menuImageView.imageName = model.imageName;

    }
}

@end
