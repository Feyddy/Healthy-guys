//
//  BookListViewController.m
//  项目三~healthy guys
//
//  Created by Mac on 15/10/9.
//  Copyright (c) 2015年 Feyddy. All rights reserved.
//

#import "BookListViewController.h"
#import "BookListCell.h"
#import "BookDetailViewController.h"
#import "BookListModel.h"
#import "Common.h"
#import "MJRefresh.h"
#import "BookListDetailViewController.h"
@interface BookListViewController ()<UITableViewDelegate,UITableViewDataSource>
{
    UITableView *_bookListTableView;
    NSMutableArray *_allDicArray;
    int _indexM;
}

@end

@implementation BookListViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.title = @"列表";
    _indexM = 0;
    [self _createListTableView];
}

#pragma mark - 创建咨询列表的表视图
- (void)_createListTableView
{
    _bookListTableView = [[UITableView alloc] initWithFrame:self.view.bounds];
    _bookListTableView.backgroundColor = [UIColor clearColor];
    [self.view addSubview:_bookListTableView];
    
    _bookListTableView.delegate = self;
    _bookListTableView.dataSource = self;
    
    
    [self _loadMoreData];
    
    //    _consultTableView.header = [MJRefreshNormalHeader headerWithRefreshingTarget:self refreshingAction:@selector(_loadFollowData)];
    _bookListTableView.header = [MJRefreshNormalHeader headerWithRefreshingTarget:self refreshingAction:@selector(_loadFollowData)];

    
    
    _bookListTableView.footer = [MJRefreshAutoNormalFooter footerWithRefreshingTarget:self refreshingAction:@selector(_loadMoreData)];
    
    
    
    NSString *httpUrl = @"http://apis.baidu.com/tngou/book/list";
    NSString *httpArg = [NSString stringWithFormat:@"id=%ld&page=1&rows=10",_indexPathRow];
    //NSLog(@"%ld",_indexPathRow);
    //有问题：id与前面的对应不上
    [self request: httpUrl withHttpArg: httpArg];
}

//上拉刷新
- (void)_loadMoreData{
    
    [_allDicArray removeLastObject];
    
    _indexM++;
    
    NSString *httpUrl = @"http://apis.baidu.com/tngou/book/list";
    NSString *httpArg = [NSString stringWithFormat:@"id=%ld&page=%d&rows=10",_indexPathRow,_indexM];
    //NSLog(@"%ld",_indexPathRow);
    //有问题：id与前面的对应不上
    [self request: httpUrl withHttpArg: httpArg];
    
    
}
//下拉刷新
- (void)_loadFollowData{
    
    _indexM--;
    if (_indexM == 0) {
        _indexM = 1;
    }
    
    NSString *httpUrl = @"http://apis.baidu.com/tngou/book/list";
    NSString *httpArg = [NSString stringWithFormat:@"id=%ld&page=%i&rows=10",_indexPathRow,_indexM];
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
        
        //NSLog(@"%@",jsonString);
        
        //JSON解析
        NSDictionary *dataDic = [[NSDictionary alloc] init];
        dataDic = [NSJSONSerialization JSONObjectWithData:data options:NSJSONReadingMutableContainers error:nil];
        NSArray *tngouArray = dataDic[@"tngou"];
        
        for (NSDictionary *dic in tngouArray)
        {
            BookListModel *book = [[BookListModel alloc] initWithDictionary:dic];
            [_allDicArray addObject:book];
            [_bookListTableView reloadData];
        }
        [_bookListTableView.footer endRefreshing];
        [_bookListTableView.header endRefreshing];
        
    }
    
}

#pragma mark - UITableViewDataSource
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return _allDicArray.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *identifier = @"BookListCell";
    
    BookListCell *cell = [tableView dequeueReusableCellWithIdentifier:identifier];
    
    if (cell == nil)
    {
        cell = [[[NSBundle mainBundle]loadNibNamed:@"BookListCell" owner:nil options:nil]lastObject];
        cell.backgroundColor = [UIColor clearColor];
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
    }
    cell.bookListModel = _allDicArray[indexPath.row];

//    //辅助图标
//    cell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
//    
    return cell;
    
}

-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    BookListModel *book = _allDicArray[indexPath.row];
   
    NSString *string = book.bookSummary;
    
    CGSize maxSize = CGSizeMake(kScreenWidth , CGFLOAT_MAX);
    
    NSDictionary *attributes = @{NSFontAttributeName:[UIFont systemFontOfSize:13]};
    
    CGRect rect = [string boundingRectWithSize:maxSize options:NSStringDrawingUsesLineFragmentOrigin attributes:attributes context:nil];
    return rect.size.height + 200 ;

}

//-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
//{
//    
//    BookListDetailViewController *bookDetail = [[BookListDetailViewController alloc] init];
//    bookDetail.indexRow = (NSInteger)indexPath.row+1;
//    [self.navigationController pushViewController:bookDetail animated:YES];
//}

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
