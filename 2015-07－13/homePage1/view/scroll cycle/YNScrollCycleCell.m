//
//  YNScrollCycleCell.m
//  2015-07－13
//
//  Created by 农盟 on 15/7/23.
//  Copyright (c) 2015年 YN. All rights reserved.
//

#import "YNScrollCycleCell.h"
#import <Masonry.h>


@interface YNScrollCycleCell()

@property (nonatomic, strong) UIImageView *imageView;

@end


@implementation YNScrollCycleCell

- (instancetype)initWithFrame:(CGRect)frame {
    self = [super initWithFrame:frame];
    if (self) {
        
        [self.contentView addSubview:self.imageView];
        
        [self setupLayout];
        
    }
    return self;
}

- (void)setupLayout {
    
    [self.imageView mas_makeConstraints:^(MASConstraintMaker *make) {
        
        make.left.right.top.bottom.equalTo(self.contentView);
    }];
}

#pragma mark - getters

- (UIImageView *)imageView {
    if (_imageView == nil) {
        _imageView = [[UIImageView alloc] init];
    }
    return _imageView;
}
- (void)setImage:(UIImage *)image {
    _image = image;
    
    self.imageView.image = image;
}
@end
