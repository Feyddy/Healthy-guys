//
//  MenuClassModel.m
//  项目三_Healthyguns
//
//  Created by mac on 15/10/19.
//  Copyright (c) 2015年 Janie. All rights reserved.
//

#import "MenuClassModel.h"

@implementation MenuClassModel
-(id)initWithContentsOfDictionary:(NSDictionary *)dictionary
{
    self = [super init];
    if(self)
    {
        _title = dictionary[@"title"];
        _menuDescription = dictionary[@"description"];
    }
    return self;
}
+(id)MenuClassifyWithContentsOfDictionary:(NSDictionary *)dictionary
{
    return [[MenuClassModel alloc] initWithContentsOfDictionary:dictionary];
}


@end
