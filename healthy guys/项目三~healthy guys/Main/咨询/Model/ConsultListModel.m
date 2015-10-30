//
//  ConsultListModel.m
//  项目三~healthy guys
//
//  Created by Mac on 15/10/12.
//  Copyright (c) 2015年 Feyddy. All rights reserved.
//

#import "ConsultListModel.h"

@implementation ConsultListModel



- (instancetype)initWithDictionary:(NSDictionary *)dic
{
    self = [super init];
    if (self) {
        _consultListTitle = dic[@"title"];
        _consultListDescription = dic[@"description"];
        _consultListKeywords = dic[@"keywords"];
        _imageName = dic[@"img"];
        _time = dic[@"time"];
        
    }
    return self;
}

@end
