//
//  YNBaseModel.h
//  2015-07－13
//
//  Created by 农盟 on 15/7/27.
//  Copyright (c) 2015年 YN. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface YNBaseModel : NSObject
@property (nonatomic, assign) NSInteger ID;
@property (nonatomic, copy) NSString *name;
@property (nonatomic, assign, getter=isSelected) BOOL selected;

- (instancetype)initWithDictionary:(NSDictionary *)dict;
+ (instancetype)baseModelWithDictionary:(NSDictionary *)dict;

@end
