//
//  BaseViewController.h
//  FeyddyWeiBo
//
//  Created by Mac on 15/10/8.
//  Copyright (c) 2015年 Feyddy. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface BaseViewController : UIViewController

@property (nonatomic,assign) NSInteger selectedIndex;
- (void)_loadImage;
-(void)setNavItem;
-(void)showHUD:(NSString *)title;

-(void)completeHUD:(NSString *)title;

//-(NSArray *)request: (NSString*)httpUrl withHttpArg: (NSString*)HttpArg;
@end
