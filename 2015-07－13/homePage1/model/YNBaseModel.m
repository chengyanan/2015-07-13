//
//  YNBaseModel.m
//  2015-07－13
//
//  Created by 农盟 on 15/7/27.
//  Copyright (c) 2015年 YN. All rights reserved.
//

#import "YNBaseModel.h"

@implementation YNBaseModel
- (instancetype)initWithDictionary:(NSDictionary *)dict {
    self = [super init];
    if (self) {
        
        self.ID = [dict[@"id"] integerValue];
        self.name = dict[@"name"];
    }
    return self;
}

+ (instancetype)baseModelWithDictionary:(NSDictionary *)dict {
    
    return [[self alloc] initWithDictionary:dict];
}

@end
