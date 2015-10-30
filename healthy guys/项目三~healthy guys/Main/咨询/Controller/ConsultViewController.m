//
//  ConsultViewController.m
//  项目三~healthy guys
//
//  Created by Mac on 15/10/9.
//  Copyright (c) 2015年 Feyddy. All rights reserved.
//

#import "ConsultViewController.h"
#import "ConsultCell.h"
#import "ConsultListViewController.h"
#import "ConsultModel.h"
#import "ConsultListModel.h"
#import "Common.h"
#import "Image.h"
#import "ThemeButton.h"
#import "UIViewController+MMDrawerController.h"
#import "MMDrawerController.h"

@interface ConsultViewController ()<UITableViewDataSource,UITableViewDelegate,UIScrollViewDelegate>
{
    UITableView *_consultTableView;
    NSMutableArray *_allDicArray;
    NSArray *_array;
    UIScrollView *_scrollView;
    UIPageControl *_pageCtrl;
    NSInteger _index;
}

@end

@implementation ConsultViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    //创建表视图
    [self _createTableView];
    [self _createView];
    
    NSString *httpUrl = @"http://apis.baidu.com/tngou/info/classify";
    NSString *httpArg = @"";
//    [self request: httpUrl withHttpArg: httpArg];
    [self request:httpUrl withHttpArg:httpArg];
    
}
-(void)setAction
{
    MMDrawerController *mmDraw = self.mm_drawerController;
    [mmDraw openDrawerSide:MMDrawerSideLeft animated:YES completion:nil];
}

#pragma mark - 创建视图
- (void)_createView{
    //添加头视图
    UIView *view = [[UIView alloc] initWithFrame:CGRectMake(0, 0, kScreenWidth, 200)];
    view.backgroundColor = [UIColor clearColor];
    _consultTableView.tableHeaderView = view;
    
    //创建scrollView
    _scrollView = [[UIScrollView alloc]initWithFrame:self.view.bounds];
    _scrollView.contentSize = CGSizeMake(kScreenWidth * 5, 200);
    
    //设置最大放大倍数
    //    _scrollView.maximumZoomScale = 2;
    _scrollView.tag = 1000;
    
    //设置代理
    _scrollView.delegate = self;
    
    //分页效果
    _scrollView.pagingEnabled = YES;
    
    //隐藏水平方向的滚动条
    _scrollView.showsHorizontalScrollIndicator = NO;
    [view addSubview:_scrollView];
    
    NSArray *array = @[@"中国土壤污染治理刻不容缓，上海攻克“土中抓取重金属”难题",
                       @"三季度空气质量最差10城河北占7席，济南、郑州、成都上榜",
                       @"全国已有4家住院医师培训专业基地被撤，14家被限期整改",
                       @"塑胶跑道鉴定之难：生产和施工复杂，仅原料合格并不说明问题",
                       @"上海用市区好学校托管农村学校已惠及12万人，弱校基本消失"
                       ];
    NSArray *imageName = @[@"header1",@"header2",@"header3",@"header4",@"header5"];
    
    for (int i = 0; i < 5; i++) {
        //循环创建视图添加到scrollView上
        UIImageView *imageView = [[UIImageView alloc] initWithFrame:CGRectMake(i * kScreenWidth , 0, kScreenWidth, 200)];
        imageView.image = [UIImage imageNamed:[NSString stringWithFormat:@"%@%@",imageName[i],@".png"]];
        imageView.image = [Image watermarkImage:imageView.image text:array[i]];
        imageView.tag = 100 + i;
        
        [_scrollView addSubview:imageView];
        
    }
    
    //创建PageControl
    _pageCtrl = [[UIPageControl alloc] initWithFrame:CGRectMake(0, view.bounds.size.height - 30, kScreenWidth, 30)];
    
    //常用的属性
    _pageCtrl.numberOfPages = 5;
    _pageCtrl.currentPage = 0;
    _pageCtrl.currentPageIndicatorTintColor = [UIColor redColor];
    _pageCtrl.pageIndicatorTintColor = [UIColor greenColor];
    [_pageCtrl addTarget:self
                  action:@selector(pageCon:)
        forControlEvents:UIControlEventValueChanged];
    [view addSubview:_pageCtrl];
    
    _index = 0;
    
    [NSTimer scheduledTimerWithTimeInterval:2 target:self selector:@selector(timerAction:) userInfo:nil repeats:YES];

    
}
- (void)timerAction:(NSTimer *)timer
{
    
    //修改pageControl的currentPage
    _pageCtrl.currentPage = _index;
    //计算scrollView的偏移量
    CGFloat contentoffsetX = _index * kScreenWidth;
    CGPoint off = CGPointMake(contentoffsetX, 0);
    
    //滚动视图控制偏移量
    [_scrollView setContentOffset:off animated:YES];
     _index++;
    if (_index == 5) {
        _index = 0;
    }
    
}
#pragma mark - pageControl切换图片
-(void)pageCon:(UIPageControl *)sender{
    //点击pageControl时，scrollView切换到对应图片
    NSInteger index = sender.currentPage;
    
    //计算scrollView的偏移量
    CGFloat contentoffsetX = index * kScreenWidth;
    
    CGPoint off = CGPointMake(contentoffsetX, 0);
    
    //滚动视图控制偏移量
    [_scrollView setContentOffset:off animated:YES];
    
}

#pragma mark - 结束减速
- (void)scrollViewDidEndDecelerating:(UIScrollView *)scrollView{
    
    //获取最终的偏移量
    CGFloat offX = scrollView.contentOffset.x;
    //计算当前的页数
    NSInteger index =  offX / kScreenWidth;
    //修改pageControl的currentPage
    _pageCtrl.currentPage = index;
}

-(void)request: (NSString*)httpUrl withHttpArg: (NSString*)HttpArg  {
//    [self showHUD:@"Loading..."];
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
    
    _allDicArray = [[NSMutableArray alloc] init];
    //    6.获取响应数据信息
    if (data != nil)
    {
        
//        NSString *jsonString = [[NSString alloc] initWithData:data encoding:NSUTF8StringEncoding];

        //NSLog(@"%@",jsonString);

        //JSON解析
        _array = [NSJSONSerialization JSONObjectWithData:data options:NSJSONReadingMutableContainers error:nil];
        
        int idd = 0;
        NSMutableArray *oderArray = [NSMutableArray array];
        
        while (idd <8)
        {
            for (NSDictionary *dic in _array)
            {
               if ([dic[@"id"] integerValue] == idd)
              {
                [oderArray addObject:dic];
              }
            }
            idd++;
        }
        for (NSDictionary *dic in oderArray) {
            ConsultModel *consult = [[ConsultModel alloc] initWithDictionary:dic];
            [_allDicArray addObject:consult];
        }
    }
}

#pragma mark - 创建表视图
-(void)_createTableView
{
    _consultTableView = [[UITableView alloc] initWithFrame:self.view.bounds];
    _consultTableView.backgroundColor = [UIColor clearColor];
    [self.view addSubview:_consultTableView];
    
    _consultTableView.delegate = self;
    _consultTableView.dataSource = self;
    
}


#pragma mark - UITableViewDataSource
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return _array.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *identifier = @"cell";
    
    ConsultCell *cell = [tableView dequeueReusableCellWithIdentifier:identifier];
    
    if (cell == nil)
    {
        cell = [[[NSBundle mainBundle]loadNibNamed:@"ConsultCell" owner:nil options:nil]lastObject];
        cell.backgroundColor = [UIColor clearColor];
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
    }

    cell.consultModel = _allDicArray[indexPath.row];

    //辅助图标
    cell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
    return cell;

}

-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 150;
}

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    
    ConsultListViewController *consultListC=[[ConsultListViewController alloc] init];

    consultListC.indexPathRow = (NSInteger)indexPath.row +1;
    
    [self.navigationController pushViewController:consultListC animated:YES];
}




- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}



@end
