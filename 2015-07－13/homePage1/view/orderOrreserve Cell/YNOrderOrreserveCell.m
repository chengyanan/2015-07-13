//
//  YNOrderOrreserveCell.m
//  2015-07－13
//
//  Created by 农盟 on 15/7/16.
//  Copyright (c) 2015年 YN. All rights reserved.
//

#import "YNOrderOrreserveCell.h"
#import <Masonry.h>

#define LevelImageWH 18

@interface YNOrderOrreserveCell()

@property (nonatomic, strong) UIImageView *businessImageView;
@property (nonatomic, strong) UILabel *businessTitleLabel;
@property (nonatomic, strong) UIImageView *businessLevelImageView;
@property (nonatomic, strong) UIImageView *businessLevelImageView2;
@property (nonatomic, strong) UIImageView *businessLevelImageView3;
@property (nonatomic, strong) UIImageView *businessLevelImageView4;
@property (nonatomic, strong) UIImageView *businessLevelImageView5;
@property (nonatomic, strong) UILabel *businessAddressLabel;
@property (nonatomic, strong) UILabel *businessDistanceLabel;

@end

@implementation YNOrderOrreserveCell

+ (instancetype)orderOrreservecell:(UITableView *)tableview {
    
    static NSString *identify = @"CELL_ORDERORRESERVE";
    YNOrderOrreserveCell *cell = [tableview dequeueReusableCellWithIdentifier:identify];
    if (cell == nil) {
        cell = [[YNOrderOrreserveCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:identify];
    }
    return cell;
}

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier {
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {

        self.contentView.autoresizingMask = UIViewAutoresizingFlexibleHeight|UIViewAutoresizingFlexibleWidth;
        self.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
        
        [self.contentView addSubview:self.businessImageView];
        [self.contentView addSubview:self.businessTitleLabel];
        [self.contentView addSubview:self.businessLevelImageView];
        [self.contentView addSubview:self.businessLevelImageView2];
        [self.contentView addSubview:self.businessLevelImageView3];
        [self.contentView addSubview:self.businessLevelImageView4];
        [self.contentView addSubview:self.businessLevelImageView5];
        [self.contentView addSubview:self.businessAddressLabel];
        [self.contentView addSubview:self.businessDistanceLabel];
        
        [self setUpLayout];
    }
    return self;
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}
#pragma mark - private Methods

- (void)setupLevelWithLevel:(NSString *)level {
    
    if ([level isEqualToString:@"0"]) {
        
        self.businessLevelImageView.image = [UIImage imageNamed:@"level_Off"];
        self.businessLevelImageView2.image = [UIImage imageNamed:@"level_Off"];
        self.businessLevelImageView3.image = [UIImage imageNamed:@"level_Off"];
        self.businessLevelImageView4.image = [UIImage imageNamed:@"level_Off"];
        self.businessLevelImageView5.image = [UIImage imageNamed:@"level_Off"];
        
    } else if ([level isEqualToString:@"1"]) {
        
        self.businessLevelImageView.image = [UIImage imageNamed:@"level_On"];
        self.businessLevelImageView2.image = [UIImage imageNamed:@"level_Off"];
        self.businessLevelImageView3.image = [UIImage imageNamed:@"level_Off"];
        self.businessLevelImageView4.image = [UIImage imageNamed:@"level_Off"];
        self.businessLevelImageView5.image = [UIImage imageNamed:@"level_Off"];
   
    } else if ([level isEqualToString:@"2"]) {
        
        self.businessLevelImageView.image = [UIImage imageNamed:@"level_On"];
        self.businessLevelImageView2.image = [UIImage imageNamed:@"level_On"];
        self.businessLevelImageView3.image = [UIImage imageNamed:@"level_Off"];
        self.businessLevelImageView4.image = [UIImage imageNamed:@"level_Off"];
        self.businessLevelImageView5.image = [UIImage imageNamed:@"level_Off"];
        
    } else if ([level isEqualToString:@"3"]) {
        
        self.businessLevelImageView.image = [UIImage imageNamed:@"level_On"];
        self.businessLevelImageView2.image = [UIImage imageNamed:@"level_On"];
        self.businessLevelImageView3.image = [UIImage imageNamed:@"level_On"];
        self.businessLevelImageView4.image = [UIImage imageNamed:@"level_Off"];
        self.businessLevelImageView5.image = [UIImage imageNamed:@"level_Off"];
        
    } else if ([level isEqualToString:@"4"]) {
        
        self.businessLevelImageView.image = [UIImage imageNamed:@"level_On"];
        self.businessLevelImageView2.image = [UIImage imageNamed:@"level_On"];
        self.businessLevelImageView3.image = [UIImage imageNamed:@"level_On"];
        self.businessLevelImageView4.image = [UIImage imageNamed:@"level_On"];
        self.businessLevelImageView5.image = [UIImage imageNamed:@"level_Off"];
        
    } else if ([level isEqualToString:@"5"]) {
        
        self.businessLevelImageView.image = [UIImage imageNamed:@"level_On"];
        self.businessLevelImageView2.image = [UIImage imageNamed:@"level_On"];
        self.businessLevelImageView3.image = [UIImage imageNamed:@"level_On"];
        self.businessLevelImageView4.image = [UIImage imageNamed:@"level_On"];
        self.businessLevelImageView5.image = [UIImage imageNamed:@"level_On"];
        
    }
}

- (void)setUpLayout {
    
    [self.businessImageView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.contentView).mas_equalTo(5);
        make.top.equalTo(self.contentView).mas_equalTo(5);
        make.bottom.equalTo(self.contentView).mas_equalTo(-5);
        make.width.equalTo(self.businessImageView.mas_height);
    }];
    
    [self.businessTitleLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.businessImageView);
        make.left.equalTo(self.businessImageView.mas_right).mas_equalTo(12);
        make.height.mas_equalTo(20);
    }];
    
    [self.businessLevelImageView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.businessTitleLabel.mas_left);
        make.top.equalTo(self.businessTitleLabel.mas_bottom);
        make.height.mas_equalTo(LevelImageWH);
        make.width.mas_equalTo(LevelImageWH + 4.8);
    }];
    
    [self.businessLevelImageView2 mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.bottom.height.width.equalTo(self.businessLevelImageView);
        make.left.equalTo(self.businessLevelImageView.mas_right);
    }];
    
    [self.businessLevelImageView3 mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.bottom.height.width.equalTo(self.businessLevelImageView);
        make.left.equalTo(self.businessLevelImageView2.mas_right);
    }];
    
    [self.businessLevelImageView4 mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.bottom.height.width.equalTo(self.businessLevelImageView);
        make.left.equalTo(self.businessLevelImageView3.mas_right);
    }];
    
    [self.businessLevelImageView5 mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.bottom.height.width.equalTo(self.businessLevelImageView);
        make.left.equalTo(self.businessLevelImageView4.mas_right);
    }];
    
    [self.businessDistanceLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.equalTo(self.contentView);
        make.bottom.equalTo(self.contentView.mas_bottom);
        make.top.mas_equalTo(self.businessLevelImageView.mas_bottom).mas_equalTo(2);
        make.width.mas_equalTo(50);
    }];
    
    [self.businessAddressLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.businessLevelImageView.mas_left);
        make.top.bottom.equalTo(self.businessDistanceLabel);
        make.right.equalTo(self.businessDistanceLabel.mas_left).mas_equalTo(-10);
    }];
}

#pragma mark - getters and setters
- (void)setData:(NSDictionary *)data {
    if (_data != data) {
        
        self.businessImageView.image = [UIImage imageNamed:@"image"];
        self.businessTitleLabel.text = @"郑州农盟";
        [self setupLevelWithLevel:@"3"];
        self.businessAddressLabel.text = @"商务外环9号, 新芒果大厦, 14楼1405";
        self.businessDistanceLabel.text = @"3.6km";
    }
}

- (UIImageView *)businessImageView {
    if (_businessImageView == nil) {
        _businessImageView = [[UIImageView alloc] init];
        _businessImageView.contentMode = UIViewContentModeScaleAspectFit;
        _businessImageView.translatesAutoresizingMaskIntoConstraints = NO;
    }
    return _businessImageView;
}

- (UILabel *)businessTitleLabel {
    if (_businessTitleLabel == nil) {
        _businessTitleLabel = [[UILabel alloc] init];
        _businessTitleLabel.translatesAutoresizingMaskIntoConstraints = NO;
    }
    return _businessTitleLabel;
}

- (UIImageView *)businessLevelImageView {
    if (_businessLevelImageView == nil) {
        _businessLevelImageView = [[UIImageView alloc] init];
        _businessLevelImageView.contentMode = UIViewContentModeScaleToFill;
        _businessLevelImageView.translatesAutoresizingMaskIntoConstraints = NO;

    }
    return _businessLevelImageView;
}

- (UIImageView *)businessLevelImageView2 {
    if (_businessLevelImageView2 == nil) {
        _businessLevelImageView2 = [[UIImageView alloc] init];
        _businessLevelImageView2.contentMode = UIViewContentModeScaleToFill;
        _businessLevelImageView2.translatesAutoresizingMaskIntoConstraints = NO;
    }
    return _businessLevelImageView2;
}

- (UIImageView *)businessLevelImageView3 {
    if (_businessLevelImageView3 == nil) {
        _businessLevelImageView3 = [[UIImageView alloc] init];
        _businessLevelImageView3.contentMode = UIViewContentModeScaleToFill;
        _businessLevelImageView3.translatesAutoresizingMaskIntoConstraints = NO;
    }
    return _businessLevelImageView3;
}

- (UIImageView *)businessLevelImageView4 {
    if (_businessLevelImageView4 == nil) {
        _businessLevelImageView4 = [[UIImageView alloc] init];
        _businessLevelImageView4.contentMode = UIViewContentModeScaleToFill;
        _businessLevelImageView4.translatesAutoresizingMaskIntoConstraints = NO;

    }
    return _businessLevelImageView4;
}

- (UIImageView *)businessLevelImageView5 {
    if (_businessLevelImageView5 == nil) {
        _businessLevelImageView5 = [[UIImageView alloc] init];
        _businessLevelImageView5.contentMode = UIViewContentModeScaleToFill;
        _businessLevelImageView5.translatesAutoresizingMaskIntoConstraints = NO;
    }
    return _businessLevelImageView5;
}

- (UILabel *)businessAddressLabel {
    if (_businessAddressLabel == nil) {
        _businessAddressLabel = [[UILabel alloc] init];
        _businessAddressLabel.font = [UIFont systemFontOfSize:13];
        _businessAddressLabel.numberOfLines = 0;
        _businessAddressLabel.textColor = [UIColor lightGrayColor];
        _businessAddressLabel.translatesAutoresizingMaskIntoConstraints = NO;

    }
    return _businessAddressLabel;
}

- (UILabel *)businessDistanceLabel {
    if (_businessDistanceLabel == nil) {
        _businessDistanceLabel = [[UILabel alloc] init];
        _businessDistanceLabel.font = [UIFont systemFontOfSize:11];
        _businessDistanceLabel.textAlignment = NSTextAlignmentLeft;
        _businessDistanceLabel.textColor = [UIColor lightGrayColor];
        _businessDistanceLabel.translatesAutoresizingMaskIntoConstraints = NO;
    }
    return _businessDistanceLabel;
}
@end
