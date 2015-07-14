//
//  YNSignInViewController.m
//  2015-07－13
//
//  Created by 路雪魁 on 15/7/13.
//  Copyright (c) 2015年 YN. All rights reserved.
//

#import "YNSignInViewController.h"
#import "YNRegisterViewController.h"


@interface YNSignInViewController ()

@property (strong, nonatomic) UIBarButtonItem *registerBarButtonItem;

@property (strong, nonatomic) UIBarButtonItem *dismissSelfBarButtonItem;

@end

@implementation YNSignInViewController

#pragma mark - life cycle
- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.title = @"账户";
    self.view.backgroundColor = [UIColor whiteColor];
    
    self.navigationItem.rightBarButtonItem = self.registerBarButtonItem;
    self.navigationItem.leftBarButtonItem = self.dismissSelfBarButtonItem;
}

#pragma mark - event response

- (void)registerBarButtonItemHasClicked {
    
    YNRegisterViewController *registerVc = [[YNRegisterViewController alloc] init];
    [self.navigationController pushViewController:registerVc animated:YES];
}

- (void)disMissSelfBarButtonItemHasClicked {
    
    [self dismissViewControllerAnimated:YES completion:^{
        
    }];
}

#pragma mark - setters and getters
- (UIBarButtonItem *)registerBarButtonItem {
    if (_registerBarButtonItem == nil) {
        _registerBarButtonItem = [[UIBarButtonItem alloc] initWithTitle:@"注册" style:UIBarButtonItemStylePlain target:self action:@selector(registerBarButtonItemHasClicked)];
        _registerBarButtonItem.tintColor = [UIColor redColor];
    }
    return _registerBarButtonItem;
}
- (UIBarButtonItem *)dismissSelfBarButtonItem {
    if (_dismissSelfBarButtonItem == nil) {
        _dismissSelfBarButtonItem = [[UIBarButtonItem alloc] initWithImage:[UIImage imageNamed:@"system_back"] style:UIBarButtonItemStylePlain target:self action:@selector(disMissSelfBarButtonItemHasClicked)];
        _dismissSelfBarButtonItem.tintColor = [UIColor redColor];
    }
    return _dismissSelfBarButtonItem;
}

@end
