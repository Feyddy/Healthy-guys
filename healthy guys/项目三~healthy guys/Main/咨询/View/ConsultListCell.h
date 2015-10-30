//
//  ConsultListCell.h
//  项目三-Healthy guys
//
//  Created by Mac on 15/10/8.
//  Copyright (c) 2015年 Feyddy. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "ConsultListModel.h"

@interface ConsultListCell : UITableViewCell

@property (strong, nonatomic) IBOutlet UILabel *consultListTitleLabel;

@property (strong, nonatomic) IBOutlet UILabel *consultListKeywordsLabel;//事时间
@property (strong, nonatomic) IBOutlet UILabel *consultListDescriptionLabel;
@property (strong, nonatomic) IBOutlet UIImageView *consultListImageView;


@property (nonatomic,strong) ConsultListModel *consultListModel;
@end
