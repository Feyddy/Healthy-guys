//
//  MenuViewController.m
//  项目三_Healthyguns
//
//  Created by mac on 15/10/8.
//  Copyright (c) 2015年 Janie. All rights reserved.
//

#import "MenuViewController.h"
#import "MenuClassModel.h"
#import "MenuClassCell.h"
#import "LeftViewController.h"
#import "UIImageView+WebCache.h"
#import "MenuListViewController.h"
#import "Common.h"
#import "WebViewController.h"

@interface MenuViewController (){
    UIScrollView *_scrollView;
    UIImageView *_pageView;
    UIButton *_button;
    UITableView *_tableView;
    NSArray *_menuArray;
    UIPageControl *_pageControl;

    int _index;
}

@end

@implementation MenuViewController

- (void)viewDidLoad {

    [super viewDidLoad];

    [self _createSubViews];
    
    [self _createTableView];
    
    
    [self reqestWebData];
}


#pragma mark - 创建scrollView 
- (void)_createSubViews {

    _scrollView = [[UIScrollView alloc] initWithFrame:CGRectMake(0, 64, kScreenWidth, 224 - 70)];
    _scrollView.backgroundColor = [UIColor clearColor];
    _scrollView.pagingEnabled = YES;
    _scrollView.showsHorizontalScrollIndicator = NO;
    _scrollView.showsVerticalScrollIndicator = NO;
    _scrollView.contentSize = CGSizeMake(7*kScreenWidth, 224 - 70);
    [self.view addSubview:_scrollView];
    for (int i = 0; i < 7; i++)
    {

        UIImageView *imageView = [[UIImageView alloc] initWithFrame:CGRectMake(i * kScreenWidth, 0, kScreenWidth, _scrollView.size.height)];
        //拼接图片名
        NSString *imageName = [NSString stringWithFormat:@"guide%d.jpg",i+1];
        UIImage *image = [UIImage imageNamed:imageName];
        imageView.image = image;
        [_scrollView addSubview:imageView];

    }
   
    
    //分页控制器
    _pageControl = [[UIPageControl alloc] initWithFrame:CGRectMake(80, _scrollView.size.height+30, 200, 30)];
    [self.view addSubview:_pageControl];
    //禁用分页控件
    _pageControl.enabled = NO;
    _pageControl.numberOfPages = 7;
    
    //选中的颜色
    _pageControl.currentPageIndicatorTintColor = [UIColor redColor];
    _pageControl.pageIndicatorTintColor = [UIColor whiteColor];
    
    //绑定事件方法
    [_pageControl addTarget:self action:@selector(pageAction:) forControlEvents:UIControlEventValueChanged];
    
    _index = 0;

    [NSTimer scheduledTimerWithTimeInterval:2 target:self selector:@selector(timerAction:) userInfo:nil repeats:YES];

}


- (void)timerAction:(NSTimer *)timer
{
    
    //修改pageControl的currentPage
    _pageControl.currentPage = _index;
    //计算scrollView的偏移量
    CGFloat contentoffsetX = _index * kScreenWidth;
    CGPoint off = CGPointMake(contentoffsetX, 0);
    
    //滚动视图控制偏移量
    [_scrollView setContentOffset:off animated:YES];
    _index++;
    if (_index == 7) {
        _index = 0;
    }
    
}
#pragma mark - 分页控制器的方法
- (void)pageAction:(UIPageControl *)page {
    NSInteger index = page.currentPage;
    
    CGFloat x = index * kScreenWidth;
    
    _scrollView.contentOffset = CGPointMake(x, 0);
}

#pragma mark UIScrollViewDelage
- (void)scrollViewDidEndDecelerating:(UIScrollView *)scrollView {
    
    //计算页数
    NSInteger index = scrollView.contentOffset.x / kScreenWidth;
    
    _pageControl.currentPage = index;
 
}
- (void)jumpToMainViewController:(UIButton *)btn {
    
    if (btn.tag == 0) {
        [self.navigationController pushViewController:[[LeftViewController alloc] init] animated:YES];
    }
    
}
#pragma mark - 请求网络数据
- (void)reqestWebData {
    //构造URL
    NSString *httpUrl = @"http://apis.baidu.com/tngou/cook/classify";
//    NSString *httpUrl = @"http://api.haodou.com/index.php?";
    NSString *httpArg = @"id=0";
    _menuArray = [self request:httpUrl withHttpArg:httpArg];
//    NSLog(@"++++++++++++++++++++++++%@",_menuArray);
    
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
    NSArray *array;
    if(data != nil)
    {
//        NSString *jsonString = [[NSString alloc] initWithData:data encoding:NSUTF8StringEncoding];
//        NSLog(@"%@",jsonString);


        //数据存储
        array = [NSJSONSerialization JSONObjectWithData:data options:NSJSONReadingMutableContainers error:nil];
    }

    return array;
}

#pragma mark - 创建tableView 
- (void)_createTableView {
    _tableView = [[UITableView alloc] initWithFrame:CGRectMake(0, 214+70, kScreenWidth, kScreenHeight - 150-70)];
    _tableView.backgroundColor = [UIColor clearColor];
    _tableView.delegate = self;
    _tableView.dataSource = self;
//    _tableView.backgroundColor = [UIColor clearColor];
    UINib *nib = [UINib nibWithNibName:@"MenuClassCell" bundle:nil];
    [_tableView registerNib:nib forCellReuseIdentifier:@"MenuClassCell"];
    
    [self.view addSubview:_tableView];
    
    
}
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {

    return _menuArray.count;
}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    MenuClassCell *cell = [tableView dequeueReusableCellWithIdentifier:@"MenuClassCell" forIndexPath:indexPath];
    
    NSDictionary *dic = _menuArray[indexPath.row];
    MenuClassModel *classModel = [[MenuClassModel alloc] initWithDataDic:dic];
    cell.backgroundColor = [UIColor clearColor];
    cell.titleLabel.text = classModel.title;
    cell.descriptionLabel.text = @"健康精灵推荐";
    for (int i = 0; i < _menuArray.count; i ++) {
        if (indexPath.row == i) {
            NSString *imageName = [NSString stringWithFormat:@"menu%d.png",i+1];
            UIImage *image = [UIImage imageNamed:imageName];
            cell.classImageName.image = image;
        }
    }
    return cell;
  
}
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    return 64;
}
-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    MenuListViewController *listVC = [[MenuListViewController alloc] init];
    listVC.listID = indexPath.row;
    [self.navigationController pushViewController:listVC animated:YES];
}

- (IBAction)selectBtn:(UIButton *)sender {
    if (sender.tag == 1) {
        [self.navigationController pushViewController:[[MenuListViewController alloc] init] animated:YES];
    }
    else if (sender.tag == 3)
    {
        
        [self.navigationController pushViewController:[[WebViewController alloc] init] animated:YES];
    }

}
@end
