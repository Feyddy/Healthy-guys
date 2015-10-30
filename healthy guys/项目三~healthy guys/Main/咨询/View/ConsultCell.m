//
//  ConsultCell.m
//  项目三-Healthy guys
//
//  Created by Mac on 15/10/8.
//  Copyright (c) 2015年 Feyddy. All rights reserved.
//

#import "ConsultCell.h"

@implementation ConsultCell

- (void)awakeFromNib {
    // Initialization code

}
-(void)setConsultModel:(ConsultModel *)consultModel
{
    _consultModel = consultModel;
    _titleName.text = _consultModel.titleName;
    _descriptionLabel.text = _consultModel.descriptionName;
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
