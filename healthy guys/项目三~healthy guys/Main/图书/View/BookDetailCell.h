//
//  BookDetailCell.h
//  项目三~healthy guys
//
//  Created by Mac on 15/10/9.
//  Copyright (c) 2015年 Feyddy. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "BookDetailModel.h"

@interface BookDetailCell : UITableViewCell
@property (nonatomic,strong) BookDetailModel *model;
@property (strong, nonatomic) IBOutlet UILabel *bookTitle;

@property (strong, nonatomic) IBOutlet UILabel *bookMessage;
@end
