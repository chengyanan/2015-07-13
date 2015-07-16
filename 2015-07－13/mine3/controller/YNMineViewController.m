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
#define USERID [[NSUserDefaults standardUserDefaults] objectForKey:@"USERID"]

@interface YNMineViewController ()
@property (strong, nonatomic) UIBarButtonItem *signInBarButtonItem;
@end

@implementation YNMineViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.view.backgroundColor = [UIColor blueColor];
    self.navigationItem.rightBarButtonItem = self.signInBarButtonItem;
    
}

- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    
    if (USERID) {
        self.signInBarButtonItem.title = @"注销";
    } else {
        self.signInBarButtonItem.title = @"登录";
    }
}

- (void)signInItemHasClicked {
    
    if ([self.signInBarButtonItem.title isEqualToString:@"登录"]) {
        
        YNSignInViewController *signInVc = [[YNSignInViewController alloc] init];
        
        YNNavigationController *navVc = [[YNNavigationController alloc] initWithRootViewController:signInVc];
        
        [self presentViewController:navVc animated:YES completion:^{
            
        }];
        
    } else if ([self.signInBarButtonItem.title isEqualToString:@"注销"]){
        
        
        [[NSUserDefaults standardUserDefaults] removeObjectForKey:@"USERID"];
        self.signInBarButtonItem.title = @"登录";
    }
    
}

- (UIBarButtonItem *)signInBarButtonItem {
    
    if (_signInBarButtonItem == nil) {
        
        _signInBarButtonItem = [[UIBarButtonItem alloc] initWithTitle:@"" style:UIBarButtonItemStylePlain target:self action:@selector(signInItemHasClicked)];
        
        _signInBarButtonItem.tintColor = MainStyleClolr;
    }
    
    return _signInBarButtonItem;
}

@end
