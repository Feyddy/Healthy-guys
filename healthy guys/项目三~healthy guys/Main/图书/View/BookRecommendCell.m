//
//  BookRecommendCell.m
//  项目三~healthy guys
//
//  Created by Mac on 15/10/26.
//  Copyright (c) 2015年 Feyddy. All rights reserved.
//

#import "BookRecommendCell.h"
#import "UIImageView+WebCache.h"
#import "UILabel+MarkupExtensions.h"

@implementation BookRecommendCell




-(void)setModel:(BookRecommendModel *)model
{
    _model = model;
    _bookRecommendName.text = _model.bookName;
    _bookRecommendAuthor.text = _model.bookAuthor;
    
    _bookRecommendSummary.text = [NSString stringWithFormat:@"<b>%@",_model.bookSummary];
    
    
    [_bookRecommendSummary setMarkup:_bookRecommendSummary.text];
    
    NSString *timeStr = [_model.time stringValue];
    timeStr = [timeStr substringToIndex:10];
    NSDate *convertDate = [NSDate dateWithTimeIntervalSince1970:[timeStr integerValue]];
    
    //创建日期格式
    NSDateFormatter *formatter = [[NSDateFormatter alloc] init];
    [formatter setDateFormat:@"yyyy/MM/dd"];
    
    NSString *string = [formatter stringFromDate:convertDate];
    //NSLog(@"&*******  %@",string);
    _bookRecommendTime.text = [NSString stringWithFormat:@"更新时间:%@",
                       string];
    
    NSString *imageString = [NSString stringWithFormat:@"http://tnfs.tngou.net/image%@",_model.image];
    //NSLog(@"%@",imageString);
    NSURL *imageUrl = [NSURL URLWithString:imageString];
    
    [_bookRecommendImageView sd_setImageWithURL:imageUrl];

    
}







- (void)awakeFromNib {
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
