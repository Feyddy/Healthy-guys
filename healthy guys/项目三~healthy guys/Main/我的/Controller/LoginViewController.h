//
//  LoginViewController.h
//  QZoneLogin
//
//  Created by wei.chen on 14-8-4.
//  Copyright (c) 2014年 www.iphonetrain.com 无限互联3G学院. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "BaseViewController.h"
#import "RegistViewController.h"

@interface LoginViewController : BaseViewController<UITextFieldDelegate,RegistViewControllerDelegate> {
    
    IBOutlet UIImageView *logoImg;
    IBOutlet UIImageView *qzoneImg;
    IBOutlet UITextField *qqTextField;
    IBOutlet UITextField *passField;
    IBOutlet UIButton *loginButton;
    IBOutlet UIView *loginView;
    
}

- (IBAction)loginAction:(id)sender;
- (IBAction)registAction:(id)sender;
@end
