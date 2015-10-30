//
//  MenuShowModel.m
//  项目三_Healthyguns
//
//  Created by mac on 15/10/20.
//  Copyright (c) 2015年 Janie. All rights reserved.
//

#import "MenuShowModel.h"

@implementation MenuShowModel
-(id)initWithContentsOfDictionary:(NSDictionary *)dictionary
{
    self = [super init];
    if(self)
    {
        _imageName = dictionary[@"img"];
        _showDescription = dictionary[@"description"];
        _message = dictionary[@"message"];
    }
    return self;
}
+(id)MenuShowWithContentsOfDictionary:(NSDictionary *)dictionary
{
    return [[MenuShowModel alloc] initWithContentsOfDictionary:dictionary];
}

@end
