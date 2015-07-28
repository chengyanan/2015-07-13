//
//  YNLevelModel.m
//  2015-07－13
//
//  Created by 农盟 on 15/7/27.
//  Copyright (c) 2015年 YN. All rights reserved.
//

#import "YNLevelModel.h"
#import "YNSecondLevelModel.h"
#import "YNElementModel.h"

@implementation YNLevelModel

- (instancetype)initWithDictionary:(NSDictionary *)dict {
    self = [super initWithDictionary:dict];
    
    if (self) {
        
        if ([dict objectForKey:@"firstDataArray"]) {
            
            NSArray *array = [NSArray arrayWithArray:dict[@"firstDataArray"]];
            
            NSMutableArray *tempArray = [NSMutableArray array];
            
            for (int i = 0; i<array.count; i++) {
                YNSecondLevelModel *model = [[YNSecondLevelModel alloc] initWithDictionary:array[i]];
                model.second = i;
                
                [tempArray addObject:model];
            }
            
            
            self.array = [NSArray arrayWithArray:tempArray];
        }
        
    }
    
    return self;
}

- (void)setFirstIndex:(NSInteger)firstIndex {
    if (_firstIndex != firstIndex) {
        _firstIndex = firstIndex;
        
        for (YNSecondLevelModel *model in self.array) {
            for (YNElementModel *elementModel in model.array) {
                
                elementModel.first = firstIndex;
            }
            
        }
    }

}

@end
