//
//  MenuListViewController.m
//  Healthy Guys
//
//  Created by CandyDear on 15/10/15.
//  Copyright (c) 2015年 mac04. All rights reserved.
//

#import "MenuListViewController.h"
#import "MJRefresh.h"
#import "MenuListCell.h"
#import "MenuListModel.h"
#import "UIImageView+WebCache.h"
#import "MenuShowViewController.h"
#import "Common.h"
#import "MJRefresh.h"
@interface MenuListViewController ()<UITableViewDelegate,UITableViewDataSource>
{
    UITableView *_tableView;
    NSArray *_listArray;
    int _indexM;

}

@end

@implementation MenuListViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.title = @"菜单列表";
    [self _createTableView];
//    [self requestWebData];
}
-(void)requestWebData
{
    //构造URL
    NSString *httpUrl = @"http://apis.baidu.com/tngou/cook/list";
    NSString *httpArg = [NSString stringWithFormat:@"id=%li&page=1&rows=20",_listID];
//    NSString *httpArg = @"id=0&page=2&rows=20";
    [self listRequest:httpUrl withHttpArg:httpArg];
    
}
-(void)_createTableView
{
    _tableView = [[UITableView alloc] initWithFrame:self.view.bounds];
    _tableView.dataSource = self;
    _tableView.delegate = self;
    _tableView.backgroundColor = [UIColor clearColor];
    [self.view addSubview:_tableView];
    
    [self _loadMoreData];
    
    _tableView.header = [MJRefreshNormalHeader headerWithRefreshingTarget:self refreshingAction:@selector(_loadNewData)];
    _tableView.footer = [MJRefreshAutoFooter footerWithRefreshingTarget:self refreshingAction:@selector(_loadMoreData)];
    
    
    UINib *nib = [UINib nibWithNibName:@"MenuListCell" bundle:nil];
    [_tableView registerNib:nib forCellReuseIdentifier:@"MenuListCell"];
    
    //构造URL
    NSString *httpUrl = @"http://apis.baidu.com/tngou/cook/list";
    NSString *httpArg = [NSString stringWithFormat:@"id=%li&page=1&rows=20",_listID];
    [self listRequest:httpUrl withHttpArg:httpArg];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
#pragma mark -
- (void)_loadNewData {
    _indexM--;
    if(_indexM == 0)
    {
        _indexM = 1;
    }
    NSString *httpUrl = @"http://apis.baidu.com/tngou/cook/list";
    NSString *httpArg = [NSString stringWithFormat:@"id=%ld&page=%i&rows=20",_listID,_indexM];
    [self listRequest:httpUrl withHttpArg:httpArg];
}
- (void)_loadMoreData {
    [(NSMutableArray *)_listArray removeLastObject];
    _indexM++;
    
    NSString *httpUrl = @"http://apis.baidu.com/tngou/cook/list";
    NSString *httpArg = [NSString stringWithFormat:@"id=%ld&page=%i&rows=20",_listID,_indexM];
    [self listRequest:httpUrl withHttpArg:httpArg];
    

}
#pragma mark - 网络请求方法
-(void)listRequest: (NSString*)httpUrl withHttpArg: (NSString*)HttpArg
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
        NSDictionary *dic = [NSJSONSerialization JSONObjectWithData:data options:NSJSONReadingMutableContainers error:nil];
        
        //数据存储,字典中两个键值对tngou对应的是数组，其中有字典
        _listArray = dic[@"tngou"];
    
        [_tableView reloadData];
    }
    [_tableView.header endRefreshing];
    [_tableView.footer endRefreshing];
    
    
}
#pragma mark - UITableView 代理
-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return _listArray.count;
}
-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    MenuListCell *cell = [tableView dequeueReusableCellWithIdentifier:@"MenuListCell" forIndexPath:indexPath];
    NSDictionary *dic = _listArray[indexPath.row];
    MenuListModel *model = [MenuListModel MenuListWithContentsOfDictionary:dic];
    cell.nameLabel.text = model.name;
    cell.foodLabel.text = model.food;
    cell.keywordsLabel.text = model.keywords;
    //设置图片http://tnfs.tngou.net/image
    NSString *urlString = [NSString stringWithFormat:@"http://tnfs.tngou.net/image/%@",model.imageName];
    [cell.foodImageView sd_setImageWithURL:[NSURL URLWithString:urlString]];
    return cell;
}
-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 140;
}
-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    MenuShowViewController *showVC = [[MenuShowViewController alloc] init];
    NSDictionary *dic = _listArray[indexPath.row];
    MenuListModel *model = [MenuListModel MenuListWithContentsOfDictionary:dic];
    showVC.listName = model.name;
    

    [self.navigationController pushViewController:showVC animated:YES];
}

@end
