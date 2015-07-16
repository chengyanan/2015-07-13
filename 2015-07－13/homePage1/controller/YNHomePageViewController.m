//
//  YNHomePageViewController.m
//  2015-07－13
//
//  Created by 路雪魁 on 15/7/13.
//  Copyright (c) 2015年 YN. All rights reserved.
//

#import "YNHomePageViewController.h"
#import <MBProgressHUD.h>
#import <Masonry.h>

#import "YNOrderAndReserveViewController.h"

#define TopHight self.view.frame.size.height * 0.264
#define AverageHeight self.view.frame.size.height * 0.185

#define VerticalSpace 3
#define HorizontalSpace 2
#define LeftPercent 0.6

#define LeftWith (self.view.frame.size.width - HorizontalSpace) * LeftPercent

#define RightWith (self.view.frame.size.width - HorizontalSpace) * (1 - LeftPercent)

@interface YNHomePageViewController ()

@property (nonatomic, strong) UICollectionView *collectionView;

@property (nonatomic, strong) UIScrollView *scrollView;

@property (nonatomic, strong) UIButton *topBigImageButton;

@property (nonatomic, strong) UIButton *orderOrReserveButton;
@property (nonatomic, strong) UIButton *takeOutButton;
@property (nonatomic, strong) UIButton *memberShipButton;
@property (nonatomic, strong) UIButton *grabCouponsButton;
@property (nonatomic, strong) UIButton *QueuingButton;
@property (nonatomic, strong) UIButton *shakeButton;

@end

@implementation YNHomePageViewController

#pragma mark - life cycle
- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.view.backgroundColor = [UIColor whiteColor];
    
    [self.view addSubview:self.scrollView];
    
    [self.scrollView addSubview:self.topBigImageButton];
    [self.scrollView addSubview:self.orderOrReserveButton];
    [self.scrollView addSubview:self.takeOutButton];
    [self.scrollView addSubview:self.memberShipButton];
    [self.scrollView addSubview:self.grabCouponsButton];
    [self.scrollView addSubview:self.QueuingButton];
    [self.scrollView addSubview:self.shakeButton];
    
    [self setUpLayout];
}

#pragma mark - delegate

#pragma mark - CustomDelegate

#pragma mark - event response
- (void)orderOrReserveButtonHasClicked {
    
    YNOrderAndReserveViewController *orderVc = [[YNOrderAndReserveViewController alloc] init];
    
    [self.navigationController pushViewController:orderVc animated:YES];
}

- (void)takeOutButtonHasClicked {
    [self showLabelWithText:@"马上开通, 敬请期待" interval:1];
}
- (void)memberShipButtonHasClicked {
    [self showLabelWithText:@"马上开通, 敬请期待" interval:1];
}
- (void)grabCouponsButtonHasClicked {
    [self showLabelWithText:@"马上开通, 敬请期待" interval:1];
}
- (void)QueuingButtonHasClicked {
    [self showLabelWithText:@"马上开通, 敬请期待" interval:1];
}
- (void)shakeButtonHasClicked {
    [self showLabelWithText:@"马上开通, 敬请期待" interval:1];
}

#pragma mark - private Methods
- (void)setUpLayout {
    
    [self.scrollView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.right.top.bottom.equalTo(self.view);
    }];
    
    [self.topBigImageButton mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.scrollView);
        make.left.right.equalTo(self.view);
        make.width.mas_equalTo(self.view.frame.size.width);
        make.height.mas_equalTo(TopHight);
    }];
    
    [self.orderOrReserveButton mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.view);
        make.top.equalTo(self.topBigImageButton.mas_bottom).mas_equalTo(VerticalSpace);
        make.width.mas_equalTo(LeftWith);
        make.height.mas_equalTo(AverageHeight);
    }];
    
    [self.takeOutButton mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.bottom.equalTo(self.orderOrReserveButton);
        make.right.equalTo(self.view);
        make.left.equalTo(self.orderOrReserveButton.mas_right).mas_equalTo(HorizontalSpace);
    }];
    
    [self.memberShipButton mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.right.height.equalTo(self.orderOrReserveButton);
        make.top.equalTo(self.orderOrReserveButton.mas_bottom).mas_equalTo(VerticalSpace);
    }];
    
    [self.grabCouponsButton mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.bottom.equalTo(self.memberShipButton);
        make.left.right.equalTo(self.takeOutButton);
    }];
    
    [self.QueuingButton mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.right.height.equalTo(self.memberShipButton);
        make.top.equalTo(self.memberShipButton.mas_bottom).mas_equalTo(VerticalSpace);
        make.bottom.equalTo(self.scrollView);
    }];
    
    [self.shakeButton mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.right.equalTo(self.grabCouponsButton);
        make.top.bottom.equalTo(self.QueuingButton);
    }];
}

- (UIButton *)buttonWithNormalImageNamed:(NSString *)imageNamed withSEL: (SEL)action {
    UIButton *button = [[UIButton alloc] init];
    
    [button setBackgroundImage:[UIImage imageNamed:imageNamed] forState:UIControlStateNormal];
    
    if (action) {
        
        [button addTarget:self action:action forControlEvents:UIControlEventTouchUpInside];
    }
    
    return button;
}

- (void)showLabelWithText:(NSString *)text interval:(CGFloat)interval{
    
    MBProgressHUD *hud = [MBProgressHUD showHUDAddedTo:self.view animated:YES];
    hud.mode = MBProgressHUDModeText;
    hud.labelText = text;
    
    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(interval * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
        
        [hud hide:YES];
    });
}

#pragma getters and setters

- (UIScrollView *)scrollView {
    if (_scrollView == nil) {
        _scrollView = [[UIScrollView alloc] init];
        _scrollView.showsVerticalScrollIndicator = NO;
    }
    return _scrollView;
}

- (UIButton *)topBigImageButton {
    if (_topBigImageButton == nil) {
        _topBigImageButton = [self buttonWithNormalImageNamed:@"home_top" withSEL:nil];
        _topBigImageButton.adjustsImageWhenHighlighted = NO;
    }
    return _topBigImageButton;
}

- (UIButton *)orderOrReserveButton {
    if (_orderOrReserveButton == nil) {
        
        SEL action = @selector(orderOrReserveButtonHasClicked);
        _orderOrReserveButton = [self buttonWithNormalImageNamed:@"home_orderOrReserve" withSEL:action];
    }
    return _orderOrReserveButton;
}
- (UIButton *)takeOutButton {
    if (_takeOutButton == nil) {
        
        SEL action = @selector(takeOutButtonHasClicked);
        _takeOutButton = [self buttonWithNormalImageNamed:@"home_takeOutButton" withSEL:action];
    }
    return _takeOutButton;
}
- (UIButton *)memberShipButton {
    if (_memberShipButton == nil) {
        SEL action = @selector(memberShipButtonHasClicked);
        _memberShipButton = [self buttonWithNormalImageNamed:@"home_memberShipButton" withSEL:action];
    }
    return _memberShipButton;
}
- (UIButton *)grabCouponsButton {
    if (_grabCouponsButton == nil) {
        SEL action = @selector(grabCouponsButtonHasClicked);
        _grabCouponsButton = [self buttonWithNormalImageNamed:@"home_grabCouponsButton" withSEL:action];
    }
    return _grabCouponsButton;
}

- (UIButton *)QueuingButton {
    if (_QueuingButton == nil) {
        SEL action = @selector(QueuingButtonHasClicked);
        _QueuingButton = [self buttonWithNormalImageNamed:@"home_QueuingButton" withSEL:action];
    }
    return _QueuingButton;
}
- (UIButton *)shakeButton {
    if (_shakeButton == nil) {
        SEL action = @selector(shakeButtonHasClicked);
        _shakeButton = [self buttonWithNormalImageNamed:@"home_shakeButton" withSEL:action];
    }
    return _shakeButton;
}
@end
