//
//  ConsultListViewController.m
//  项目三~healthy guys
//
//  Created by Mac on 15/10/9.
//  Copyright (c) 2015年 Feyddy. All rights reserved.
//

#import "ConsultListViewController.h"
#import "ConsultListCell.h"
#import "ConsultDetailViewController.h"
#import "ConsultListModel.h"
#import "ListDetailViewController.h"
#import "MJRefresh.h"

@interface ConsultListViewController ()<UITableViewDataSource,UITableViewDelegate>
{
    UITableView *_consultListTableView;
    NSMutableArray *_allDicArray;
    int _indexM;
}
@end

@implementation ConsultListViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.title = @"列表";
    _indexM = 0;
    //创建咨询列表的表视图
    [self _createListTableView];
    
}

#pragma mark - 创建咨询列表的表视图
- (void)_createListTableView
{
    _consultListTableView = [[UITableView alloc] initWithFrame:self.view.bounds];
    _consultListTableView.backgroundColor = [UIColor clearColor];
    [self.view addSubview:_consultListTableView];
    
    _consultListTableView.delegate = self;
    _consultListTableView.dataSource = self;
    
    NSString *httpUrl = @"http://apis.baidu.com/tngou/info/list";
    NSString *httpArg = [NSString stringWithFormat:@"id=%ld&page=1&rows=20",_indexPathRow];
    [self request: httpUrl withHttpArg: httpArg];
    
    
    [self _loadMoreData];
    
    _consultListTableView.header = [MJRefreshNormalHeader headerWithRefreshingTarget:self refreshingAction:@selector(_loadFollowData)];
    
    _consultListTableView.footer = [MJRefreshAutoNormalFooter footerWithRefreshingTarget:self refreshingAction:@selector(_loadMoreData)];
}


//上拉刷新
- (void)_loadMoreData{
    
    _indexM++;
    
    NSString *httpUrl = @"http://apis.baidu.com/tngou/info/list";
    NSString *httpArg = [NSString stringWithFormat:@"id=%ld&page=%i&rows=20",_indexPathRow,_indexM];
    [self request: httpUrl withHttpArg: httpArg];
    
}

//下拉刷新
- (void)_loadFollowData{
    
    _indexM--;
    if (_indexM == 0) {
        _indexM = 1;
    }
    
    NSString *httpUrl = @"http://apis.baidu.com/tngou/info/list";
    NSString *httpArg = [NSString stringWithFormat:@"id=%ld&page=%i&rows=20",_indexPathRow,_indexM];
    [self request: httpUrl withHttpArg: httpArg];
    
}


-(void)request: (NSString*)httpUrl withHttpArg: (NSString*)HttpArg  {
    NSString *urlStr = [[NSString alloc]initWithFormat: @"%@?%@", httpUrl, HttpArg];
    NSURL *url = [NSURL URLWithString: urlStr];
    
    //2.构造NSURLRequest
    NSMutableURLRequest *request = [NSMutableURLRequest requestWithURL:url];
    
    //3.设置请求相关的信息
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
    
//    //    5.获取响应头信息
//    NSHTTPURLResponse *httpResponse = (NSHTTPURLResponse *)response;
//    //获取状态码
//    NSInteger statusCode = httpResponse.statusCode;
//    //    NSLog(@"状态码:%li", statusCode);
//    //
//    //    //响应头
//    //    NSLog(@"响应头:%@", httpResponse.allHeaderFields);
    
    
    _allDicArray = [[NSMutableArray alloc] init];
    //    6.获取响应数据信息
    if (data != nil)
    {
        
//        NSString *jsonString = [[NSString alloc] initWithData:data encoding:NSUTF8StringEncoding];
        
//        NSLog(@"%@",jsonString);
        
        //JSON解析
        NSDictionary *dataDic = [[NSDictionary alloc] init];
        dataDic = [NSJSONSerialization JSONObjectWithData:data options:NSJSONReadingMutableContainers error:nil];
        NSArray *tngouArray = dataDic[@"tngou"];
        
        for (NSDictionary *dic in tngouArray)
        {
            ConsultListModel *consult = [[ConsultListModel alloc] initWithDictionary:dic];
            
            [_allDicArray addObject:consult];
            [_consultListTableView reloadData];
        }
    }
    [_consultListTableView.header endRefreshing];
    [_consultListTableView.footer endRefreshing];
}

#pragma mark - UITableViewDataSource
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return _allDicArray.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *identifier = @"cell";
    
    ConsultListCell *cell = [tableView dequeueReusableCellWithIdentifier:identifier];
    
    if (cell == nil)
    {
        cell = [[[NSBundle mainBundle]loadNibNamed:@"ConsultListCell" owner:nil options:nil]lastObject];
        cell.backgroundColor = [UIColor clearColor];
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
    }
    
    cell.consultListModel = _allDicArray[indexPath.row];
    
    return cell;
    
}

-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 260;
}

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    ListDetailViewController *listDetailVC = [[ListDetailViewController alloc] init];
    listDetailVC.array = _allDicArray;
    listDetailVC.indexRow = (NSInteger)indexPath.row;
    
    [self.navigationController pushViewController:listDetailVC animated:YES];
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
