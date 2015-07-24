//
//  YNLocation.h
//  2015-07－13
//
//  Created by 农盟 on 15/7/24.
//  Copyright (c) 2015年 YN. All rights reserved.
//

#import <Foundation/Foundation.h>

@protocol YNLocationDelegate <NSObject>

- (void)cityName:(NSString *)cityName;

@end

@interface YNLocation : NSObject

- (void)startLocate;

@end
