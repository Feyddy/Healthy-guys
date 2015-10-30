//
//  RegistViewController.h
//  QZoneLogin
//
//  Created by wei.chen on 14-8-4.
//  Copyright (c) 2014年 www.iphonetrain.com 无限互联3G学院. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "BaseViewController.h"
#import "ThemeImageView.h"
@protocol RegistViewControllerDelegate <NSObject>

//注册成功
- (void)registSuccess:(NSString *)username
             password:(NSString *)pass;

@end

@interface RegistViewController : BaseViewController <UITextFieldDelegate>{
    IBOutlet UITextField *qqField;
    IBOutlet UITextField *passField;
    IBOutlet UITextField *nickField;
    __weak IBOutlet ThemeImageView *barImageView;
    IBOutlet UITextField *checkCodeField;
    IBOutlet UIImageView *checkImage;
}

@property(nonatomic,assign)id<RegistViewControllerDelegate> delegate;

- (IBAction)cancelAction:(id)sender;

@end
