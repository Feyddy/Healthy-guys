//
//  BookDetailModel.h
//  项目三~healthy guys
//
//  Created by Mac on 15/10/22.
//  Copyright (c) 2015年 Feyddy. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface BookDetailModel : NSObject

@property (nonatomic,copy) NSString *author;
@property (nonatomic,copy) NSString *image;
@property (nonatomic,copy) NSString *message;
@property (nonatomic,copy) NSString *title;

@property (nonatomic,assign) BOOL isShow;
@end
