//
//  ListDetailViewController.h
//  项目三~healthy guys
//
//  Created by Mac on 15/10/23.
//  Copyright (c) 2015年 Feyddy. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "BaseViewController.h"
#import "ConsultListModel.h"

@interface ListDetailViewController : BaseViewController

@property (nonatomic,strong) ConsultListModel *model;
@property (nonatomic,assign) NSInteger indexRow;
@property (nonatomic,strong) NSMutableArray *array;

@end
