//
//  YNRootTabBarController.m
//  2015-07－13
//
//  Created by 路雪魁 on 15/7/13.
//  Copyright (c) 2015年 YN. All rights reserved.
//

#import "YNRootTabBarController.h"
#import "YNNavigationController.h"
#import "YNHomePageViewController.h"
#import "YNServiceViewController.h"
#import "YNMineViewController.h"
#import "YNMoreViewController.h"

@interface YNRootTabBarController ()

@end

@implementation YNRootTabBarController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.tabBar.tintColor = MainStyleClolr;
    
    YNHomePageViewController *homePageVc = [[YNHomePageViewController alloc] init];
    YNServiceViewController *serviceVc = [[YNServiceViewController alloc] init];
    YNMineViewController *mineVc = [[YNMineViewController alloc] init];
    YNMoreViewController *moreVc = [[YNMoreViewController alloc] init];
    
    YNNavigationController *homePageNav = [[YNNavigationController alloc] initWithRootViewController:homePageVc];
    YNNavigationController *serviceNav = [[YNNavigationController alloc] initWithRootViewController:serviceVc];
    YNNavigationController *mineNav = [[YNNavigationController alloc] initWithRootViewController:mineVc];
    YNNavigationController *moreNav = [[YNNavigationController alloc] initWithRootViewController:moreVc];
    
    self.viewControllers = @[homePageNav, serviceNav, mineNav, moreNav];
    
    homePageVc.title = @"马上吃";
    serviceVc.title = @"服务";
    mineVc.title = @"我的";
    moreVc.title = @"更多";
    
    homePageNav.tabBarItem.image = [UIImage imageNamed:@"tabBar_homePage_off"];
    serviceNav.tabBarItem.image = [UIImage imageNamed:@"tabBar_service_off"];
    mineNav.tabBarItem.image = [UIImage imageNamed:@"tabBar_mine_off"];
    moreNav.tabBarItem.image = [UIImage imageNamed:@"tabBar_more_off"];
    
}



@end
