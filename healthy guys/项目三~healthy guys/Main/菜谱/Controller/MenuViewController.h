//
//  MenuViewController.h
//  项目三_Healthyguns
//
//  Created by mac on 15/10/8.
//  Copyright (c) 2015年 Janie. All rights reserved.
//

#import "BaseViewController.h"

@interface MenuViewController : BaseViewController<UIScrollViewDelegate,UITableViewDataSource,UITableViewDelegate>
//@property (weak, nonatomic) IBOutlet UIScrollView *scrollView;
- (IBAction)selectBtn:(UIButton *)sender;

@end
