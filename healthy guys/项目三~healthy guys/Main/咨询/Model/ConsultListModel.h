//
//  ConsultListModel.h
//  项目三~healthy guys
//
//  Created by Mac on 15/10/12.
//  Copyright (c) 2015年 Feyddy. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface ConsultListModel : NSObject
@property (nonatomic,copy) NSNumber* listID;
@property (nonatomic,copy) NSString *consultListTitle;//咨询的title
@property (nonatomic,copy) NSString *consultListKeywords;//咨询的keywords
@property (nonatomic,copy) NSString *consultListDescription;//咨询的description
@property (nonatomic,copy) NSString *imageName;//图片的显示
@property (nonatomic,assign) NSNumber *time;



- (instancetype)initWithDictionary:(NSDictionary *)dic;

@end
