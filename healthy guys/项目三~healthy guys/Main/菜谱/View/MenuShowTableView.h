//
//  MenuShowTableView.h
//  Healthy Guys
//
//  Created by CandyDear on 15/10/15.
//  Copyright (c) 2015年 mac04. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface MenuShowTableView : UITableView<UITableViewDataSource,UITableViewDelegate>
@property(nonatomic,strong) NSArray *showArray;

@end
