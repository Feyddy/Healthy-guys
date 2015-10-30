//
//  PersonTableViewController.m
//  项目三_Healthyguns
//
//  Created by mac on 15/10/16.
//  Copyright (c) 2015年 Janie. All rights reserved.
//

#import "PersonTableViewController.h"
#import "LogInViewController.h"
#import "MMDrawerController.h"
#import "MMDrawerVisualState.h"
#import "UIViewController+MMDrawerController.h"
#import "ThemeTableViewController.h"
@interface PersonTableViewController ()<UIAlertViewDelegate>

@end

@implementation PersonTableViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
}
- (void)viewWillAppear:(BOOL)animated {
    _cacheLabel.text = [NSString stringWithFormat:@"%.2fMB",[self countCacheFileSize]];

}
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - Table view data source
/*
//- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
//#warning Potentially incomplete method implementation.
//    // Return the number of sections.
//    return 1;
//}
//
//- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
//#warning Incomplete method implementation.
//    // Return the number of rows in the section.
//    return 5;
//}
 */
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (indexPath.row == 0) {
        
        MMDrawerController *mmDraw = self.mm_drawerController;
        [mmDraw openDrawerSide:MMDrawerSideLeft animated:YES completion:nil];
        
    }else if (indexPath.row == 1) {
       
        //登陆界面
        [self.navigationController pushViewController:[[LoginViewController alloc] init] animated:YES];

    }else if (indexPath.row == 2){
        //弹出一个提示框
        UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"警告" message:@"是否清理缓存" delegate:self cancelButtonTitle:@"否" otherButtonTitles:@"是", nil];
        [alert show];
    }
    
}

-(void)alertView:(UIAlertView *)alertView clickedButtonAtIndex:(NSInteger)buttonIndex
{
    NSLog(@"buttonIndex = %li",buttonIndex);
    if(buttonIndex == 1)
    {
        //清除缓存
        NSString *homePath = NSHomeDirectory();
        NSLog(@"homePath = %@",homePath);
        [self clearCacheFile];
        
    }
}
#pragma mark - 计算当前缓存文件大小
/**
 *  计算当前应用程序缓存文件的大小之和
 *
 *  @return 文件大小
 */
-(CGFloat)countCacheFileSize
{
    //1.获取缓存文件夹的路径
    //函数 用于获取当前程序的沙盒文件
    NSString *homePath = NSHomeDirectory();
    NSLog(@"%@",homePath);
    /*1)子文件夹1 视频缓存/tmp/MediaCache/
     2)子文件夹2 SDWebImage框架的缓存图片 /Library/Caches/com.hackemist.SDWebImageCache.default/
     3)子文件夹3/Library/Caches/com.Janie.----Healthyguns/
     */
    //2.使用-(CGFloat)getFileSize:(NSString *)filePath 来计算这些文件夹中文件的大小
    NSArray *pathArray = @[@"/tmp/MediaCache/",
                           @"/Library/Caches/com.hackemist.SDWebImageCache.default/",
                           @"/Library/Caches/com.Janie.----Healthyguns/"];
    //文件大小之和
    CGFloat fileSize = 0;
    for(NSString *string in pathArray)
    {
        //拼接路径
        NSString *filePath = [NSString stringWithFormat:@"%@%@",homePath,string];
        fileSize += [self getFileSize:filePath];
    }
    //3.对上一步计算结果进行求和 并返回
    return fileSize;
}
/**
 *  根据传入的路径 计算此路径下的文件大小
 *
 *  @param filePath 文件路径
 *
 *  @return 此文件夹下所有文件的总大小  单位MB
 */

-(CGFloat)getFileSize:(NSString *)filePath
{
    //文件管理器对象 单例
    NSFileManager *manager = [NSFileManager defaultManager];
    //数组 储存文件夹中所有的子文件夹以及文件的名字
    NSArray *fileNames = [manager subpathsOfDirectoryAtPath:filePath error:nil];
    //遍历文件夹
    long long size = 0;
    for(NSString *fileName in fileNames)
    {
        //拼接获取文件路径
        NSString *subFilePath = [NSString stringWithFormat:@"%@%@",filePath,fileName];
        //获取文件信息
        NSDictionary *dic = [manager attributesOfItemAtPath:subFilePath error:nil];
        NSLog(@"%@",dic);
        //获取单个文件大小
        NSNumber *sizeNumber = dic[NSFileSize];
        //使用一个long long类型来储存文件大小
        long long subFileSize = [sizeNumber longLongValue];
        //文件大小求和
        size += subFileSize;
        
    }
    return size/1024.0/1024;
    
}
#pragma mark - 清理缓存
-(void)clearCacheFile
{
    
    //    _cacheLabel.text = @"清理中...";
    //1.获取缓存文件路径
    NSString *homePath = NSHomeDirectory();
    //2.删除文件
    
    NSArray *pathArray = @[@"/tmp/MediaCache/",
                           @"/Library/Caches/com.hackemist.SDWebImageCache.default/",
                           @"/Library/Caches/com.Janie.----Healthyguns/"];
    
    for(NSString *string in pathArray)
    {
        //拼接路径
        NSString *filePath = [NSString stringWithFormat:@"%@%@",homePath,string];
        //文件管理
        NSFileManager *manager = [NSFileManager defaultManager];
        //获取自文件中的文件名
        NSArray *fileNames = [manager subpathsOfDirectoryAtPath:filePath error:nil];
        //遍历文件夹 删除文件
        for(NSString *fileName in fileNames)
        {
            //拼接子文件路径
            NSString *subFilePath = [NSString stringWithFormat:@"%@%@",filePath,fileName];
            //删除文件
            [manager removeItemAtPath:subFilePath error:nil];
        }
        
    }
    //重新计算缓存文件大小
    //将计算完成结果显示到label上
    _cacheLabel.text = [NSString stringWithFormat:@"%.2fMB",[self countCacheFileSize]];
    
    
}


/*
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:<#@"reuseIdentifier"#> forIndexPath:indexPath];
    
    // Configure the cell...
    
    return cell;
}
*/

/*
// Override to support conditional editing of the table view.
- (BOOL)tableView:(UITableView *)tableView canEditRowAtIndexPath:(NSIndexPath *)indexPath {
    // Return NO if you do not want the specified item to be editable.
    return YES;
}
*/

/*
// Override to support editing the table view.
- (void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath {
    if (editingStyle == UITableViewCellEditingStyleDelete) {
        // Delete the row from the data source
        [tableView deleteRowsAtIndexPaths:@[indexPath] withRowAnimation:UITableViewRowAnimationFade];
    } else if (editingStyle == UITableViewCellEditingStyleInsert) {
        // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
    }   
}
*/

/*
// Override to support rearranging the table view.
- (void)tableView:(UITableView *)tableView moveRowAtIndexPath:(NSIndexPath *)fromIndexPath toIndexPath:(NSIndexPath *)toIndexPath {
}
*/

/*
// Override to support conditional rearranging of the table view.
- (BOOL)tableView:(UITableView *)tableView canMoveRowAtIndexPath:(NSIndexPath *)indexPath {
    // Return NO if you do not want the item to be re-orderable.
    return YES;
}
*/

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
