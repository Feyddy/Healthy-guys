//
//  ListDetailViewController.m
//  项目三~healthy guys
//
//  Created by Mac on 15/10/23.
//  Copyright (c) 2015年 Feyddy. All rights reserved.
//

#import "ListDetailViewController.h"
#import "Common.h"
#import "UIImageView+WebCache.h"


@interface ListDetailViewController ()

@end

@implementation ListDetailViewController
- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.title = @"企业详情";
    
    _model = _array[_indexRow];
    [self _createViews];
}

- (void)_createViews
{
    //创建标题栏
    UILabel *titleLabel = [[UILabel alloc] initWithFrame:CGRectMake(0, 70, kScreenWidth, 90)];
    titleLabel.backgroundColor = [UIColor clearColor];
    titleLabel.text = _model.consultListTitle;
    titleLabel.numberOfLines = 0;
    titleLabel.font = [UIFont systemFontOfSize:20];
    [self.view addSubview:titleLabel];
    
    //创建新闻报道者
    UILabel *responderLabel = [[UILabel alloc] initWithFrame:CGRectMake(0, 160, kScreenWidth, 20)];
    responderLabel.text = @"健康精灵";
    [self.view addSubview:responderLabel];
    
    //创建时间
    UILabel *timeLabel = [[UILabel alloc] initWithFrame:CGRectMake(0, 180, kScreenWidth, 20)];
    timeLabel.backgroundColor = [UIColor clearColor];
    
    
    NSString *timeStr = [_model.time stringValue];
    timeStr = [timeStr substringToIndex:10];
    NSDate *convertDate = [NSDate dateWithTimeIntervalSince1970:[timeStr integerValue]];

    //创建日期格式
    NSDateFormatter *formatter = [[NSDateFormatter alloc] init];
    [formatter setDateFormat:@"yyyy/MM/dd HH:mm"];

    NSString *string = [formatter stringFromDate:convertDate];
    timeLabel.text = [NSString stringWithFormat:@"健康精灵报道 时间:%@",string];
    [self.view addSubview:timeLabel];
    
    //创建头部图片
    UIImageView *headerImageView = [[UIImageView alloc] initWithFrame:CGRectMake(0,200,kScreenWidth,130)];
    headerImageView.backgroundColor = [UIColor clearColor];
    
    NSString *imageString = [NSString stringWithFormat:@"http://tnfs.tngou.net/image%@",_model.imageName];
    NSURL *imageUrl = [NSURL URLWithString:imageString];
    headerImageView.contentMode = UIViewContentModeScaleAspectFit;
    
    [headerImageView sd_setImageWithURL:imageUrl];
    
    [self.view addSubview:headerImageView];
    
    //创建description标签
    UILabel *descriptionLabel = [[UILabel alloc] initWithFrame:CGRectMake(0, 330, kScreenWidth, kScreenHeight-330)];
    descriptionLabel.backgroundColor = [UIColor clearColor];
    descriptionLabel.numberOfLines = 0;
    descriptionLabel.text = _model.consultListDescription;
    [self.view addSubview:descriptionLabel];
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
