//
//  MenuShowModel.h
//  项目三_Healthyguns
//
//  Created by mac on 15/10/20.
//  Copyright (c) 2015年 Janie. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface MenuShowModel : NSObject
@property(nonatomic,copy) NSString *imageName;
@property(nonatomic,copy) NSString *showDescription;
@property(nonatomic,copy) NSString *message;
//@property(nonatomic,assign) BOOL isShow;//显示菜信息
-(id)initWithContentsOfDictionary:(NSDictionary *)dictionary;
+(id)MenuShowWithContentsOfDictionary:(NSDictionary *)dictionary;
@end
