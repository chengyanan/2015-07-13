//
//  YNRegisterViewController.h
//  2015-07－13
//
//  Created by 路雪魁 on 15/7/13.
//  Copyright (c) 2015年 YN. All rights reserved.
//

#import <UIKit/UIKit.h>

@protocol YNRegisterViewControllerDelagate <NSObject>

@optional
- (void)regiserSuccessWithUserName:(NSString *)userName password:(NSString *)password;

@end

@interface YNRegisterViewController : UIViewController

@property (assign, nonatomic)  id <YNRegisterViewControllerDelagate> delegate;

@end
