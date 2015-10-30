//
//  ConsultCell.h
//  项目三-Healthy guys
//
//  Created by Mac on 15/10/8.
//  Copyright (c) 2015年 Feyddy. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "ConsultModel.h"

@interface ConsultCell : UITableViewCell
@property (strong, nonatomic) IBOutlet UILabel *titleName;
@property (strong, nonatomic) IBOutlet UILabel *descriptionLabel;
@property (nonatomic,strong) ConsultModel *consultModel;

@end
