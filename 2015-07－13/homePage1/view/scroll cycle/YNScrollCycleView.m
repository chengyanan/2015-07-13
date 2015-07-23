//
//  YNScrollCycleView.m
//  2015-07－13
//
//  Created by 农盟 on 15/7/23.
//  Copyright (c) 2015年 YN. All rights reserved.
//

#import "YNScrollCycleView.h"
#import "YNScrollCycleCell.h"
#import <Masonry.h>

#define Identify @"CELL_CYCLE"

#define ScreenWidth [UIScreen mainScreen].bounds.size.width

#define TopHight ([UIScreen mainScreen].bounds.size.height * 0.264)


@interface YNScrollCycleView()<UICollectionViewDelegate, UICollectionViewDataSource>

@property (nonatomic, strong) UICollectionView *collectionView;

@property (nonatomic, strong) UICollectionViewFlowLayout *flowLayout;

@end

@implementation YNScrollCycleView

- (instancetype)init {
    self = [super init];
    if (self) {
        
        [self addSubview:self.collectionView];
        [self.collectionView registerClass:[YNScrollCycleCell class] forCellWithReuseIdentifier:Identify];
        
        [self.collectionView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.right.top.bottom.equalTo(self);
        }];
    }
    return self;
}

- (UICollectionView *)collectionView {
    if (_collectionView == nil) {
        
        UICollectionViewFlowLayout *flowLayout = [[UICollectionViewFlowLayout alloc] init];
        flowLayout.itemSize = CGSizeMake(ScreenWidth, TopHight -0.5);
        flowLayout.scrollDirection = UICollectionViewScrollDirectionHorizontal;
        flowLayout.minimumLineSpacing = 0;
        _collectionView = [[UICollectionView alloc] initWithFrame:CGRectZero collectionViewLayout:flowLayout];
        _collectionView.pagingEnabled = YES;
        _collectionView.bounces = NO;
        _collectionView.backgroundColor = [UIColor clearColor];
        _collectionView.showsHorizontalScrollIndicator = NO;
        _collectionView.delegate = self;
        _collectionView.dataSource = self;
        
    }
    return _collectionView;
}

#pragma mark - UICollectionViewDataSource

- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section {
    
    return self.tempArray.count *100;
}

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath {
    
    YNScrollCycleCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:Identify forIndexPath:indexPath];
    cell.image = self.tempArray[indexPath.item%self.tempArray.count];
    
    return cell;
}


- (NSArray *)tempArray {
    if (_tempArray == nil) {
        
        UIImage *image1 = [UIImage imageNamed:@"img_01"];
        UIImage *image2 = [UIImage imageNamed:@"img_02"];
        UIImage *image3 = [UIImage imageNamed:@"img_03"];
        
        _tempArray = @[image1, image2, image3];
    }
    return _tempArray;
}

- (void)layoutSubviews {
    [super layoutSubviews];
    
    
}

@end
