//
//  BookModel.m
//  项目三~healthy guys
//
//  Created by Mac on 15/10/13.
//  Copyright (c) 2015年 Feyddy. All rights reserved.
//

#import "BookModel.h"

@implementation BookModel
- (instancetype)initWithDictionary:(NSDictionary *)dic
{
    self = [super init];
    if (self) {
        _name = dic[@"name"];
        _descriptionName = dic[@"description"];
        _ConsultID = dic[@"id"];
        
    }
    return self;
}
@end
