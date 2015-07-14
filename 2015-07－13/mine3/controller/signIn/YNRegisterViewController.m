//
//  YNRegisterViewController.m
//  2015-07－13
//
//  Created by 路雪魁 on 15/7/13.
//  Copyright (c) 2015年 YN. All rights reserved.
//

#import "YNRegisterViewController.h"

@interface YNRegisterViewController ()
@property (strong, nonatomic) UIBarButtonItem *backBarButtonItem;
//
@property (strong, nonatomic) UITextField *userName;
@property (strong, nonatomic) UITextField *verificationCode;
@property (strong, nonatomic) UITextField *password;
@property (strong, nonatomic) UIButton *regiteButton;
@end

@implementation YNRegisterViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.title = @"注册";
    self.view.backgroundColor = [UIColor colorWithRed:243/255.0 green:240/255.0 blue:236/255.0 alpha:1.0];
    
    self.navigationItem.leftBarButtonItem = self.backBarButtonItem;
    
    
    [self.view addSubview:self.userName];
    [self.view addSubview:self.verificationCode];
    [self.view addSubview:self.password];
    [self.view addSubview:self.regiteButton];
    
    UITapGestureRecognizer *tgr = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(viewHasTaped)];
    [self.view addGestureRecognizer:tgr];
    
    [self setupLayout];
}
 
#pragma mark - event response

- (void)viewHasTaped {
    [self.view endEditing:YES];
}

- (void)backBarButtonItemHasClicked {
    NSLog(@"back has clicked");
    
    [self.navigationController popViewControllerAnimated:YES];
}

- (void)getVerificationButtonhasClicked {
    
}

- (void)regiteButtonHasClicked {
    
}

#pragma mark - private methods

- (void)setupLayout {
    
}

#pragma mark - setters and getters

- (UIBarButtonItem *)backBarButtonItem {
    
    if (_backBarButtonItem == nil) {
        
        _backBarButtonItem = [[UIBarButtonItem alloc] initWithImage:[UIImage imageNamed:@"system_back"] style:UIBarButtonItemStylePlain target:self action:@selector(backBarButtonItemHasClicked)];
        _backBarButtonItem.tintColor = [UIColor redColor];
    
    }
    return _backBarButtonItem;
}

- (UITextField *)userName {
    if (_userName == nil) {
        _userName = [[UITextField alloc] init];
        _userName.placeholder = @"手机号";
        
        _userName.clearButtonMode = UITextFieldViewModeWhileEditing;
        _userName.frame = CGRectMake(20, 90, 280, 44);
        _userName.backgroundColor = [UIColor whiteColor];
        _userName.keyboardType = UIKeyboardTypeNumberPad;
        UIImageView *leftImageView = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"register_userName"]];
        leftImageView.contentMode = UIViewContentModeScaleAspectFit;
        leftImageView.frame = CGRectMake(0, 0, 38, 30);

        _userName.leftView = leftImageView;
        _userName.leftViewMode = UITextFieldViewModeAlways;
    }
    return _userName;
}

- (UITextField *)verificationCode {
    if (_verificationCode == nil) {
        _verificationCode = [[UITextField alloc] init];
        _verificationCode.frame = CGRectMake(20, 140, 280, 44);
        _verificationCode.placeholder = @"验证码";
        _verificationCode.backgroundColor = [UIColor whiteColor];
        _verificationCode.keyboardType = UIKeyboardTypeNumberPad;
        
        UIImageView *leftView = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"register_verficationCode"]];
        leftView.contentMode = UIViewContentModeScaleAspectFit;
        leftView.frame = CGRectMake(0, 0, 38, 30);
        _verificationCode.leftView = leftView;
        _verificationCode.leftViewMode = UITextFieldViewModeAlways;
        
        UIButton *getVerificationCode = [[UIButton alloc] init];
        getVerificationCode.frame = CGRectMake(0, 0, 44, 30);
        getVerificationCode.backgroundColor = [UIColor redColor];
        [getVerificationCode setTitle:@"获取" forState:UIControlStateNormal];
        [getVerificationCode addTarget:self action:@selector(getVerificationButtonhasClicked) forControlEvents:UIControlEventTouchUpInside];
        _verificationCode.rightView = getVerificationCode;
        _verificationCode.rightViewMode = UITextFieldViewModeAlways;
    }
    return _verificationCode;
}

- (UITextField *)password {
    
    if (_password == nil) {
        _password = [[UITextField alloc] init];
        _password.frame = CGRectMake(20, 190, 280, 44);
        _password.backgroundColor = [UIColor whiteColor];
        _password.clearButtonMode = UITextFieldViewModeWhileEditing;
        _password.placeholder = @"密码";
        UIImageView *leftView = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"register_password"]];
        leftView.contentMode = UIViewContentModeScaleAspectFit;
        leftView.frame = CGRectMake(0, 0, 38, 30);
        _password.leftView = leftView;
        _password.leftViewMode = UITextFieldViewModeAlways;
    }
    return _password;
}

- (UIButton *)regiteButton {
    if (_regiteButton == nil) {
        _regiteButton = [[UIButton alloc] init];
        _regiteButton.frame = CGRectMake(20, 255, 280, 44);
        _regiteButton.layer.cornerRadius = 3;
        _regiteButton.clipsToBounds = YES;
        
        [_regiteButton setTitle:@"注册" forState:UIControlStateNormal];
        [_regiteButton setBackgroundColor:[UIColor redColor]];
        [_regiteButton addTarget:self action:@selector(regiteButtonHasClicked) forControlEvents:UIControlEventTouchUpInside];
    }
    return _regiteButton;
}

@end
