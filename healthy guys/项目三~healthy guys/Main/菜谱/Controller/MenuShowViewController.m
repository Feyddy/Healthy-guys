//
//  MenuShowViewController.m
//  Healthy Guys
//
//  Created by CandyDear on 15/10/15.
//  Copyright (c) 2015年 mac04. All rights reserved.
//

#import "MenuShowViewController.h"
#import "MenuShowTableView.h"
#import "Common.h"
@interface MenuShowViewController ()
{
    MenuShowTableView *_tableView;
}

@end

@implementation MenuShowViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.title = _listName;
    
    
    NSString *httpUrl = @"http://apis.baidu.com/tngou/cook/name";
    NSString *str = [_listName stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding];
    NSString *httpArg = [NSString stringWithFormat:@"name=%@",str];
    //    NSString *httpArg = @"name=%E5%AE%AB%E4%BF%9D%E9%B8%A1%E4%B8%81";
    
    _tableView.showArray = [self request:httpUrl withHttpArg:httpArg];
    

     [self _createTableView];
    [self requestWebData];
   
    
}
-(void)requestWebData
{
    //构造URL
    NSString *httpUrl = @"http://apis.baidu.com/tngou/cook/name";
    NSString *str = [_listName stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding];
    NSString *httpArg = [NSString stringWithFormat:@"name=%@",str];
//    NSString *httpArg = @"name=%E5%AE%AB%E4%BF%9D%E9%B8%A1%E4%B8%81";

    _tableView.showArray = [self request:httpUrl withHttpArg:httpArg];
}

-(NSArray *)request: (NSString*)httpUrl withHttpArg: (NSString*)HttpArg
{
    NSString *urlStr = [[NSString alloc]initWithFormat: @"%@?%@",httpUrl, HttpArg];
    NSURL *url = [NSURL URLWithString: urlStr];
    NSMutableURLRequest *request = [[NSMutableURLRequest alloc]initWithURL: url cachePolicy: NSURLRequestUseProtocolCachePolicy timeoutInterval: 10];
    [request setHTTPMethod: @"GET"];
    [request addValue: @"6bc2f7f95fcf078e12edb003bc89cb8d" forHTTPHeaderField: @"apikey"];
    NSURLResponse *response = nil;
    NSError *error = nil;
    NSData *data = [NSURLConnection sendSynchronousRequest:request returningResponse:&response error:&error];
    //NSLog(@"data = %@",data);
    //5.获取相应的头信息
//    NSHTTPURLResponse *httpResponse = (NSHTTPURLResponse *)response;
//    //获取状态码
//    NSInteger statusCode = httpResponse.statusCode;
//    NSLog(@"statusCode = %li",statusCode);
    //响应头
    //NSLog(@"响应头:%@",httpResponse.allHeaderFields);
    //获取响应数据信息
    if(data != nil)
    {
        //NSString *jsonString = [[NSString alloc] initWithData:data encoding:NSUTF8StringEncoding];
        //NSLog(@"%@",jsonString);


    }
    //数据存储
    NSArray *array = [NSJSONSerialization JSONObjectWithData:data options:NSJSONReadingMutableContainers error:nil];
    return array;
}

-(void)_createTableView
{
    _tableView = [[MenuShowTableView alloc] initWithFrame:self.view.bounds];
    _tableView.backgroundColor = [UIColor clearColor];
    [self.view addSubview:_tableView];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}




@end
