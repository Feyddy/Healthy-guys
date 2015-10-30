//
//  MenuListModel.h
//  项目三_Healthyguns
//
//  Created by mac on 15/10/20.
//  Copyright (c) 2015年 Janie. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface MenuListModel : NSObject
//http://tnfs.tngou.net/image图片前缀，需要拼
@property(nonatomic,copy) NSString *imageName;
@property(nonatomic,copy) NSString *name;
@property(nonatomic,copy) NSString *keywords;
@property(nonatomic,copy) NSString *food;
-(id)initWithContentsOfDictionary:(NSDictionary *)dictionary;
+(id)MenuListWithContentsOfDictionary:(NSDictionary *)dictionary;
@end
