//
//  ConsultModel.h
//  项目三~healthy guys
//
//  Created by Mac on 15/10/12.
//  Copyright (c) 2015年 Feyddy. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface ConsultModel : NSObject
@property (nonatomic,copy) NSString *titleName;//咨询的类型
@property (nonatomic,copy) NSString *descriptionName;//咨询的描述
@property (nonatomic,copy) NSNumber *ConsultID;//咨询类型的ID

- (instancetype)initWithDictionary:(NSDictionary *)dic;

@end
