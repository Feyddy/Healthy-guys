//
//  RegistViewController.m
//  QZoneLogin
//
//  Created by wei.chen on 14-8-4.
//  Copyright (c) 2014年 www.iphonetrain.com 无限互联3G学院. All rights reserved.
//
#import "RegistViewController.h"
#import "MyNetWorkQuery.h"
#import "UIKit+AFNetworking.h"


@interface RegistViewController ()

@property(nonatomic, strong)NSDictionary *checkData;

@end

@implementation RegistViewController

//- (void)dealloc {
//    [qqField release];
//    [passField release];
//    [nickField release];
//    [checkCodeField release];
//    [checkImage release];
//    [super dealloc];
//}

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
//        barImageView.imageName =;
//        barImageView.image = [UIImage im]
        // Custom initialization
    }
    return self;
}

- (UIStatusBarStyle)preferredStatusBarStyle {
    return UIStatusBarStyleLightContent;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    //当界面弹出后，让第一个输入框获取焦点，显示键盘
    [qqField becomeFirstResponder];
    
    
    //申请验证码
    [self requestCheckCode];
    
    //给验证码图片增加一个点击手势
    UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(tapImage)];
    
    checkImage.userInteractionEnabled = YES;
    
    [checkImage addGestureRecognizer:tap];
    

}

- (void)tapImage {
    
    //获取验证码对应的url
    NSString *imgURL = _checkData[@"checkCodeUrl"];
    
    //先去本地缓存找图片，如果没有才去网络下载，强制改变URL，每次都重新下载
    //http://www.ximalaya.com/check/getcode?codeId=825794e0123c415eabb4b3945ad41258&time=189077666
    //加时间戳作为参数，目的是为了防止缓存，使每次都重新下载，不会影响服务器的逻辑
    NSDate *date = [NSDate date];
    
    NSTimeInterval interval = [date timeIntervalSince1970];
    imgURL = [imgURL stringByAppendingFormat:@"&time=%f",interval];
    //直接通过ImageView的扩展方法，来加载图片并且显示在ImageView上。
    [checkImage setImageWithURL:[NSURL URLWithString:imgURL]];

    
    
}


- (void)requestCheckCode {
    
    NSString *urlString = @"/mobile/checkCode";
    NSDictionary *params = @{
                             @"device" : @"iphone"
                             
                             };
    
    [MyNetWorkQuery AFRequestData:urlString HTTPMethod:@"GET" params:[params mutableCopy] completionHandle:^(id result) {
        
        //获取解析的json数据
        self.checkData = result;
        
        //获取验证码对应的url
        NSString *imgURL = _checkData[@"checkCodeUrl"];
        //直接通过ImageView的扩展方法，来加载图片并且显示在ImageView上。
        [checkImage setImageWithURL:[NSURL URLWithString:imgURL]];
        
        
        
    } errorHandle:^(NSError *error) {
        NSLog(@"获取验证码图片失败:%@", error);
    }];
    
    
}

//实现协议方法：textFieldShouldReturn，
- (BOOL)textFieldShouldReturn:(UITextField *)textField {
    NSString *qqText = qqField.text;
    NSString *passText = passField.text;
    NSString *nickText = nickField.text;
    NSString *checkText = checkCodeField.text;
    
//都需要判断不为空才可以
    if (qqText.length == 0 || passText.length == 0 ||nickText.length == 0 || checkText.length == 0) {
        
        UIAlertView *alertView = [[UIAlertView alloc] initWithTitle:@"提示" message:@"用户名或密码为空" delegate:self cancelButtonTitle:@"取消" otherButtonTitles:nil, nil];
        [alertView show];
//        [alertView release];
        
        return YES;
    }
    
    //注册用户
    
    
        if ([self.delegate respondsToSelector:@selector(registSuccess:password:)]) {
            [self.delegate registSuccess:qqText password:passText];
        }
        [self dismissViewControllerAnimated:YES completion:NULL];
   
    
    
    
    ///////////////////
    
 
    
    return YES;
}


- (IBAction)cancelAction:(id)sender {
    [self dismissViewControllerAnimated:YES completion:NULL];
}
@end
