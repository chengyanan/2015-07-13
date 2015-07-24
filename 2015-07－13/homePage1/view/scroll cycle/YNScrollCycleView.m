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

@property (nonatomic, strong) NSTimer *timer;

@property (nonatomic, strong) UIPageControl *pageControl;

@property (nonatomic, assign) NSInteger pageNumber;

@end

@implementation YNScrollCycleView

- (instancetype)init {
    self = [super init];
    if (self) {
        
        self.pageNumber = -1;
        
        [self addSubview:self.collectionView];
        [self addSubview:self.pageControl];
        
        [self.collectionView registerClass:[YNScrollCycleCell class] forCellWithReuseIdentifier:Identify];
        
        [self.collectionView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.right.top.bottom.equalTo(self);
        }];
        
        [self.pageControl mas_makeConstraints:^(MASConstraintMaker *make) {
            make.centerX.equalTo(self);
            make.bottom.equalTo(self);
            make.height.mas_equalTo(16);
        }];
        
        
    }
    return self;
}

#pragma mark - event response
- (void)scrollToforward {
    
    self.pageNumber++;
    
    NSInteger row = self.pageNumber % self.tempArray.count;

    NSIndexPath *indexPath = [NSIndexPath indexPathForRow:row inSection:0];
    
    [self.collectionView scrollToItemAtIndexPath:indexPath atScrollPosition:UICollectionViewScrollPositionLeft animated:YES];
    
}


#pragma mark - UICollectionViewDataSource

- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section {
    
    return self.tempArray.count;
}

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath {
    
    YNScrollCycleCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:Identify forIndexPath:indexPath];
    cell.image = self.tempArray[indexPath.item];
    
    return cell;
}

#pragma mark - UIScrollViewDelegate
- (void)scrollViewDidScroll:(UIScrollView *)scrollView {
    
    NSInteger page = (scrollView.contentOffset.x + ScreenWidth/2) / ScreenWidth;
    
//    NSLog(@"%ld",page);
    
    self.pageControl.currentPage = page;
    
//    NSLog(@"%f", scrollView.contentOffset.x);
    
}

- (void)scrollViewDidEndDragging:(UIScrollView *)scrollView willDecelerate:(BOOL)decelerate {
    
    [self startTimer];
}

- (void)scrollViewWillBeginDragging:(UIScrollView *)scrollView {
    
    [self pauseTimer];
}

#pragma mark - private mothed

- (void)pauseTimer {
    [self.timer setFireDate:[NSDate distantFuture]];
}

- (void)startTimer {
    
    [self.timer setFireDate:[[NSDate alloc] initWithTimeIntervalSinceNow:1]];
}

#pragma mark - getters and setters
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

- (UIPageControl *)pageControl {
    if (_pageControl == nil) {
        _pageControl = [[UIPageControl alloc] init];
        
        _pageControl.currentPageIndicatorTintColor = MainStyleClolr;
        _pageControl.pageIndicatorTintColor = [UIColor purpleColor];
    }
    return _pageControl;
}

- (void)setTempArray:(NSArray *)tempArray {
    if (_tempArray != tempArray) {
        _tempArray = tempArray;
        
        self.pageControl.numberOfPages = _tempArray.count;
        [self.collectionView reloadData];
    }
}


- (NSTimer *)timer {
    
    if(_timer == nil) {
   
        _timer = [NSTimer scheduledTimerWithTimeInterval:4
                                                  target:self
                                                selector:@selector(scrollToforward)
                                                userInfo:nil
                                                 repeats:YES];
    }
    
    return _timer;
}


@end
