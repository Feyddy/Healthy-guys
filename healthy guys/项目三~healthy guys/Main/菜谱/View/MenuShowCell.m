//
//  MenuShowCell.m
//  Healthy Guys
//
//  Created by CandyDear on 15/10/15.
//  Copyright (c) 2015年 mac04. All rights reserved.
//

#import "MenuShowCell.h"
#import "UIImageView+WebCache.h"
#import "UILabel+MarkupExtensions.h"
@implementation MenuShowCell

- (void)awakeFromNib {
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}
-(void)setShowModel:(MenuShowModel *)showModel
{
    if(_showModel != showModel)
    {
        _showModel = showModel;
        _foodDescriptionLabel.text = _showModel.showDescription;
        _messageLabel.text = _showModel.message;
        
        if([_messageLabel.text rangeOfString:@"</h2>"].location != NSNotFound || [_messageLabel.text rangeOfString:@"<h2>"].location != NSNotFound)
        {
            //如果有,则删除
            NSLog(@"you");
            _messageLabel.text = [_messageLabel.text stringByReplacingOccurrencesOfString:@"</h2>" withString:@" "];
            _messageLabel.text = [_messageLabel.text stringByReplacingOccurrencesOfString:@"<h2>" withString:@" "];
            [_messageLabel setMarkup:_messageLabel.text];
            
        }
        else
        {
            //html文本解析
            [_messageLabel setMarkup:_messageLabel.text];
        }

//        UILabel *label = [[UILabel alloc] initWithFrame:self.bounds];
//        label.text = _showModel.message;
//        [label setMarkup:label.text];
//        [_messageView addSubview:label];


        
        //设置图片http://tnfs.tngou.net/image
        NSString *urlString = [NSString stringWithFormat:@"http://tnfs.tngou.net/image/%@",_showModel.imageName];
        [_headImageView sd_setImageWithURL:[NSURL URLWithString:urlString]];
    }
}
@end
