//
//  BookRecommendViewController.m
//  项目三~healthy guys
//
//  Created by Mac on 15/10/26.
//  Copyright (c) 2015年 Feyddy. All rights reserved.
//

#import "BookRecommendViewController.h"
#import "BookListModel.h"
#import "MJRefresh.h"
#import "BookListCell.h"
#import "Common.h"
#import "BookRecommendModel.h"
#import "BookRecommendCell.h"
#import "BookDetailViewController.h"
#import "BookDetailModel.h"

@interface BookRecommendViewController ()<UITableViewDataSource,UITableViewDelegate>
{
//    UITableView *_bookRecommendTableView;
    
    NSArray *_bookListArray;
    NSMutableArray *_array;
    
    UIView *_headView;
    
    UIImageView *_topImageView;
    UILabel *_author;
    UILabel *_bookList;
    UITableView *_bookListTableView;
    NSMutableArray *_allDicArray;
    int _indexM;
    
}


@end

@implementation BookRecommendViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
//    
    self.title = @"推荐排行";

    _array = [[NSMutableArray alloc] init];
    
    _imageArray = [[NSMutableArray alloc] init];
    
    _allDicArray = [[NSMutableArray alloc] init];
    [self _createListTableView];

    for (int i = 1; i <= 3; i++) {
        NSString *httpUrl = @"http://apis.baidu.com/tngou/book/show";
        NSString *httpArg = [NSString stringWithFormat:@"id=%d",i];
        [self request: httpUrl withHttpArg: httpArg];
    }
    _indexM = 0;
//    [self _createListTableView];
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

    _bookListTableView.header = [MJRefreshNormalHeader headerWithRefreshingTarget:self refreshingAction:@selector(_loadFollowData)];
    
    _bookListTableView.footer = [MJRefreshAutoNormalFooter footerWithRefreshingTarget:self refreshingAction:@selector(_loadMoreData)];
    

}

//上拉刷新
- (void)_loadMoreData{
    
    [_allDicArray removeLastObject];
    
    _indexM++;
    
//    NSString *httpUrl = @"http://apis.baidu.com/tngou/book/show";
//    NSString *httpArg = [NSString stringWithFormat:@"id=%ld&page=%d&rows=10",1,_indexM];
//    //NSLog(@"%ld",_indexPathRow);
//    //有问题：id与前面的对应不上
//    [self request: httpUrl withHttpArg: httpArg];
    
    
    
    for (int i = _indexM * 3; i <= (_indexM+1) * 3; i++) {
        NSString *httpUrl = @"http://apis.baidu.com/tngou/book/show";
        NSString *httpArg = [NSString stringWithFormat:@"id=%d",i];
        [self request: httpUrl withHttpArg: httpArg];
    }
    
    
}
//下拉刷新
- (void)_loadFollowData{
    
    _indexM--;
    if (_indexM == 0) {
        _indexM = 1;
    }
    
    for (int i = (_indexM - 1) * 3; i <= _indexM * 3; i++) {
        NSString *httpUrl = @"http://apis.baidu.com/tngou/book/show";
        NSString *httpArg = [NSString stringWithFormat:@"id=%d",i];
        [self request: httpUrl withHttpArg: httpArg];
    }
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
    

    
    //    6.获取响应数据信息
    if (data != nil)
    {
//        
//        NSString *jsonString = [[NSString alloc] initWithData:data encoding:NSUTF8StringEncoding];
//        
//        NSLog(@"%@",jsonString);
        
        //JSON解析
      NSDictionary *dataDic = [[NSDictionary alloc] init];
        dataDic = [NSJSONSerialization JSONObjectWithData:data options:NSJSONReadingMutableContainers error:nil];

        NSString *imge = dataDic[@"img"];
        if (imge.length != 0) {
            
            [_imageArray addObject:imge];

            
        }
        _imageArray = (NSMutableArray *)[[_imageArray reverseObjectEnumerator] allObjects];
        BookRecommendModel *book = [[BookRecommendModel alloc] initWithDictionary:dataDic];
        
        [_allDicArray addObject:book];
        [_bookListTableView reloadData];
        
        

        _bookListArray = dataDic[@"list"];
        for (NSDictionary *dic in _bookListArray) {
            BookDetailModel *model = [[BookDetailModel alloc] init];
            model.message = dic[@"message"];
            model.title = dic[@"title"];
            [_array addObject:model];

        }
        _array = (NSMutableArray *)[[_array reverseObjectEnumerator] allObjects];
    
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
    static NSString *identifier = @"BookRecommendCell";
    
    BookRecommendCell *cell = [tableView dequeueReusableCellWithIdentifier:identifier];
    
    if (cell == nil)
    {
        cell = [[[NSBundle mainBundle]loadNibNamed:@"BookRecommendCell" owner:nil options:nil]lastObject];
        cell.backgroundColor = [UIColor clearColor];
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
    }
    cell.model = _allDicArray[indexPath.row];
    
    return cell;
    
}

-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    BookRecommendModel *book = _allDicArray[indexPath.row];
    
    NSString *string = book.bookSummary;
    
    CGSize maxSize = CGSizeMake(kScreenWidth , CGFLOAT_MAX);
    
    NSDictionary *attributes = @{NSFontAttributeName:[UIFont systemFontOfSize:13]};
    
    CGRect rect = [string boundingRectWithSize:maxSize options:NSStringDrawingUsesLineFragmentOrigin attributes:attributes context:nil];
    return rect.size.height + 400 ;
    
}

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    
    BookDetailViewController *bookDetail = [[BookDetailViewController alloc] init];
    bookDetail.indexRow = (NSInteger)indexPath.row+1;
    bookDetail.array = _array;
    bookDetail.imageArray = _imageArray;
    [self.navigationController pushViewController:bookDetail animated:YES];
}
//-(void)request: (NSString*)httpUrl withHttpArg: (NSString*)HttpArg  {
//    NSString *urlStr = [[NSString alloc]initWithFormat: @"%@?%@", httpUrl, HttpArg];
//    NSURL *url = [NSURL URLWithString: urlStr];
//    
//    //2.构造NSURLRequest
//    NSMutableURLRequest *request = [NSMutableURLRequest requestWithURL:url];
//    
//    //3.设置请求相关的信息
//    //设置请求方式，默认是GET请求
//    request.HTTPMethod = @"GET";
//    //设置请求超时时间
//    request.timeoutInterval = 60;
//    
//    //设置请求头
//    //    request.allHTTPHeaderFields = @{
//    //
//    //                                   };
//    [request addValue: @"6bc2f7f95fcf078e12edb003bc89cb8d" forHTTPHeaderField: @"apikey"];
//    
//    //    4.构造NSURLConnection，发送请求
//    NSURLResponse *response = nil;
//    NSError *error = nil;
//    NSData *data = [NSURLConnection sendSynchronousRequest:request returningResponse:&response error:&error];
//    
//    //    //    5.获取响应头信息
//    //    NSHTTPURLResponse *httpResponse = (NSHTTPURLResponse *)response;
//    //    //获取状态码
//    //    NSInteger statusCode = httpResponse.statusCode;
//    //    //    NSLog(@"状态码:%li", statusCode);
//    //    //
//    //    //    //响应头
//    //    //    NSLog(@"响应头:%@", httpResponse.allHeaderFields);
//    
//    
//    _bookListArray = [[NSArray alloc] init];
//    _array = [[NSMutableArray alloc] init];
//    //    6.获取响应数据信息
//    if (data != nil)
//    {
//        //
//        //        NSString *jsonString = [[NSString alloc] initWithData:data encoding:NSUTF8StringEncoding];
//        //
//        //        NSLog(@"%@",jsonString);
//        
//        //JSON解析
//        NSDictionary *dataDic = [[NSDictionary alloc] init];
//        dataDic = [NSJSONSerialization JSONObjectWithData:data options:NSJSONReadingMutableContainers error:nil];
//        
//        _author.text =[NSString stringWithFormat:@"作者:%@",dataDic[@"author"]];
//        
//        NSString *imageString = [NSString stringWithFormat:@"http://tnfs.tngou.net/image%@",dataDic[@"img"]];
//        NSURL *imageUrl = [NSURL URLWithString:imageString];
//        [_topImageView sd_setImageWithURL:imageUrl];
//        
//        _bookListArray = dataDic[@"list"];
//        for (NSDictionary *dic in _bookListArray) {
//            BookDetailModel *model = [[BookDetailModel alloc] init];
//            model.message = dic[@"message"];
//            model.title = dic[@"title"];
//            [_array addObject:model];
//            
//        }
//        _array = (NSMutableArray *)[[_array reverseObjectEnumerator] allObjects];
//    }
//    
//}

//- (void)_createTableView
//{
//
//    _bookRecommendTableView = [[UITableView alloc] initWithFrame:self.view.bounds];
//    _bookRecommendTableView.backgroundColor = [UIColor clearColor];
//    [self.view addSubview:_bookRecommendTableView];
//}


/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
