//
//  BookViewController.m
//  项目三~healthy guys
//
//  Created by Mac on 15/10/9.
//  Copyright (c) 2015年 Feyddy. All rights reserved.
//

#import "BookViewController.h"
#import "Common.h"
#import "BookListViewController.h"
#import "BookModel.h"

@interface BookViewController ()<UITableViewDataSource,UITableViewDelegate>
{
    UITableView *_bookTableView;
    NSArray *_array;
    NSMutableArray *_nameArray;
    NSMutableArray *_descriptionArray;
}

@end

@implementation BookViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    NSString *httpUrl = @"http://apis.baidu.com/tngou/book/classify";
    NSString *httpArg = @"";
    [self request: httpUrl withHttpArg: httpArg];
    
    [self _createBookTableView];

}

-(void)request: (NSString*)httpUrl withHttpArg: (NSString*)HttpArg  {
    NSString *urlStr = [[NSString alloc]initWithFormat: @"%@?%@", httpUrl, HttpArg];
    NSURL *url = [NSURL URLWithString: urlStr];
    
    //    2.构造NSURLRequest
    NSMutableURLRequest *request = [NSMutableURLRequest requestWithURL:url];
    
    //    3.设置请求相关的信息
    //设置请求方式，默认是GET请求
    request.HTTPMethod = @"GET";
    //设置请求超时时间
    request.timeoutInterval = 60;
    
    //设置请求头
    //    request.allHTTPHeaderFields = @{
    //
    //                                   };
    [request addValue: @"6bc2f7f95fcf078e12edb003bc89cb8d" forHTTPHeaderField: @"apikey"];
    
    //    4.构造NSURLConnection，发送请求
    NSURLResponse *response = nil;
    NSError *error = nil;
    NSData *data = [NSURLConnection sendSynchronousRequest:request returningResponse:&response error:&error];
    
    //    5.获取响应头信息
    //    NSHTTPURLResponse *httpResponse = (NSHTTPURLResponse *)response;
    //获取状态码
    //    NSInteger statusCode = httpResponse.statusCode;
    //    NSLog(@"状态码:%li", statusCode);
    //
    //    //响应头
    //    NSLog(@"响应头:%@", httpResponse.allHeaderFields);
    
    
//    _allDicArray = [[NSMutableArray alloc] init];
    //    6.获取响应数据信息
    if (data != nil)
    {
        
//        NSString *jsonString = [[NSString alloc] initWithData:data encoding:NSUTF8StringEncoding];
        
        //NSLog(@"%@",jsonString);
        
        //JSON解析
        _array = [NSJSONSerialization JSONObjectWithData:data options:NSJSONReadingMutableContainers error:nil];
        _descriptionArray = [NSMutableArray array];
        _nameArray = [NSMutableArray array];
        
        for (NSDictionary *dic in _array) {
            [_nameArray addObject:dic[@"name"]];
            [_descriptionArray addObject:dic[@"description"]];
            
        }
 
    }
    
}

- (void)_createBookTableView
{
    _bookTableView = [[UITableView alloc] initWithFrame:self.view.bounds];
    _bookTableView.backgroundColor = [UIColor clearColor];
    
    [self.view addSubview:_bookTableView];
    _bookTableView.delegate = self;
    _bookTableView.dataSource = self;
    
}

#pragma mark - UITableViewDataSource
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return _array.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *identifier = @"cell";
    
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:identifier];
    
    if (cell == nil)
    {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:identifier];

    }
    
    UILabel *titleLabel = [[UILabel alloc] initWithFrame:CGRectMake(10, 5, kScreenWidth - 40, 30)];
    titleLabel.backgroundColor = [UIColor clearColor];
    titleLabel.text = _nameArray[indexPath.row];
    
    UILabel *descriptionLabel = [[UILabel alloc] initWithFrame:CGRectMake(10, 35, kScreenWidth - 40, 20)];
    descriptionLabel.font = [UIFont systemFontOfSize:14];
    descriptionLabel.backgroundColor = [UIColor clearColor];
    descriptionLabel.text = _descriptionArray[indexPath.row];
    
    [cell.contentView addSubview:titleLabel];
    [cell.contentView addSubview:descriptionLabel];
    
    cell.backgroundColor = [UIColor clearColor];
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    //辅助图标
    cell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
    
    return cell;
    
}

-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 60;
}

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    BookListViewController *bookListC = [[BookListViewController alloc] init];
    bookListC.indexPathRow = (NSInteger )indexPath.row+1;
    
    [self.navigationController pushViewController:bookListC animated:YES];
}





- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}



@end
