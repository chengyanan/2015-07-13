//
//  YNMineViewController.m
//  2015-07－13
//
//  Created by 路雪魁 on 15/7/13.
//  Copyright (c) 2015年 YN. All rights reserved.
//

#import "YNMineViewController.h"

@interface YNMineViewController ()
@property (strong, nonatomic) UIBarButtonItem *signInBarButtonItem;
@end

@implementation YNMineViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.view.backgroundColor = [UIColor blueColor];
    
    self.navigationItem.rightBarButtonItem = self.signInBarButtonItem;
}

- (void)signInItemHasClicked {
    
    NSLog(@"signIn button has clicked!");
}

- (UIBarButtonItem *)signInBarButtonItem {
    
    if (_signInBarButtonItem == nil) {
        
        _signInBarButtonItem = [[UIBarButtonItem alloc] initWithTitle:@"登录" style:UIBarButtonItemStylePlain target:self action:@selector(signInItemHasClicked)];
    }
    
    return _signInBarButtonItem;
}

@end
