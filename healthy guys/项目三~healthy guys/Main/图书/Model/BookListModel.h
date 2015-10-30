//
//  BookListModel.h
//  项目三~healthy guys
//
//  Created by Mac on 15/10/14.
//  Copyright (c) 2015年 Feyddy. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface BookListModel : NSObject

@property (nonatomic,copy) NSNumber* listID;
@property (nonatomic,copy) NSString *bookName;//书名
@property (nonatomic,copy) NSString *bookAuthor;//作者
@property (nonatomic,copy) NSString *bookSummary;//书的简介

@property (nonatomic,copy) NSString *image;//图片的显示
@property (nonatomic,assign) NSNumber *time;//发布时间

- (instancetype)initWithDictionary:(NSDictionary *)dic;

@end
