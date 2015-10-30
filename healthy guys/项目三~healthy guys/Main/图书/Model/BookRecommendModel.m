//
//  BookRecommendModel.m
//  项目三~healthy guys
//
//  Created by Mac on 15/10/26.
//  Copyright (c) 2015年 Feyddy. All rights reserved.
//

#import "BookRecommendModel.h"

@implementation BookRecommendModel

- (instancetype)initWithDictionary:(NSDictionary *)dic
{
    self = [super init];
    if (self) {
        _bookName = dic[@"name"];
        _bookAuthor = dic[@"author"];
        _bookSummary = dic[@"summary"];
        _image = dic[@"img"];
        _time = dic[@"time"];
        
    }
    return self;
}

@end
