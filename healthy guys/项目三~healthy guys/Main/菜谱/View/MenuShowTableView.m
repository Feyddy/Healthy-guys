//
//  MenuShowTableView.m
//  Healthy Guys
//
//  Created by CandyDear on 15/10/15.
//  Copyright (c) 2015年 mac04. All rights reserved.
//

#import "MenuShowTableView.h"
#import "MenuShowCell.h"
#import "MenuShowModel.h"
#import "UIImageView+WebCache.h"
#import "Common.h"
@implementation MenuShowTableView

-(instancetype)initWithFrame:(CGRect)frame style:(UITableViewStyle)style
{
    self = [super initWithFrame:frame style:style];
    if(self)
    {
        self.dataSource = self;
        self.delegate = self;
        UINib *nib = [UINib nibWithNibName:@"MenuShowCell" bundle:nil];
        [self registerNib:nib forCellReuseIdentifier:@"MenuShowCell"];
    }
    return self;
}
-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return _showArray.count;
}
-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    MenuShowCell *cell = [tableView dequeueReusableCellWithIdentifier:@"MenuShowCell" forIndexPath:indexPath];
    NSDictionary *dic = _showArray[indexPath.row];
        MenuShowModel *model = [MenuShowModel MenuShowWithContentsOfDictionary:dic];
    cell.showModel = model;
    cell.backgroundColor = [UIColor clearColor];
//    cell.foodDescriptionLabel.text = _model.showDescription;
//    cell.foodMessageLabel.text = _model.message;
  
//    //设置图片http://tnfs.tngou.net/image
//    NSString *urlString = [NSString stringWithFormat:@"http://tnfs.tngou.net/image/%@",_model.imageName];
//    [cell.headImageView sd_setImageWithURL:[NSURL URLWithString:urlString]];
    return cell;
}
-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    //获取当前菜信息
    NSDictionary *dic = _showArray[indexPath.row];
    MenuShowModel *model = [MenuShowModel MenuShowWithContentsOfDictionary:dic];
//    if(model.isShow)
//    {
        NSString *message = model.message;
        CGSize maxSize = CGSizeMake(kScreenWidth - 20, CGFLOAT_MAX);
        NSDictionary *attributes = @{
                                     NSFontAttributeName : [UIFont systemFontOfSize:15]
                                     };
        CGRect rect = [message boundingRectWithSize:maxSize options:NSStringDrawingUsesLineFragmentOrigin attributes:attributes context:nil];
        return rect.size.height + 300;
//    }
//    else
//    {
//        return 80;
//    }
    
}
//-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
//{
//    //改变这条信息的显示状态
//    NSDictionary *dic = _showArray[indexPath.row];
//    MenuShowModel *model = [MenuShowModel MenuShowWithContentsOfDictionary:dic];
//    //NSLog(@"model : %@",model);
//    
//    model.isShow = !model.isShow;
//    //刷新单元格
//    [tableView reloadRowsAtIndexPaths:@[indexPath] withRowAnimation:UITableViewRowAnimationFade];
//}

@end
