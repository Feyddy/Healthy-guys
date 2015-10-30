//
//  BookDetailCell.m
//  项目三~healthy guys
//
//  Created by Mac on 15/10/9.
//  Copyright (c) 2015年 Feyddy. All rights reserved.
//

#import "BookDetailCell.h"
#import "UILabel+MarkupExtensions.h"

@implementation BookDetailCell

- (void)awakeFromNib {
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}



-(void)setModel:(BookDetailModel *)model
{
    _model = model;
    _bookTitle.text = model.title;
    _bookTitle.font = [UIFont systemFontOfSize:17];
    _bookMessage.text = model.message;
    _bookMessage.numberOfLines = 0;
    _bookMessage.font = [UIFont systemFontOfSize:13];
    [_bookMessage setMarkup:_bookMessage.text];
    
}

@end
