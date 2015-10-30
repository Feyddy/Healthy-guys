//
//  BookListCell.h
//  项目三~healthy guys
//
//  Created by Mac on 15/10/9.
//  Copyright (c) 2015年 Feyddy. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "BookListModel.h"

@interface BookListCell : UITableViewCell
@property (strong, nonatomic) IBOutlet UIImageView *bookImageView;
@property (strong, nonatomic) IBOutlet UILabel *bookNameLabel;
@property (strong, nonatomic) IBOutlet UILabel *bookAuthorLabel;
@property (strong, nonatomic) IBOutlet UILabel *bookSummaryLabel;
@property (strong, nonatomic) IBOutlet UILabel *timeLabel;

@property (nonatomic,strong) BookListModel *bookListModel;

@end
