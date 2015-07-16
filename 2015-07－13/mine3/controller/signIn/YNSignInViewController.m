//
//  YNSignInViewController.m
//  2015-07－13
//
//  Created by 路雪魁 on 15/7/13.
//  Copyright (c) 2015年 YN. All rights reserved.
//

#import "YNSignInViewController.h"
#import "YNRegisterViewController.h"
#import "UITextField+LeftAndRightView.h"
#import <Masonry.h>
#import <MBProgressHUD.h>

#define Margin 15
#define TextFileHeight 44
#define VerticalSpace 3

#define USERARRAY [[NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES) lastObject] stringByAppendingPathComponent:@"userArray.db"]

@interface YNSignInViewController ()<YNRegisterViewControllerDelagate>

@property (strong, nonatomic) UIBarButtonItem *registerBarButtonItem;

@property (strong, nonatomic) UIBarButtonItem *dismissSelfBarButtonItem;

@property (strong, nonatomic) UITextField *userName;
@property (strong, nonatomic) UITextField *password;

@property (strong, nonatomic) UIButton *LoginButton;

@property (assign, nonatomic) BOOL isRegister;

@end

@implementation YNSignInViewController

#pragma mark - life cycle
- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.title = @"账户";
    self.view.backgroundColor = [UIColor whiteColor];
     self.view.backgroundColor = [UIColor colorWithRed:243/255.0 green:240/255.0 blue:236/255.0 alpha:1.0];
    
    self.navigationItem.rightBarButtonItem = self.registerBarButtonItem;
    self.navigationItem.leftBarButtonItem = self.dismissSelfBarButtonItem;
    
    [self.view addSubview:self.userName];
    [self.view addSubview:self.password];
    [self.view addSubview:self.LoginButton];
    
    [self setUpLayout];
}

#pragma mark - YNRegisterViewControllerDelagate
- (void)regiserSuccessWithUserName:(NSString *)userName password:(NSString *)password {
    self.isRegister = YES;
    
    self.userName.text = userName;
    self.password.text = password;
}

#pragma mark - private methed
- (void)setUpLayout {
    
    [self.userName mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.view).mas_equalTo(Margin*2 + 64);
        make.left.equalTo(self.view).mas_equalTo(Margin);
        make.right.equalTo(self.view).mas_equalTo(-Margin);
        make.width.mas_equalTo(self.view.frame.size.width - Margin*2);
        make.height.mas_equalTo(TextFileHeight);
    }];
    
    
    [self.password mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.right.height.equalTo(self.userName);
        make.top.equalTo(self.userName.mas_bottom).mas_equalTo(VerticalSpace);
    }];

    
    [self.LoginButton mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.password).mas_equalTo(-1);
        make.right.equalTo(self.password).mas_equalTo(1);
        make.height.equalTo(self.password);
        make.top.equalTo(self.password.mas_bottom).mas_equalTo(VerticalSpace*4);
    }];

    
}

#pragma mark - event response

- (void)registerBarButtonItemHasClicked {
    
    YNRegisterViewController *registerVc = [[YNRegisterViewController alloc] init];
    registerVc.delegate = self;
    [self.navigationController pushViewController:registerVc animated:YES];
}

- (void)disMissSelfBarButtonItemHasClicked {
    
    [self dismissViewControllerAnimated:YES completion:^{
        
    }];
}

- (void)loginButtonHasClicked {
    
    
    if (self.isRegister) {//注册页面过来的直接登录
        
        [self dismissViewControllerAnimated:YES completion:^{
            
        }];
        
    } else {
        
        if (self.userName.text.length && self.password.text.length) {
            
            //检查用户名和密码
            
            BOOL isUser = false;
            
            NSMutableArray *userArray = [NSKeyedUnarchiver unarchiveObjectWithFile:USERARRAY];
            for (NSDictionary *dict in userArray) {
                
                if([dict[@"userName"] isEqualToString:self.userName.text] && dict[@"userPassword"]) {
                    isUser = YES;
                    break;
                }
            }
            
            if (isUser) {
                
                //把用户名存起来
                NSUserDefaults *userDefault = [NSUserDefaults standardUserDefaults];
                [userDefault setObject:self.userName.text forKey:@"USERID"];

                
                [self dismissViewControllerAnimated:YES completion:^{
                    
                }];
                
            } else {
                
                MBProgressHUD *hud = [MBProgressHUD showHUDAddedTo:self.view animated:YES];
                hud.mode = MBProgressHUDModeText;
                hud.labelText = @"您输入的用户名或密码错误";
                
                dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(1.5* NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
                    
                    [hud hide:YES];
                });
                
            }
            
        } else {
            
            
            MBProgressHUD *hud = [MBProgressHUD showHUDAddedTo:self.view animated:YES];
            hud.mode = MBProgressHUDModeText;
            hud.labelText = @"您输入的用户名或密码错误";
            
            dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(1.5* NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
                
                [hud hide:YES];
            });

        }
    
    }
}

#pragma mark - setters and getters
- (UIBarButtonItem *)registerBarButtonItem {
    if (_registerBarButtonItem == nil) {
        _registerBarButtonItem = [[UIBarButtonItem alloc] initWithTitle:@"注册" style:UIBarButtonItemStylePlain target:self action:@selector(registerBarButtonItemHasClicked)];
        _registerBarButtonItem.tintColor = MainStyleClolr;
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

#pragma mark - setters and getters
- (UITextField *)userName {
    
    if (_userName == nil) {
        
        _userName = [[UITextField alloc] init];
        
        [_userName leftImageViewName:@"register_userName"
                           rightView:nil
                         placeHolder:@"手机号"
                        keyBoardType:UIKeyboardTypeNumberPad];
    }
    return _userName;
}

- (UITextField *)password {
    
    if (_password == nil) {
        
        _password = [[UITextField alloc] init];
        _password.secureTextEntry = YES;
        
        [_password leftImageViewName:@"register_password"
                           rightView:nil
                         placeHolder:@"密码"
                        keyBoardType:0];
    }
    return _password;
}

- (UIButton *)LoginButton {
    if (_LoginButton == nil) {
        
        _LoginButton = [[UIButton alloc] init];
        _LoginButton.layer.cornerRadius = 3;
        _LoginButton.clipsToBounds = YES;
        
        [_LoginButton setTitle:@"登录" forState:UIControlStateNormal];
        [_LoginButton setBackgroundColor:MainStyleClolr];
        [_LoginButton addTarget:self action:@selector(loginButtonHasClicked) forControlEvents:UIControlEventTouchUpInside];
    }
    return _LoginButton;
}


@end
