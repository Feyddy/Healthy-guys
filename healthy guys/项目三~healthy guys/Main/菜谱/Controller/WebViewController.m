//
//  WebViewController.m
//  项目三~healthy guys
//
//  Created by CandyDear on 15/10/26.
//  Copyright (c) 2015年 Feyddy. All rights reserved.
//

#import "WebViewController.h"

@interface WebViewController ()

@end

@implementation WebViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.title = @"营养学说";
    UIWebView *web = [[UIWebView alloc] initWithFrame:self.view.bounds];
    [self.view addSubview:web];
    
    //URL网络地址
    NSURL *url = [NSURL URLWithString:@"http://img4.hoto.cn/mobile/html/nutrition-experts/index.html"];
    //网络请求
    NSURLRequest *request = [[NSURLRequest alloc] initWithURL:url];
    //使用一个网络请求 来加载页面
    [web loadRequest:request];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
