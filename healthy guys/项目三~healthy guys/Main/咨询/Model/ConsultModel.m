//
//  ConsultModel.m
//  项目三~healthy guys
//
//  Created by Mac on 15/10/12.
//  Copyright (c) 2015年 Feyddy. All rights reserved.
//

#import "ConsultModel.h"

@implementation ConsultModel


- (instancetype)initWithDictionary:(NSDictionary *)dic
{
    self = [super init];
    if (self) {
        _titleName = dic[@"title"];
        _descriptionName = dic[@"description"];
        _ConsultID = dic[@"id"];

    }
    return self;
}


@end
