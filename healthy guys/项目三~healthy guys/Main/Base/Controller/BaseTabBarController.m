//
//  BaseTabBarController.m
//  FeyddyWeiBo
//
//  Created by Mac on 15/10/8.
//  Copyright (c) 2015年 Feyddy. All rights reserved.
//

#import "BaseTabBarController.h"
#import "BaseNavigationController.h"
#import "Common.h"
#import "ThemeImageView.h"
#import "ThemeButton.h"
#import "LeftViewController.h"
#import "MMDrawerController.h"
#import "UIViewController+MMDrawerController.h"

@interface BaseTabBarController ()
@end

@implementation BaseTabBarController

- (void)viewDidLoad {
    [super viewDidLoad];
    //Warnning:下面两个的调用顺序不能改变
    
    //1.加载子视图控制器
    [self _createSubControllers];
    
    //2.设置Tabbar
//    [self _setTabBar];
    [self.tabBar setHidden:YES];
}

#pragma mark - 加载子视图控制器
- (void)_createSubControllers
{
    NSArray *names = @[@"ConsultViewController",@"BookViewController",@"Menu",@"Person"];
    NSMutableArray *navArray = [NSMutableArray array];
    
    //循环加载子视图控制器
    for (int i = 0; i < names.count; i++) {
        //通过storyBoard来加载子视图控制器的方法
        UIStoryboard *storyBoard = [UIStoryboard storyboardWithName:names[i] bundle:nil];
        
        BaseNavigationController *navigationC = [storyBoard instantiateInitialViewController];
        
        [navArray addObject:navigationC];
    }
    self.viewControllers = navArray;

}

//#pragma mark - 设置Tabbar
//- (void)_setTabBar
//{
////    //01移除TabBar上面的UITabBarButton子视图
////    for (UIView *view in self.tabBar.subviews) {
////        //UITabBarButton这个类是内部封装的，无法直接使用，但是可以查找到对应的类
////        Class class = NSClassFromString(@"UITabBarButton");
////        if ([view isKindOfClass:class]) {
////            [view removeFromSuperview];
////        }
////    }
////    
////    //02设置TabBar背景图片
////    ThemeImageView *bgImageView = [[ThemeImageView alloc] initWithFrame:CGRectMake(0, 0,kScreenWidth , 49)];
//////    bgImageView.image = [UIImage imageNamed:@"tab_bg_all"];
////    
////    bgImageView.imageName = @"mask_navbar.png";
////    [self.tabBar addSubview:bgImageView];
//    
//    //03选中图片
//    CGFloat width = kScreenHeight / 4;
//    _selectedImageView = [[ThemeImageView alloc] initWithFrame:CGRectMake(0, 0, width, 49)];
////    _selectedImageView.image = [UIImage imageNamed:@"selectTabbar_bg_all"];
//    _selectedImageView.imageName = @"home_bottom_tab_arrow.png";
//    [self.tabBar addSubview:_selectedImageView];
//    
//    //04创建TabBar按钮
//    NSArray *names = @[@"home_tab_icon_1.png",
//                       @"home_tab_icon_2.png",
//                       @"home_tab_icon_3.png",
//                       @"home_tab_icon_4.png",
//                       ];
//    _leftV = [[LeftViewController alloc] init];
//    
//
//    
//
//    //循环创建标签栏上面的按钮
//    for (int i = 0; i < names.count; i++) {
//        ThemeButton *button = [[ThemeButton alloc] initWithFrame:CGRectMake(0, i * width, width, 49)];
////        [button setImage:[UIImage imageNamed:names[i]] forState:UIControlStateNormal];
//    
//        button.normalImageName = names[i];
//
//        button.tag = i;
//        [button addTarget:self action:@selector(selectedAction:) forControlEvents:UIControlEventTouchUpInside];
//        [_leftV.view addSubview:button];
//    }
//}
//
//#pragma mark - TabBar按钮方法
////-(void)selectedAction:(UIButton *)button
////{
////    
////    [UIView animateWithDuration:0.3 animations:^{
////        _selectedImageView.center = button.center;
////    }];
////    MMDrawerController *mmDraw = _leftV.mm_drawerController;
////
////    BaseTabBarController *baseT = [[BaseTabBarController alloc] init];
////    baseT = (BaseTabBarController *)mmDraw.centerViewController;
////    
////    baseT.selectedIndex = button.tag;
////    
////    
//////    mmDraw.centerViewController.tabBarController.selectedIndex = button.tag;
//////    NSLog(@"%@",mmDraw.centerViewController.);
////    //selectedIndex属性用来，点击对应的按钮显示对应的视图
//////    self.selectedIndex = button.tag;
////    
////}



- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


@end
