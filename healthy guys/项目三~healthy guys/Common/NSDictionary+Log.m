//
//  NSDictionary+Log.m
//  QZoneLogin
//
//  Created by wei.chen on 14-9-9.
//  Copyright (c) 2014年 www.iphonetrain.com 无限互联3G学院. All rights reserved.
//

#import "NSDictionary+Log.h"

@implementation NSDictionary (Log)
//解决array,dictionary无法打印中文的情况
//通过类目（NSdictionary+Log)的形式复写dictionary的descriptionWithLocale方法，把key和value进行拼接。
- (NSString *)descriptionWithLocale:(id)locale {
    
    NSMutableString *log = [NSMutableString stringWithFormat:@"{\n"];
    for (NSString *key in self) {
        NSString *value = self[key];
        
        [log appendFormat:@"    %@=%@; \n",key,value];
    }
    
    [log appendFormat:@"}"];
    
    return log;
}

@end
