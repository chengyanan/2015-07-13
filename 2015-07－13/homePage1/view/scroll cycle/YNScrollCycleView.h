//
//  YNScrollCycleView.h
//  2015-07－13
//
//  Created by 农盟 on 15/7/23.
//  Copyright (c) 2015年 YN. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface YNScrollCycleView : UIView

@property (nonatomic, strong) NSArray *tempArray;

- (void)pauseTimer;
- (void)startTimer;

@end
