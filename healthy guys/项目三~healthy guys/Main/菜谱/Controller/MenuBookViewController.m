//
//  MenuBookViewController.m
//  项目三_Healthyguns
//
//  Created by mac on 15/10/24.
//  Copyright (c) 2015年 Janie. All rights reserved.
//

#import "MenuBookViewController.h"
#import "MenuBookCell.h"
#import "UIImageView+WebCache.h"
#import "MenuShowViewController.h"
#import "Common.h"

@interface MenuBookViewController (){
     NSArray *_listArray;
}

@end

@implementation MenuBookViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self requestWebData];
    // Do any additional setup after loading the view.
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
-(void)requestWebData
{
    //构造URL
    NSString *httpUrl = @"http://apis.baidu.com/tngou/cook/list";
    NSString *httpArg = [NSString stringWithFormat:@"id=%li&page=2&rows=100",_listID];
    //    NSString *httpArg = @"id=0&page=2&rows=20";
    [self listRequest:httpUrl withHttpArg:httpArg];
    
}
#pragma mark - 网络请求方法
-(void)listRequest: (NSString*)httpUrl withHttpArg: (NSString*)HttpArg
{
    NSString *urlStr = [[NSString alloc]initWithFormat: @"%@?%@",httpUrl, HttpArg];
    NSURL *url = [NSURL URLWithString: urlStr];
    NSMutableURLRequest *request = [[NSMutableURLRequest alloc]initWithURL: url cachePolicy: NSURLRequestUseProtocolCachePolicy timeoutInterval: 10];
    [request setHTTPMethod: @"GET"];
    [request addValue: kApikey forHTTPHeaderField: @"apikey"];
    NSURLResponse *response = nil;
    NSError *error = nil;
    NSData *data = [NSURLConnection sendSynchronousRequest:request returningResponse:&response error:&error];
    //NSLog(@"data = %@",data);
    //5.获取相应的头信息
    NSHTTPURLResponse *httpResponse = (NSHTTPURLResponse *)response;
    //获取状态码
    NSInteger statusCode = httpResponse.statusCode;
    NSLog(@"statusCode = %li",statusCode);
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
        
    }
    
}

#pragma mark - UICollectionViewDataSource

- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section{
    return _listArray.count;
}


- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath{
    MenuBookCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:@"MenuBookCell" forIndexPath:indexPath];
    NSDictionary *dic = _listArray[indexPath.row];
    MenuListModel *model = [MenuListModel MenuListWithContentsOfDictionary:dic];
    //设置图片http://tnfs.tngou.net/image
    NSString *urlString = [NSString stringWithFormat:@"http://tnfs.tngou.net/image/%@",model.imageName];
    cell.selectedBackgroundView = nil;
    [cell.menuImageView sd_setImageWithURL:[NSURL  URLWithString:urlString]];
    cell.menuNameLabel.text = model.name;
    return cell;
}

@end
