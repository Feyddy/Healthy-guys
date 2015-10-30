//
//  BookListDetailViewController.m
//  项目三~healthy guys
//
//  Created by Mac on 15/10/26.
//  Copyright (c) 2015年 Feyddy. All rights reserved.
//

#import "BookListDetailViewController.h"
#import "BookDetailCell.h"
#import "BookDetailModel.h"
#import "UIImageView+WebCache.h"
#import "Common.h"
@interface BookListDetailViewController ()<UITableViewDataSource,UITableViewDelegate>
{
    UITableView *_bookDetailTableView;
    
    NSArray *_bookListArray;
    NSMutableArray *_array;
    
    UIView *_headView;
    
    UIImageView *_topImageView;
    UILabel *_author;
    UILabel *_bookList;
}

@end

@implementation BookListDetailViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.title = @"详情";
    
    [self _createTableView];
    
    NSString *httpUrl = @"http://apis.baidu.com/tngou/book/show";
    NSString *httpArg = [NSString stringWithFormat:@"id=%ld",_indexRow];
    
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
    
    
    _bookListArray = [[NSArray alloc] init];
    _array = [[NSMutableArray alloc] init];
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
        
        _author.text =[NSString stringWithFormat:@"作者:%@",dataDic[@"author"]];
        
        NSString *imageString = [NSString stringWithFormat:@"http://tnfs.tngou.net/image%@",dataDic[@"img"]];
        NSURL *imageUrl = [NSURL URLWithString:imageString];
        [_topImageView sd_setImageWithURL:imageUrl];
        
        _bookListArray = dataDic[@"list"];
        for (NSDictionary *dic in _bookListArray) {
            BookDetailModel *model = [[BookDetailModel alloc] init];
            model.message = dic[@"message"];
            model.title = dic[@"title"];
            [_array addObject:model];
            
        }
        _array = (NSMutableArray *)[[_array reverseObjectEnumerator] allObjects];
    }
    
}


#pragma mark - 创建表视图
- (void)_createTableView
{
    _bookDetailTableView = [[UITableView alloc] initWithFrame:self.view.bounds style:UITableViewStylePlain];
    _bookDetailTableView.backgroundColor = [UIColor clearColor];
    [self.view addSubview:_bookDetailTableView];
    _bookDetailTableView.delegate = self;
    _bookDetailTableView.dataSource = self;
    
    
    //头视图不可以改变大小与位置，只有通过创建一个新的uiview然后将图片视图加入view中，让新建的view变成头视图，将图片视图加入到view中，从而可以改变图片视图的大小
    
    _headView = [[UIView alloc]initWithFrame:CGRectMake(0, 0, self.view.bounds.size.width, 220)];
    
    _topImageView = [[UIImageView alloc]initWithFrame:CGRectMake(10, 0, self.view.bounds.size.width - 20, 140)];
    _topImageView.contentMode = UIViewContentModeScaleAspectFit;
    _topImageView.backgroundColor = [UIColor clearColor];
    [_headView addSubview:_topImageView];
    
    _author = [[UILabel alloc] initWithFrame:CGRectMake(10, 145, self.view.bounds.size.width - 20, 30)];
    _author.textAlignment = NSTextAlignmentCenter;
    _author.textColor = [UIColor blackColor];
    _author.font = [UIFont systemFontOfSize:22];
    [_headView addSubview:_author];
    
    _bookList = [[UILabel alloc] initWithFrame:CGRectMake(0, 180, self.view.bounds.size.width, 40)];
    _bookList.textColor = [UIColor blackColor];
    _bookList.layer.borderWidth = .5;
    _bookList.layer.borderColor = [[UIColor grayColor]CGColor];
    _bookList.text = [NSString stringWithFormat:@"  作者相关书籍列表"];
    [_headView addSubview:_bookList];
    
    _bookDetailTableView.tableHeaderView = _headView;
    
}


#pragma mark - UITableViewDataSource
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return _array.count;
}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *identifier = @"cell";
    
    BookDetailCell *cell = [tableView dequeueReusableCellWithIdentifier:identifier];
    
    if (cell == nil)
    {
        cell = [[[NSBundle mainBundle]loadNibNamed:@"BookDetailCell" owner:nil options:nil]lastObject];
        
    }
    cell.model = _array[indexPath.row];
    
    cell.backgroundColor = [UIColor clearColor];
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    return cell;
}

-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    BookDetailModel *book = _array[indexPath.row];
    if (book.isShow) {
        NSString *string = book.message;
        
        CGSize maxSize = CGSizeMake(kScreenWidth , CGFLOAT_MAX);
        
        NSDictionary *attributes = @{NSFontAttributeName:[UIFont systemFontOfSize:13]};
        
        CGRect rect = [string boundingRectWithSize:maxSize options:NSStringDrawingUsesLineFragmentOrigin attributes:attributes context:nil];
        return rect.size.height + 300;
    }
    return 200;
    
}



//单元格选中事件
-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    BookDetailModel *detailModel = _array[indexPath.row];
    detailModel.isShow = ! detailModel.isShow;
    
    //刷新单元格
    [tableView reloadRowsAtIndexPaths:@[indexPath] withRowAnimation:UITableViewRowAnimationFade];
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
