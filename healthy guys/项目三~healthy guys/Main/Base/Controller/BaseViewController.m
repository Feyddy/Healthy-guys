//
//  BaseViewController.m
//  FeyddyWeiBo
//
//  Created by Mac on 15/10/8.
//  Copyright (c) 2015年 Feyddy. All rights reserved.
//

#import "BaseViewController.h"
#import "ThemeManager.h"
#import "ThemeButton.h"
#import "UIViewController+MMDrawerController.h"
#import "MMDrawerController.h"
#import "MBProgressHUD.h"
#import "Common.h"

@interface BaseViewController ()
{
    MBProgressHUD *_hud;
    UILabel *_titleLabel;
}

@end

@implementation BaseViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    [self _loadImage];
//    [self setNavItem];
}
-(void)dealloc
{
    [[NSNotificationCenter defaultCenter] removeObserver:self];
}

-(instancetype)initWithCoder:(NSCoder *)aDecoder
{
    self = [super initWithCoder:aDecoder];
    if (self) {
        [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(themeDidChange:) name:kThemeDidChangeNotification object:nil];
    }
    return self;
}

- (void)themeDidChange:(NSNotification *)notification
{
    [self _loadImage];
}

-(void)_loadImage
{
    ThemeManager *manager = [ThemeManager shareInstance];
    UIImage *image = [manager getThemeImage:@"bg_home.jpg"];
    
    [self.view setBackgroundColor:[UIColor colorWithPatternImage:image]];
    
}

-(void)setNavItem
{
    //    self.navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc] initWithTitle:@"编辑" style:UIBarButtonItemStylePlain target:self action:@selector(editAction)];
//    ThemeButton *leftButton = [[ThemeButton alloc] initWithFrame:CGRectMake(80, 0, 60, 40)];
//    leftButton.bgNormalImageName = @"button_title.png";
//    leftButton.normalImageName = @"group_btn_all_on_title.png";
////    [leftButton setTitle:@"设置" forState:UIControlStateNormal];
//    [leftButton addTarget:self action:@selector(setAction) forControlEvents:UIControlEventTouchUpInside];
//    //转换成UIBarButtonItem
//    UIBarButtonItem *left = [[UIBarButtonItem alloc] initWithCustomView:leftButton];
//    self.navigationItem.leftBarButtonItem = left;
//
    
    //button_icon_plus.png   button图片
    //    button_m.png  button背景图片
    
//    ThemeButton *rightButton = [[ThemeButton alloc] initWithFrame:CGRectMake(0, 0, 110, 40)];
//    rightButton.bgNormalImageName = @"button_m.png";
//    rightButton.normalImageName = @"button_icon_plus.png";
//    [rightButton setTitle:@"更多" forState:UIControlStateNormal];
//    [rightButton addTarget:self action:@selector(editAction) forControlEvents:UIControlEventTouchUpInside];
//    //转换成UIBarButtonItem
//    UIBarButtonItem *right = [[UIBarButtonItem alloc] initWithCustomView:rightButton];
//    self.navigationItem.rightBarButtonItem = right;
    //
    //    self.navigationItem.leftBarButtonItem = [[UIBarButtonItem alloc] initWithTitle:@"设置" style:UIBarButtonItemStylePlain target:self action:@selector(setAction)];
}

//-(void)editAction
//{
//    MMDrawerController *mmDraw = self.mm_drawerController;
//    [mmDraw openDrawerSide:MMDrawerSideRight animated:YES completion:nil];
//}

-(void)setAction
{
    MMDrawerController *mmDraw = self.mm_drawerController;
    [mmDraw openDrawerSide:MMDrawerSideLeft animated:YES completion:nil];
}

-(void)showHUD:(NSString *)title
{
    _hud = [MBProgressHUD showHUDAddedTo:self.view animated:YES];
    [_hud show:YES];
    _hud.labelText = title;
    _hud.dimBackground = YES;
}

-(void)completeHUD:(NSString *)title
{
    _hud.customView = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"37x-Checkmark.png"]];
    _hud.mode = MBProgressHUDModeCustomView;
    _hud.labelText = title;
    [_hud hide:YES afterDelay:1.5];
}


#pragma mark - 网络请求方法
//-(NSArray *)request: (NSString*)httpUrl withHttpArg: (NSString*)HttpArg
//{
//    NSString *urlStr = [[NSString alloc]initWithFormat: @"%@?%@",httpUrl, HttpArg];
//    NSURL *url = [NSURL URLWithString: urlStr];
//    NSMutableURLRequest *request = [[NSMutableURLRequest alloc]initWithURL: url cachePolicy: NSURLRequestUseProtocolCachePolicy timeoutInterval: 10];
//    [request setHTTPMethod: @"GET"];
//    [request addValue: kApikey forHTTPHeaderField: @"apikey"];
//    NSURLResponse *response = nil;
//    NSError *error = nil;
//    NSData *data = [NSURLConnection sendSynchronousRequest:request returningResponse:&response error:&error];
//    //NSLog(@"data = %@",data);
//    //5.获取相应的头信息
//    NSHTTPURLResponse *httpResponse = (NSHTTPURLResponse *)response;
//    //获取状态码
//    NSInteger statusCode = httpResponse.statusCode;
//    NSLog(@"statusCode = %li",statusCode);
//    //响应头
//    //NSLog(@"响应头:%@",httpResponse.allHeaderFields);
//    //获取响应数据信息
//    if(data != nil)
//    {
//        //NSString *jsonString = [[NSString alloc] initWithData:data encoding:NSUTF8StringEncoding];
//        //NSLog(@"%@",jsonString);
//        
//        
//    }
//    //数据存储
//    NSArray *array = [NSJSONSerialization JSONObjectWithData:data options:NSJSONReadingMutableContainers error:nil];
//    return array;
//}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    [self setNavItem];
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
