//
//  YNMineViewController.m
//  2015-07－13
//
//  Created by 路雪魁 on 15/7/13.
//  Copyright (c) 2015年 YN. All rights reserved.
//

#import "YNMineViewController.h"
#import "YNNavigationController.h"
#import "YNSignInViewController.h"

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
    
    YNSignInViewController *signInVc = [[YNSignInViewController alloc] init];
    
    YNNavigationController *navVc = [[YNNavigationController alloc] initWithRootViewController:signInVc];
    
    [self presentViewController:navVc animated:YES completion:^{
        
    }];
    
}

- (UIBarButtonItem *)signInBarButtonItem {
    
    if (_signInBarButtonItem == nil) {
        
        _signInBarButtonItem = [[UIBarButtonItem alloc] initWithTitle:@"登录" style:UIBarButtonItemStylePlain target:self action:@selector(signInItemHasClicked)];
        _signInBarButtonItem.tintColor = [UIColor redColor];
    }
    
    return _signInBarButtonItem;
}

@end
