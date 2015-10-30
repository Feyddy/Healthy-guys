//
//  MenuListCell.h
//  Healthy Guys
//
//  Created by CandyDear on 15/10/15.
//  Copyright (c) 2015年 mac04. All rights reserved.
//
/*
 
 { "total":111096,"tngou":
 [
 {"count":14,
 "description":"",
 "fcount":0,
 "food":"",
 "id":111182,
 "images":"", //【1】
 "img":"",  //【1】
 "keywords":" ",
 "name":"经典美味奶油泡芙",
 "rcount":0},
 {……}
 */
#import <UIKit/UIKit.h>

@interface MenuListCell : UITableViewCell
@property (strong, nonatomic) IBOutlet UIImageView *foodImageView;
@property (strong, nonatomic) IBOutlet UILabel *nameLabel;
@property (strong, nonatomic) IBOutlet UILabel *foodLabel;
@property (strong, nonatomic) IBOutlet UILabel *keywordsLabel;

@end
