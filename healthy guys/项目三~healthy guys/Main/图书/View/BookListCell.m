//
//  BookListCell.m
//  项目三~healthy guys
//
//  Created by Mac on 15/10/9.
//  Copyright (c) 2015年 Feyddy. All rights reserved.
//

#import "BookListCell.h"
#import "UIImageView+WebCache.h"
#import "Common.h"
#import "UILabel+MarkupExtensions.h"

@implementation BookListCell

-(void)setBookListModel:(BookListModel *)bookListModel
{
    _bookListModel = bookListModel;
    _bookNameLabel.text = [NSString stringWithFormat:@"书名:%@",_bookListModel.bookName];
    _bookAuthorLabel.text = [NSString stringWithFormat:@"作者:%@",_bookListModel.bookAuthor];
    _bookSummaryLabel.text = [NSString stringWithFormat:@"<b>%@",_bookListModel.bookSummary];
    
    
    [_bookSummaryLabel setMarkup:_bookSummaryLabel.text];
//    NSString *str = _bookListModel.bookSummary;
//    
//    CGSize maxSize = CGSizeMake(kScreenWidth , CGFLOAT_MAX);
//    
//    NSDictionary *attributes = @{NSFontAttributeName:[UIFont systemFontOfSize:13]};
//    
//    CGRect rect = [str boundingRectWithSize:maxSize options:NSStringDrawingUsesLineFragmentOrigin attributes:attributes context:nil];
//    //NSLog(@"%f",rect.size.height);
////    return rect.size.height + 300;
////    _bookSummaryLabel.frame = CGRectMake(0, 0, kScreenWidth, rect.size.height + 700);
//    self.frame = CGRectMake(0, 0, kScreenWidth, rect.size.height + 700);
    
    
    
    
    NSString *timeStr = [_bookListModel.time stringValue];
    timeStr = [timeStr substringToIndex:10];
    NSDate *convertDate = [NSDate dateWithTimeIntervalSince1970:[timeStr integerValue]];
    
    //创建日期格式
    NSDateFormatter *formatter = [[NSDateFormatter alloc] init];
    [formatter setDateFormat:@"yyyy/MM/dd"];

    NSString *string = [formatter stringFromDate:convertDate];
    //NSLog(@"&*******  %@",string);
    _timeLabel.text = [NSString stringWithFormat:@"更新时间:%@",
                       string];
    
    NSString *imageString = [NSString stringWithFormat:@"http://tnfs.tngou.net/image%@",_bookListModel.image];
    //NSLog(@"%@",imageString);
    NSURL *imageUrl = [NSURL URLWithString:imageString];
    
    [_bookImageView sd_setImageWithURL:imageUrl];
    
    
}


- (void)awakeFromNib {
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
