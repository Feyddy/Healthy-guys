//
//  LoginViewController.m
//  QZoneLogin
//
//  Created by wei.chen on 14-8-4.
//  Copyright (c) 2014年 www.iphonetrain.com 无限互联3G学院. All rights reserved.
//

#import "LoginViewController.h"
@interface LoginViewController ()

@end

@implementation LoginViewController

//- (void)dealloc {
////    [logoImg release];
////    [qzoneImg release];
////    [qqTextField release];
////    [passField release];
////    [loginButton release];
//    [loginView release];
//    [super dealloc];
//}

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    [self _createView];
    
//    UIImage *btnImg = [UIImage imageNamed:@"btn_login_login"];
//    btnImg = [btnImg stretchableImageWithLeftCapWidth:5 topCapHeight:0];
//    [loginButton setBackgroundImage:btnImg forState:UIControlStateNormal];
    
    qqTextField.delegate = self;
    passField.delegate = self;
    
}

- (void)_createView {
    UIImageView *imageView = [[UIImageView alloc] initWithFrame:CGRectMake((self.view.bounds.size.width - 100)/2, 100, 100, 100)];
    imageView.backgroundColor = [UIColor blackColor];
    imageView.layer.cornerRadius = 50;
    imageView.layer.borderWidth = 3;
    imageView.image = [UIImage imageNamed:@"headerView"];
    imageView.clipsToBounds = YES;
    imageView.layer.borderColor = [UIColor redColor].CGColor;
    [self.view addSubview:imageView];
    
//    [loginButton setBackgroundImage:[UIImage imageNamed:@"search_item_bg1.png"] forState:UIControlStateNormal];
    
}


#pragma mark - UITextField delegate
- (BOOL)textFieldShouldBeginEditing:(UITextField *)textField {
    
//    NSLog(@"将要开始编辑,键盘弹出");
    [UIView beginAnimations:nil context:nil];
    [UIView setAnimationDuration:.3];
    
//    logoImg.frame = CGRectMake(20, 25, 40, 40);
//    qzoneImg.frame = CGRectMake(60, 30, 100, 35);
//    
//    CGRect frame = loginView.frame;
//    frame.origin.y = 60;
//    loginView.frame = frame;
    
    [UIView commitAnimations];
    
    
    return YES;
}

- (IBAction)loginAction:(id)sender {
    
    [UIView beginAnimations:nil context:nil];
    [UIView setAnimationDuration:.3];
    
//    logoImg.frame = CGRectMake(98, 20, 125, 119);
//    qzoneImg.frame = CGRectMake(98, 147, 125, 44);
//    
//    CGRect frame = loginView.frame;
//    frame.origin.y = 193;
//    loginView.frame = frame;
    
    [UIView commitAnimations];
    
    
    //收起键盘
    [self.view endEditing:YES];
    
    
}

- (IBAction)registAction:(id)sender {
    
    RegistViewController *reg = [[RegistViewController alloc] init];
    
    //当前登陆控制器作为注册控制器的代理对象
    reg.delegate = self;
    
    [self.navigationController pushViewController:reg animated:YES];
    
//    [reg release];
}


#pragma mark - RegistViewController delegate
- (void)registSuccess:(NSString *)username
             password:(NSString *)pass {
    
    qqTextField.text = username;
    passField.text = pass;
    
}


@end
