//
//  MenuShowCell.h
//  Healthy Guys
//
//  Created by CandyDear on 15/10/15.
//  Copyright (c) 2015年 mac04. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "MenuShowModel.h"
@interface MenuShowCell : UITableViewCell
@property (strong, nonatomic) IBOutlet UIImageView *headImageView;

@property (strong, nonatomic) IBOutlet UILabel *foodDescriptionLabel;
//@property (strong, nonatomic) IBOutlet UITextView *messageView;
@property (strong, nonatomic) IBOutlet UILabel *messageLabel;

@property (nonatomic, strong) MenuShowModel *showModel;
@end
