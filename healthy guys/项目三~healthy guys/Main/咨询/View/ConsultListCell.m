//
//  ConsultListCell.m
//  项目三-Healthy guys
//
//  Created by Mac on 15/10/8.
//  Copyright (c) 2015年 Feyddy. All rights reserved.
//

#import "ConsultListCell.h"
#import "UIImageView+WebCache.h"
//http://tnfs.tngou.net/image

@implementation ConsultListCell





-(void)setConsultListModel:(ConsultListModel *)consultListModel
{
    _consultListModel = consultListModel;
    _consultListTitleLabel.text = _consultListModel.consultListTitle;
    
    
    NSString *timeStr = [_consultListModel.time stringValue];
    timeStr = [timeStr substringToIndex:10];
    NSDate *convertDate = [NSDate dateWithTimeIntervalSince1970:[timeStr integerValue]];
    
    //创建日期格式
    NSDateFormatter *formatter = [[NSDateFormatter alloc] init];
    [formatter setDateFormat:@"yyyy/MM/dd mm"];
    
    NSString *string = [formatter stringFromDate:convertDate];
    //NSLog(@"&*******  %@",string);
    _consultListKeywordsLabel.text = [NSString stringWithFormat:@"健康精灵报道 时间:%@分钟前",
                       string];
    
    
//    _consultListKeywordsLabel.text = _consultListModel.time;
    _consultListDescriptionLabel.text = _consultListModel.consultListKeywords;
    
    
    NSString *imageString = [NSString stringWithFormat:@"http://tnfs.tngou.net/image%@",_consultListModel.imageName];
    //NSLog(@"%@",imageString);
    NSURL *imageUrl = [NSURL URLWithString:imageString];
    _consultListImageView.contentMode = UIViewContentModeScaleAspectFit;

    [_consultListImageView sd_setImageWithURL:imageUrl];
    
}

- (void)awakeFromNib {
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
