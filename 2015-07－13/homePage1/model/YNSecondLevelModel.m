//
//  YNSecondLevelModel.m
//  2015-07－13
//
//  Created by 农盟 on 15/7/27.
//  Copyright (c) 2015年 YN. All rights reserved.
//

#import "YNSecondLevelModel.h"
#import "YNElementModel.h"

@implementation YNSecondLevelModel

- (instancetype)initWithDictionary:(NSDictionary *)dict {
    self = [super initWithDictionary:dict];
    if (self) {
        
        if ([dict objectForKey:@"secondDataArray"]) {
            
            NSArray *array = dict[@"secondDataArray"];
            
            NSMutableArray *tempArray = [NSMutableArray array];
            
            for (int i = 0; i< array.count; i++) {
                YNElementModel *model = [YNElementModel baseModelWithDictionary:array[i]];
                model.third = i;
                
                [tempArray addObject:model];
            }
            
            self.array = [NSArray arrayWithArray:tempArray];
            
        }
       
    }
    return self;
}

- (void)setSecond:(NSInteger)second {
    if (_second != second) {
        _second = second;
        
        for (YNElementModel *model in self.array) {
            model.second = second;
        }
    }
}

@end
