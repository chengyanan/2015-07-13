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
#import "YNNearbyViewController.h"
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
    YNNearbyViewController *nearbyVc = [[YNNearbyViewController alloc] init];
    
//    YNNearbyBaiduViewController *nearbyVc = [[YNNearbyBaiduViewController alloc] init];
    
    YNMineViewController *mineVc = [[YNMineViewController alloc] init];
    YNMoreViewController *moreVc = [[YNMoreViewController alloc] init];
    
    YNNavigationController *homePageNav = [[YNNavigationController alloc] initWithRootViewController:homePageVc];
    YNNavigationController *serviceNav = [[YNNavigationController alloc] initWithRootViewController:serviceVc];
    
    YNNavigationController *nearbyNav = [[YNNavigationController alloc] initWithRootViewController:nearbyVc];
    
    YNNavigationController *mineNav = [[YNNavigationController alloc] initWithRootViewController:mineVc];
    YNNavigationController *moreNav = [[YNNavigationController alloc] initWithRootViewController:moreVc];
    
    self.viewControllers = @[homePageNav, serviceNav, nearbyNav, mineNav, moreNav];
    
    homePageVc.title = @"首页";
    serviceVc.title = @"活动";
    nearbyVc.title = @"我附近的热门商家";
    mineVc.title = @"圈子";
    moreVc.title = @"我";
    
    homePageNav.tabBarItem.image = [UIImage imageNamed:@"tabBar_homePage_off"];
    homePageNav.tabBarItem.title = @"首页";
    
    serviceNav.tabBarItem.image = [UIImage imageNamed:@"tabBar_service_off"];
    serviceNav.tabBarItem.title =  @"活动";
    
    nearbyNav.tabBarItem.image = [UIImage imageNamed:@"tarBar_nearby_off"];
    nearbyNav.tabBarItem.title = @"附近";
    
    mineNav.tabBarItem.image = [UIImage imageNamed:@"tabBar_mine_off"];
    mineNav.tabBarItem.title = @"圈子";
    
    moreNav.tabBarItem.image = [UIImage imageNamed:@"tabBar_more_off"];
    moreNav.tabBarItem.title = @"我";
    
}

@end
