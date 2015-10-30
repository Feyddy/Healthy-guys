//
//  ConsultDetailViewController.m
//  项目三~healthy guys
//
//  Created by Mac on 15/10/9.
//  Copyright (c) 2015年 Feyddy. All rights reserved.
//

#import "ConsultDetailViewController.h"
#import "Common.h"
#import "ThemeButton.h"
#import "UIImageView+WebCache.h"
//#import "NMCustomLabel.h"
#import "UILabel+MarkupExtensions.h"


@interface ConsultDetailViewController ()<UITableViewDelegate>
{
    UITableView *_consultTableView;
    
    NSMutableArray *_allDicArray;
    NSArray *_array;
    
    //创建题目label
    UILabel *_titleLabel;
    
    //创建图片视图
    UIImageView *_imageView;
    //创建关键词label
    UILabel *_keyWordsLabel;
    //创建简介label
    UILabel *_describtionLabel;
    //创建时间label
    UILabel *_timeLabel;
    //创建正文label
    UILabel *_messageLabel;
    
    UIScrollView *_scrollView;
    //正文label高度
    CGRect _rect;
    
    
}

@end

@implementation ConsultDetailViewController

- (void)viewDidLoad {
    [super viewDidLoad];

    
    ThemeButton *leftButton = [[ThemeButton alloc] initWithFrame:CGRectMake(80, 0, 100, 40)];
    leftButton.bgNormalImageName = @"button_title.png";
    leftButton.normalImageName = @"group_btn_all_on_title.png";
    [leftButton setTitle:@"返回" forState:UIControlStateNormal];
    [leftButton addTarget:self action:@selector(backAction) forControlEvents:UIControlEventTouchUpInside];
    //转换成UIBarButtonItem
    UIBarButtonItem *left = [[UIBarButtonItem alloc] initWithCustomView:leftButton];
    self.navigationItem.leftBarButtonItem = left;
    
    //创建子视图
    [self _createView];

    NSString *httpUrl = @"http://apis.baidu.com/tngou/info/show";
    NSString *httpArg = [NSString stringWithFormat:@"id=%ld",_indexPathRow];
    [self request: httpUrl withHttpArg: httpArg];

}



#pragma mark - 创建子视图
-(void)_createView
{
    _scrollView = [[UIScrollView alloc] initWithFrame:CGRectMake(0, 325, kScreenWidth, kScreenHeight - 360)];
    [self.view addSubview:_scrollView];
    
    
    UIView *view = [[UIView alloc] initWithFrame:CGRectMake(0, 0, kScreenWidth, 64)];
    view.backgroundColor = [UIColor clearColor];
    view.layer.borderColor = [[UIColor lightGrayColor]CGColor];
    view.layer.borderWidth = 1;
    [self.view addSubview:view];
    
    UILabel *titleLabel = [[UILabel alloc] initWithFrame:CGRectMake(kScreenWidth/2-50, 25, 100, 30)];
    titleLabel.text = @"新闻详情";
    titleLabel.textColor = [UIColor whiteColor];
    titleLabel.textAlignment = NSTextAlignmentCenter;
    [view addSubview:titleLabel];
    
    UIButton *button = [[UIButton alloc] initWithFrame:CGRectMake(10, 25, 50, 30)];
    [button setTitle:@"返回" forState:UIControlStateNormal];
    [button setTintColor:[UIColor blueColor]];
    [button addTarget:self action:@selector(backAction) forControlEvents:UIControlEventTouchUpInside];
    [view addSubview:button];
    
    //创建题目label
    _titleLabel = [[UILabel alloc] initWithFrame:CGRectMake(5, 65, kScreenWidth-10, 60)];
    _titleLabel.textAlignment = NSTextAlignmentCenter;
    _titleLabel.numberOfLines = 0;
    [self.view addSubview:_titleLabel];
    
    
    
    //创建图片视图
    _imageView = [[UIImageView alloc] initWithFrame:CGRectMake(40, 125, kScreenWidth-80, 100)];
    _imageView.contentMode = UIViewContentModeScaleAspectFit;
    [self.view addSubview:_imageView];
    
    //创建时间label
    _timeLabel = [[UILabel alloc] initWithFrame:CGRectMake(5, 225, kScreenWidth-10, 20)];
    _timeLabel.textAlignment = NSTextAlignmentCenter;
    _timeLabel.font = [UIFont systemFontOfSize:12];
    _timeLabel.backgroundColor = [UIColor clearColor];
    _timeLabel.text = @"asdiubw";
    [self.view addSubview:_timeLabel];
    
    
    //创建关键词label
    _keyWordsLabel = [[UILabel alloc] initWithFrame:CGRectMake(40, 245, kScreenWidth-80, 20)];
    _keyWordsLabel.font = [UIFont systemFontOfSize:12];
    _keyWordsLabel.backgroundColor = [UIColor clearColor];
    _keyWordsLabel.textAlignment = NSTextAlignmentCenter;
    [self.view addSubview:_keyWordsLabel];
    
    //创建简介label
    _describtionLabel = [[UILabel alloc] initWithFrame:CGRectMake(40, 265, kScreenWidth-80, 60)];
    _describtionLabel.font = [UIFont systemFontOfSize:10];
    _describtionLabel.numberOfLines = 0;
    _describtionLabel.backgroundColor = [UIColor clearColor];
    [self.view addSubview:_describtionLabel];

    //创建正文标题
    _messageLabel = [[UILabel alloc] init];
    _messageLabel.font = [UIFont systemFontOfSize:13];
    _messageLabel.numberOfLines = 0;
    _messageLabel.backgroundColor = [UIColor clearColor];
    [_scrollView addSubview:_messageLabel];
    
}


#pragma mark - buttonAction
-(void)backAction
{
    [self dismissViewControllerAnimated:YES completion:nil];
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
    
    _allDicArray = [[NSMutableArray alloc] init];
    //    6.获取响应数据信息
    if (data != nil)
    {
//        NSString *jsonString = [[NSString alloc] initWithData:data encoding:NSUTF8StringEncoding];
//        
//        NSLog(@"%@",jsonString);
        //JSON解析
        NSDictionary *diction = [NSJSONSerialization JSONObjectWithData:data options:NSJSONReadingMutableContainers error:nil];
        
//        for (id key in diction) {
            _titleLabel.text = diction[@"title"];
            _describtionLabel.text = diction[@"description"];
            _keyWordsLabel.text = diction[@"keywords"];

        NSString *timeStr = [diction[@"time"] stringValue];
        timeStr = [timeStr substringToIndex:10];
        NSDate *convertDate = [NSDate dateWithTimeIntervalSince1970:[timeStr integerValue]];
        
        //创建日期格式
        NSDateFormatter *formatter = [[NSDateFormatter alloc] init];
        [formatter setDateFormat:@"yyyy/MM/dd"];
        NSString *string = [formatter stringFromDate:convertDate];
            _timeLabel.text = string;
        NSString *imageString = [NSString stringWithFormat:@"http://tnfs.tngou.net/image%@",diction[@"img"]];
        NSURL *imageUrl = [NSURL URLWithString:imageString];
        [_imageView sd_setImageWithURL:imageUrl];
        
        //正文html文本解析
        _messageLabel.text = diction[@"message"];
        [_messageLabel setMarkup:_messageLabel.text];
    
        //messageLabel高度计算
        NSString *str = diction[@"message"];
        // 根据字符串的长度 计算Label的大小
        CGSize maxSize = CGSizeMake(kScreenWidth - 26, CGFLOAT_MAX);
        NSDictionary *attributes = @{NSFontAttributeName : [UIFont systemFontOfSize:17]};
        
        _rect = [str boundingRectWithSize:maxSize options:NSStringDrawingUsesLineFragmentOrigin attributes:attributes context:nil];

//        }
        CGFloat height = _rect.size.height - _rect.size.height/2.8;
        
        if (_rect.size.height < 500) {
            _messageLabel.frame = CGRectMake(5, 0, kScreenWidth-10, _rect.size.height);
            _scrollView.contentSize = CGSizeMake(kScreenWidth, _rect.size.height);
        }else{
            _messageLabel.frame = CGRectMake(5, 0, kScreenWidth-10, height);
            _scrollView.contentSize = CGSizeMake(kScreenWidth, height);
        }
    }
    //[self completeHUD:@"complete..."];
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
