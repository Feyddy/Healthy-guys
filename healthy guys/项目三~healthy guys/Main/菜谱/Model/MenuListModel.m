//
//  MenuListModel.m
//  项目三_Healthyguns
//
//  Created by mac on 15/10/20.
//  Copyright (c) 2015年 Janie. All rights reserved.
//

#import "MenuListModel.h"

@implementation MenuListModel
-(id)initWithContentsOfDictionary:(NSDictionary *)dictionary
{
    self = [super init];
    if(self)
    {
        _food = dictionary[@"food"];
        _keywords = dictionary[@"keywords"];
        _name = dictionary[@"name"];
        _imageName = dictionary[@"img"];
    }
    return self;
}
+(id)MenuListWithContentsOfDictionary:(NSDictionary *)dictionary
{
    return [[MenuListModel alloc] initWithContentsOfDictionary:dictionary];
}
@end
