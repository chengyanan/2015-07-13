//
//  YNNavigationController.m
//  2015-07－13
//
//  Created by 路雪魁 on 15/7/13.
//  Copyright (c) 2015年 YN. All rights reserved.
//

#import "YNNavigationController.h"

@interface YNNavigationController ()

@end

@implementation YNNavigationController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    UIColor *titleClolr = [UIColor redColor];
    
    self.navigationBar.titleTextAttributes = @{NSForegroundColorAttributeName : titleClolr};
}




@end
