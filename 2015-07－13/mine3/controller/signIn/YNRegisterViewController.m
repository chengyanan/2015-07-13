//
//  YNRegisterViewController.m
//  2015-07－13
//
//  Created by 路雪魁 on 15/7/13.
//  Copyright (c) 2015年 YN. All rights reserved.
//

#import "YNRegisterViewController.h"
#import "UITextField+LeftAndRightView.h"
#import <Masonry.h>
#import "YNTool.h"
#import <MBProgressHUD.h>


#define Margin 12
#define TextFileHeight 44
#define VerticalSpace 3
#define CodeCount 4


#define ScreenHeight [UIScreen mainScreen].bounds.size.height
#define ScreenWidth [UIScreen mainScreen].bounds.size.width

//iphone型号判断
#define iphone4 ScreenHeight == 480
#define iphone5 ScreenHeight == 568
#define iphone6   ScreenHeight == 667

#define USERARRAY [[NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES) lastObject] stringByAppendingPathComponent:@"userArray.db"]

@interface YNRegisterViewController ()
@property (strong, nonatomic) UIBarButtonItem *backBarButtonItem;
//
@property (strong, nonatomic) UITextField *userName;
@property (strong, nonatomic) UITextField *verificationCode;
@property (strong, nonatomic) UITextField *password;
@property (strong, nonatomic) UITextField *passwordAgain;

@property(strong, nonatomic) UIButton *getVerificationCode;

@property (strong, nonatomic) UIButton *regiteButton;

@property (strong, nonatomic) UIScrollView *scrollView;

@property (assign, nonatomic) CGSize originalContentSize;
@end

@implementation YNRegisterViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.title = @"注册";
    self.view.backgroundColor = [UIColor colorWithRed:243/255.0 green:240/255.0 blue:236/255.0 alpha:1.0];
    
    self.navigationItem.leftBarButtonItem = self.backBarButtonItem;
    
    [self.view addSubview:self.scrollView];
    
    [self.scrollView addSubview:self.userName];
    [self.scrollView addSubview:self.verificationCode];
    [self.scrollView addSubview:self.password];
    [self.scrollView addSubview:self.passwordAgain];
    [self.scrollView addSubview:self.regiteButton];
    
    UITapGestureRecognizer *tgr = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(viewHasTaped)];
    [self.scrollView addGestureRecognizer:tgr];
    
    [self setupLayout];
    
    [[NSNotificationCenter defaultCenter]addObserver:self selector:@selector(keyboardWillAppear:) name:UIKeyboardWillShowNotification object:nil];
    [[NSNotificationCenter defaultCenter]addObserver:self selector:@selector(keyboardWillDisappear:) name:UIKeyboardWillHideNotification object:nil];
}
 
#pragma mark - event response

-(void)keyboardWillAppear:(NSNotification *)notification {
    NSLog(@"%@", notification);
    
    NSDictionary *userInfo = [notification userInfo];
    NSValue *aValue = [userInfo objectForKey:UIKeyboardFrameEndUserInfoKey];
    CGRect keyboardRect = [aValue CGRectValue];
    int height = keyboardRect.size.height;
    
    self.originalContentSize = self.scrollView.contentSize;
    
    if (iphone4) {
        
        self.scrollView.contentSize = CGSizeMake(self.view.frame.size.width, self.view.frame.size.height + height*0.5 - 64);
    }
    
    if (iphone5) {
        
        self.scrollView.contentSize = CGSizeMake(self.view.frame.size.width, self.view.frame.size.height );
    }
    
}
-(void)keyboardWillDisappear:(NSNotification *)notification {
    
    self.scrollView.contentSize = self.originalContentSize;
}

- (void)viewHasTaped {
    [self.view endEditing:YES];
}

- (void)backBarButtonItemHasClicked {
    NSLog(@"back has clicked");
    
    [self.navigationController popViewControllerAnimated:YES];
}

- (void)getVerificationButtonhasClicked {
    
    
    //检查手机号是否正确
    if ([YNTool isPhoneNumber:self.userName.text]) {
        
        self.getVerificationCode.backgroundColor = [UIColor grayColor];
        self.getVerificationCode.userInteractionEnabled = NO;
        
        //是手机号发送验证码
        
    } else {
        
        //不是手机号提示错误
        [self showLabelWithText:@"您输入的号码不正确" interval:1];
    }
}

- (void)regiteButtonHasClicked {
    
    BOOL allFillIn = self.userName.text.length && self.verificationCode.text.length && self.password.text.length && self.passwordAgain.text.length;
    
    if (allFillIn) {
        
        if ([self.passwordAgain.text isEqualToString:self.password.text]) {
            
            //把用户名存起来
            NSUserDefaults *userDefault = [NSUserDefaults standardUserDefaults];
            [userDefault setObject:self.userName.text forKey:@"USERID"];
            
            NSDictionary *dict = @{@"userName": self.userName.text, @"userPassword": self.password.text};
            
            NSMutableArray *userArray = [NSMutableArray array];
            [userArray addObject:dict];
            
            [NSKeyedArchiver archiveRootObject:userArray toFile:USERARRAY];
            
            [self showLabelWithText:@"注册成功" interval:0.7];
            
            if ([self.delegate respondsToSelector:@selector(regiserSuccessWithUserName:password:)]) {
                
                [self.delegate regiserSuccessWithUserName:self.userName.text password:self.password.text];
            }
            
            dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(1 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
                
                 [self.navigationController popViewControllerAnimated:YES];
            });
           
        }
        
    } else {
        [self showLabelWithText:@"信息填写不完整" interval:1];
    }
    
}

#pragma mark - private methods

- (void)showLabelWithText:(NSString *)text interval:(CGFloat)interval{
    
    MBProgressHUD *hud = [MBProgressHUD showHUDAddedTo:self.view animated:YES];
    hud.mode = MBProgressHUDModeText;
    hud.labelText = text;
    
    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(interval * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
        
        [hud hide:YES];
    });
}

- (void)setupLayout {
    
    [self.scrollView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.right.top.bottom.equalTo(self.view);
    }];
    
    
    [self.userName mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.scrollView).mas_equalTo(Margin*1.5);
        make.left.equalTo(self.scrollView).mas_equalTo(Margin);
        make.right.equalTo(self.scrollView).mas_equalTo(-Margin);
        make.width.mas_equalTo(self.view.frame.size.width - Margin*2);
        make.height.mas_equalTo(TextFileHeight);
    }];
    
    [self.verificationCode mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.right.height.equalTo(self.userName);
        make.top.equalTo(self.userName.mas_bottom).mas_equalTo(VerticalSpace);
    }];
    
    [self.password mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.right.height.equalTo(self.verificationCode);
        make.top.equalTo(self.verificationCode.mas_bottom).mas_equalTo(VerticalSpace);
    }];
    
    [self.passwordAgain mas_makeConstraints:^(MASConstraintMaker *make) {
        
        make.left.right.height.equalTo(self.password);
        make.top.equalTo(self.password.mas_bottom).mas_equalTo(VerticalSpace);
    }];
    
    [self.regiteButton mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.passwordAgain).mas_equalTo(-1);
        make.right.equalTo(self.passwordAgain).mas_equalTo(1);
        make.height.equalTo(self.passwordAgain);
        make.top.equalTo(self.passwordAgain.mas_bottom).mas_equalTo(VerticalSpace*4);
    }];
}

#pragma mark - setters and getters

- (UIBarButtonItem *)backBarButtonItem {
    
    if (_backBarButtonItem == nil) {
        
        _backBarButtonItem = [[UIBarButtonItem alloc] initWithImage:[UIImage imageNamed:@"system_back"]
                                                              style:UIBarButtonItemStylePlain
                                                             target:self
                                                             action:@selector(backBarButtonItemHasClicked)];
        _backBarButtonItem.tintColor = [UIColor redColor];
    
    }
    return _backBarButtonItem;
}

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

- (UITextField *)verificationCode {
    
    if (_verificationCode == nil) {
        
        _verificationCode = [[UITextField alloc] init];
        
        UIButton *getVerificationCode = [[UIButton alloc] init];
        self.getVerificationCode = getVerificationCode;
        getVerificationCode.layer.cornerRadius = 3;
        getVerificationCode.frame = CGRectMake(0, 0, 72, 40);
        getVerificationCode.backgroundColor = MainStyleClolr;
        [getVerificationCode setTitle:@"获取" forState:UIControlStateNormal];
        [getVerificationCode addTarget:self action:@selector(getVerificationButtonhasClicked) forControlEvents:UIControlEventTouchUpInside];
        
        [_verificationCode leftImageViewName:@"register_verficationCode"
                                   rightView:getVerificationCode
                                 placeHolder:@"验证码"
                                keyBoardType:UIKeyboardTypeNumberPad];

    }
    return _verificationCode;
}

- (UITextField *)passwordAgain {
    
    if (_passwordAgain == nil) {
        
        _passwordAgain = [[UITextField alloc] init];
        _passwordAgain.secureTextEntry = YES;
        [_passwordAgain leftImageViewName:@"register_password"
                           rightView:nil
                         placeHolder:@"确认密码"
                        keyBoardType:0];
    }
    return _passwordAgain;
}

- (UIButton *)regiteButton {
    if (_regiteButton == nil) {
        
        _regiteButton = [[UIButton alloc] init];
        _regiteButton.layer.cornerRadius = 3;
        _regiteButton.clipsToBounds = YES;
        
        [_regiteButton setTitle:@"注册" forState:UIControlStateNormal];
        [_regiteButton setBackgroundColor:MainStyleClolr];
        [_regiteButton addTarget:self action:@selector(regiteButtonHasClicked) forControlEvents:UIControlEventTouchUpInside];
    }
    return _regiteButton;
}

- (UIScrollView *)scrollView {
    if (_scrollView == nil) {
        
        _scrollView = [[UIScrollView alloc] init];
    }
    return _scrollView;
}


@end
