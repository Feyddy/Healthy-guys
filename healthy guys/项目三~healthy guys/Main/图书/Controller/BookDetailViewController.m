//
//  BookDetailViewController.m
//  项目三~healthy guys
//
//  Created by Mac on 15/10/9.
//  Copyright (c) 2015年 Feyddy. All rights reserved.
//

#import "BookDetailViewController.h"
#import "BookDetailCell.h"
#import "BookDetailModel.h"
#import "UIImageView+WebCache.h"
#import "Common.h"

@interface BookDetailViewController ()<UITableViewDataSource,UITableViewDelegate>
{
    UITableView *_bookDetailTableView;
    NSArray *_bookListArray;
    UIView *_headView;
    UIImageView *_topImageView;
    UILabel *_author;
    UILabel *_bookList;
}

@end

@implementation BookDetailViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.title = @"详情";
    
    [self _createTableView];
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
    
    
    NSString *imageString = [NSString stringWithFormat:@"http://tnfs.tngou.net/image%@",_imageArray[_indexRow]];
    NSURL *imageUrl = [NSURL URLWithString:imageString];
    [_topImageView sd_setImageWithURL:imageUrl];

}


#pragma mark - UITableViewDataSource
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return self.array.count;
}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *identifier = @"cell";
    
    BookDetailCell *cell = [tableView dequeueReusableCellWithIdentifier:identifier];
     
    if (cell == nil)
    {
        cell = [[[NSBundle mainBundle]loadNibNamed:@"BookDetailCell" owner:nil options:nil]lastObject];
    }
    
    cell.model = self.array[indexPath.row];

    cell.backgroundColor = [UIColor clearColor];
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    return cell;
}

-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    BookDetailModel *book = self.array[indexPath.row];
    if (book.isShow) {
     NSString *string = book.message;
     
     CGSize maxSize = CGSizeMake(kScreenWidth , CGFLOAT_MAX);
     
     NSDictionary *attributes = @{NSFontAttributeName:[UIFont systemFontOfSize:13]};

    CGRect rect = [string boundingRectWithSize:maxSize options:NSStringDrawingUsesLineFragmentOrigin attributes:attributes context:nil];
     return rect.size.height + 300;
    }
    return 200;
    
}

//-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
//{
//    return 1;
//}
//
//-(CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section
//{
//    return 40.0;
//}


//单元格选中事件
-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    BookDetailModel *detailModel = _array[indexPath.row];
    detailModel.isShow = ! detailModel.isShow;
    
    //刷新单元格
    [tableView reloadRowsAtIndexPaths:@[indexPath] withRowAnimation:UITableViewRowAnimationFade];
}
//-(UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section{
//    
//    UIButton *btn = [UIButton buttonWithType:UIButtonTypeCustom];
//    
//    //设置属性
//    //    btn.frame:默认是充满整个section
//    //[btn setBackgroundImage:[UIImage imageNamed:@"tableCell_common"] forState:UIControlStateNormal];
//    
//    //设置高亮状态下的背景图片
//    //[btn setBackgroundImage:[UIImage imageNamed:@"tableCell_common_tapped"] forState:UIControlStateHighlighted];
//
//    //
//    
//    //设置标题
//    [btn setTitle:title forState:UIControlStateNormal];
//    [btn setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
//    [btn setTitleColor:[UIColor whiteColor] forState:UIControlStateHighlighted];
//    
//    btn.tag = section + 100;
//    
//    //添加方法
//    [btn addTarget:self
//            action:@selector(btnAction:) forControlEvents:UIControlEventTouchUpInside];
//    
//    return btn;
//    
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
