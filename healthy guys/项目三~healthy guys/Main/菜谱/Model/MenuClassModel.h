//
//  MenuClassModel.h
//  项目三_Healthyguns
//
//  Created by mac on 15/10/19.
//  Copyright (c) 2015年 Janie. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "BaseModel.h"

/**
 *
 {
 cookclass = 0;
 description = "\U7f8e\U5bb9";
 id = 1;
 keywords = "\U7f8e\U5bb9";
 name = "\U7f8e\U5bb9";
 seq = 0;
 title = "\U7f8e\U5bb9";
 },
 
 */

@interface MenuClassModel : BaseModel
@property(nonatomic,copy) NSString *title;
@property(nonatomic,copy) NSString *menuDescription;
-(id)initWithContentsOfDictionary:(NSDictionary *)dictionary;
+(id)MenuClassifyWithContentsOfDictionary:(NSDictionary *)dictionary;




@end
