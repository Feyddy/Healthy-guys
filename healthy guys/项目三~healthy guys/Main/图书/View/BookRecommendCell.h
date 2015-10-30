//
//  BookRecommendCell.h
//  项目三~healthy guys
//
//  Created by Mac on 15/10/26.
//  Copyright (c) 2015年 Feyddy. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "BookRecommendModel.h"

@interface BookRecommendCell : UITableViewCell
@property (strong, nonatomic) IBOutlet UIImageView *bookRecommendImageView;
@property (strong, nonatomic) IBOutlet UILabel *bookRecommendName;
@property (strong, nonatomic) IBOutlet UILabel *bookRecommendAuthor;
@property (strong, nonatomic) IBOutlet UILabel *bookRecommendTime;
@property (strong, nonatomic) IBOutlet UILabel *bookRecommendSummary;


@property (nonatomic,strong) BookRecommendModel *model;
@end
