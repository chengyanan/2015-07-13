//
//  YNDropDownMenu.m
//  2015-07－13
//
//  Created by 农盟 on 15/7/22.
//  Copyright (c) 2015年 YN. All rights reserved.
//

#import "YNDropDownMenu.h"

#define ScreenWidth [UIScreen mainScreen].bounds.size.width
#define ScreenHeight 44
#define TableView1Width ScreenWidth * 0.4
#define TableView2Width ScreenWidth-TableView1Width
@interface YNDropDownMenu()<UITableViewDataSource, UITableViewDelegate>

@property (nonatomic, assign) NSInteger numOfMenu;

@property (nonatomic, strong) UIView *backGroundView;

@property (nonatomic, strong) UITableView *tableView1;
@property (nonatomic, strong) UITableView *tableView2;

@property (nonatomic, assign) NSInteger numberOftableView;

@property (nonatomic, assign, getter=isShow) BOOL show;

@property (nonatomic, assign) NSInteger currentSelectedMenudIndex;

@property (nonatomic, copy) NSArray *titles;
@property (nonatomic, copy) NSArray *indicators;
@property (nonatomic, copy) NSArray *bgLayers;

@end

@implementation YNDropDownMenu

- (instancetype)initWithFrame:(CGRect)frame {
    self = [super initWithFrame:frame];
    if (self) {
        
        //self tapped
        self.backgroundColor = [UIColor whiteColor];
        UIGestureRecognizer *tapGesture = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(menuTapped:)];
        [self addGestureRecognizer:tapGesture];
        
        //background init and tapped
        _backGroundView = [[UIView alloc] initWithFrame:CGRectMake(0, 64, ScreenWidth, [UIScreen mainScreen].bounds.size.height)];
        _backGroundView.backgroundColor = [UIColor colorWithWhite:0.0 alpha:0.0];
        _backGroundView.opaque = NO;
        UIGestureRecognizer *gesture = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(backgroundTapped:)];
        [_backGroundView addGestureRecognizer:gesture];
        
        //add bottom shadow
        UIView *bottomShadow = [[UIView alloc] initWithFrame:CGRectMake(0, ScreenHeight-0.5, ScreenWidth, 0.5)];
        bottomShadow.backgroundColor = [UIColor lightGrayColor];
        [self addSubview:bottomShadow];
        
    }
    return self;
}

#pragma mark - gesture handle
- (void)menuTapped:(UITapGestureRecognizer *)paramSender {
    CGPoint touchPoint = [paramSender locationInView:self];
    //calculate index
    NSInteger tapIndex = touchPoint.x / (self.frame.size.width / _numOfMenu);
    
    for (int i = 0; i < _numOfMenu; i++) {
        if (i != tapIndex) {
            [self animateIndicator:_indicators[i] Forward:NO complete:^{
                [self animateTitle:_titles[i] show:NO complete:^{
                    
                }];
            }];
            [(CALayer *)self.bgLayers[i] setBackgroundColor:[UIColor whiteColor].CGColor];
        }
    }
    
    if (tapIndex == _currentSelectedMenudIndex && _show) {
        [self animateIdicator:_indicators[_currentSelectedMenudIndex] background:_backGroundView  title:_titles[_currentSelectedMenudIndex] forward:NO complecte:^{
            _currentSelectedMenudIndex = tapIndex;
            _show = NO;
        }];
        [(CALayer *)self.bgLayers[tapIndex] setBackgroundColor:[UIColor whiteColor].CGColor];
    } else {
        _currentSelectedMenudIndex = tapIndex;
        
        
        
//        [_tableView reloadData];
        
        [self animateIdicator:_indicators[tapIndex] background:_backGroundView title:_titles[tapIndex] forward:YES complecte:^{
            _show = YES;
        }];
        [(CALayer *)self.bgLayers[tapIndex] setBackgroundColor:[UIColor colorWithWhite:0.9 alpha:1.0].CGColor];
    }
}

- (void)backgroundTapped:(UITapGestureRecognizer *)paramSender
{
    [self animateIdicator:_indicators[_currentSelectedMenudIndex] background:_backGroundView title:_titles[_currentSelectedMenudIndex] forward:NO complecte:^{
        _show = NO;
    }];
    [(CALayer *)self.bgLayers[_currentSelectedMenudIndex] setBackgroundColor:[UIColor whiteColor].CGColor];
    
}


#pragma mark - animation method
- (void)animateIndicator:(CAShapeLayer *)indicator Forward:(BOOL)forward complete:(void(^)())complete {
    [CATransaction begin];
    [CATransaction setAnimationDuration:0.25];
    [CATransaction setAnimationTimingFunction:[CAMediaTimingFunction functionWithControlPoints:0.4 :0.0 :0.2 :1.0]];
    
    CAKeyframeAnimation *anim = [CAKeyframeAnimation animationWithKeyPath:@"transform.rotation"];
    anim.values = forward ? @[ @0, @(M_PI) ] : @[ @(M_PI), @0 ];
    
    if (!anim.removedOnCompletion) {
        [indicator addAnimation:anim forKey:anim.keyPath];
    } else {
        [indicator addAnimation:anim forKey:anim.keyPath];
        [indicator setValue:anim.values.lastObject forKeyPath:anim.keyPath];
    }
    
    [CATransaction commit];
    
    complete();
}

- (void)animateBackGroundView:(UIView *)view show:(BOOL)show complete:(void(^)())complete {
    if (show) {
        [self.superview addSubview:view];
        [view.superview addSubview:self];
        
        [UIView animateWithDuration:0.2 animations:^{
            view.backgroundColor = [UIColor colorWithWhite:0.0 alpha:0.3];
        }];
    } else {
        [UIView animateWithDuration:0.2 animations:^{
            view.backgroundColor = [UIColor colorWithWhite:0.0 alpha:0.0];
        } completion:^(BOOL finished) {
            [view removeFromSuperview];
        }];
    }
    complete();
}

- (void)animatenumberOfTableView:(NSInteger)number show:(BOOL)show  complete:(void(^)())complete {
    if (show) {
        
        
        CGFloat tableViewHeight = ([self.tableView1 numberOfRowsInSection:0] > 5) ? (5 * self.tableView1.rowHeight) : ([self.tableView1 numberOfRowsInSection:0] * self.tableView1.rowHeight);
        
        if (number == 2) {
            
           
               
//                self.tableView1.frame = CGRectMake(0, 64 + ScreenHeight, TableView1Width, 0);
//                [self.superview addSubview:self.tableView1];
//                
//                CGFloat tableViewHeight = ([self.tableView1 numberOfRowsInSection:0] > 5) ? (5 * self.tableView1.rowHeight) : ([self.tableView1 numberOfRowsInSection:0] * self.tableView1.rowHeight);
//                
//                [UIView animateWithDuration:0.2 animations:^{
//                    self.tableView1.frame = CGRectMake(0, 64 + ScreenHeight , TableView1Width, tableViewHeight);
//                }];
//                
//                self.tableView2.frame = CGRectMake(TableView1Width, 64 + ScreenHeight, TableView2Width, 0);
//                [self.superview addSubview:self.tableView2];
//                
//                [UIView animateWithDuration:0.2 animations:^{
//                    self.tableView2.frame = CGRectMake(TableView1Width, 64 + ScreenHeight , TableView2Width, tableViewHeight);
//                }];
            
            self.tableView1.frame = CGRectMake(0, 64 + ScreenHeight , TableView1Width, tableViewHeight);
            self.tableView2.frame = CGRectMake(TableView1Width, 64 + ScreenHeight , TableView2Width, tableViewHeight);
            
            [self.superview addSubview:self.tableView1];
            [self.superview addSubview:self.tableView2];
            
            [_tableView1 reloadData];
            [_tableView2 reloadData];
            
            
        } else if (number == 1) {
       
//            self.tableView1.frame = CGRectMake(0, 64 + ScreenHeight, ScreenWidth, 0);
//            [self.superview addSubview:self.tableView1];
//            
//            CGFloat tableViewHeight = ([self.tableView1 numberOfRowsInSection:0] > 5) ? (5 * self.tableView1.rowHeight) : ([self.tableView1 numberOfRowsInSection:0] * self.tableView1.rowHeight);
//            
//            [UIView animateWithDuration:0.2 animations:^{
//                self.tableView1.frame = CGRectMake(0, 64 + ScreenHeight , ScreenWidth, tableViewHeight);
//            }];

            self.tableView2.frame = CGRectMake(0, 64 + ScreenHeight , ScreenWidth, tableViewHeight);
            [self.superview addSubview:self.tableView2];
            
            [self.tableView2 reloadData];
        }
        
    } else {
        
        [UIView animateWithDuration:0.2 animations:^{
            _tableView1.frame = CGRectMake(0, 64 + ScreenHeight, TableView1Width, 0);
        } completion:^(BOOL finished) {
            [_tableView1 removeFromSuperview];
        }];
    
        if (number == 2) {
            
//            [_tableView1 removeFromSuperview];
//             [_tableView2 removeFromSuperview];
            
            [UIView animateWithDuration:0.2 animations:^{
                _tableView2.frame = CGRectMake(TableView1Width, 64 + ScreenHeight, TableView2Width , 0);
            } completion:^(BOOL finished) {
                [_tableView2 removeFromSuperview];
            }];
            
        }else if (number == 1) {
       
            [UIView animateWithDuration:0.2 animations:^{
                _tableView2.frame = CGRectMake(0, 64 + ScreenHeight, ScreenWidth, 0);
            } completion:^(BOOL finished) {
                [_tableView2 removeFromSuperview];
            }];
        }
        
       
    }
    complete();
    
    self.numberOftableView = number;
}

- (void)animateTitle:(CATextLayer *)title show:(BOOL)show complete:(void(^)())complete {
    CGSize size = [self calculateTitleSizeWithString:title.string];
    CGFloat sizeWidth = (size.width < (self.frame.size.width / _numOfMenu) - 25) ? size.width : self.frame.size.width / _numOfMenu - 25;
    title.bounds = CGRectMake(0, 0, sizeWidth, size.height);
    complete();
}

- (void)animateIdicator:(CAShapeLayer *)indicator background:(UIView *)background  title:(CATextLayer *)title forward:(BOOL)forward complecte:(void(^)())complete{
    
    [self animateIndicator:indicator Forward:forward complete:^{
        [self animateTitle:title show:forward complete:^{
            [self animateBackGroundView:background show:forward complete:^{
                
                if (self.currentSelectedMenudIndex == 0 || self.currentSelectedMenudIndex == 1) {
                    
                    
                    
                    [self animatenumberOfTableView:2 show:forward complete:^{
                        
                    }];
                    
                } else {
                    
                   
                    
                    [self animatenumberOfTableView:1 show:forward complete:^{
                        
                    }];
                }
                
                
            }];
        }];
    }];
    
    complete();
}

#pragma mark - UITableViewDataSource
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    
    if (self.currentSelectedMenudIndex ==0) {
        
        
    } else if (  self.currentSelectedMenudIndex == 1){
        
   
    } else if (self.currentSelectedMenudIndex == 2) {
        
   
    }
    return 10;
}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    static NSString *identify = @"CELL_ONLINE";
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:identify];
    if (cell == nil) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:identify];
    }
    cell.textLabel.text = @"rose";
    
    return cell;
}
#pragma mark - UITableViewDelegate

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    
    if (tableView.tag == 1) {
        
        
        [self.tableView2 reloadData];
        
    } else if (tableView.tag == 2) {
        
        [self confiMenuWithSelectRow:indexPath.row];
    }
}

#pragma mark - <#CustomDelegate#>
#pragma mark - event response
#pragma mark - private Methods

- (void)confiMenuWithSelectRow:(NSInteger)row {
    
    CATextLayer *title = (CATextLayer *)_titles[_currentSelectedMenudIndex];
//    title.string = [self.dataSource menu:self titleForRowAtIndexPath:[DOPIndexPath indexPathWithCol:self.currentSelectedMenudIndex row:row]];
    
    title.string = @"rose";
    
    [self animateIdicator:_indicators[_currentSelectedMenudIndex] background:_backGroundView title:_titles[_currentSelectedMenudIndex] forward:NO complecte:^{
        _show = NO;
    }];
    [(CALayer *)self.bgLayers[_currentSelectedMenudIndex] setBackgroundColor:[UIColor whiteColor].CGColor];
    
    CAShapeLayer *indicator = (CAShapeLayer *)_indicators[_currentSelectedMenudIndex];
    indicator.position = CGPointMake(title.position.x + title.frame.size.width / 2 + 8, indicator.position.y);
}


- (CALayer *)createBgLayerWithColor:(UIColor *)color andPosition:(CGPoint)position {
    CALayer *layer = [CALayer layer];
    layer.position = position;
    layer.bounds = CGRectMake(0, 0, ScreenWidth/self.numOfMenu, ScreenHeight-1);
    layer.backgroundColor = color.CGColor;
    //    NSLog(@"bglayer bounds:%@",NSStringFromCGRect(layer.bounds));
    //    NSLog(@"bglayer position:%@", NSStringFromCGPoint(position));
    
    return layer;
}

- (CGSize)calculateTitleSizeWithString:(NSString *)string
{
    CGFloat fontSize = 14.0;
    NSDictionary *dic = @{NSFontAttributeName: [UIFont systemFontOfSize:fontSize]};
    CGSize size = [string boundingRectWithSize:CGSizeMake(280, 0) options:NSStringDrawingTruncatesLastVisibleLine | NSStringDrawingUsesLineFragmentOrigin | NSStringDrawingUsesFontLeading attributes:dic context:nil].size;
    return size;
}


- (CATextLayer *)createTextLayerWithNSString:(NSString *)string withColor:(UIColor *)color andPosition:(CGPoint)point {
    
    CGSize size = [self calculateTitleSizeWithString:string];
    
    CATextLayer *layer = [CATextLayer new];
    CGFloat sizeWidth = (size.width < (ScreenWidth / _numOfMenu) - 25) ? size.width : ScreenWidth / _numOfMenu - 25;
    layer.bounds = CGRectMake(0, 0, sizeWidth, size.height);
    layer.string = string;
    layer.fontSize = 14.0;
    layer.alignmentMode = kCAAlignmentCenter;
    layer.foregroundColor = color.CGColor;
    
    layer.contentsScale = [[UIScreen mainScreen] scale];
    
    layer.position = point;
    
    return layer;
}

- (CAShapeLayer *)createSeparatorWithPosition:(CGPoint)point {
    CAShapeLayer *layer = [CAShapeLayer new];
    
    UIBezierPath *path = [UIBezierPath new];
    [path moveToPoint:CGPointMake(0, 0)];
    [path addLineToPoint:CGPointMake(0, 20)];
    
    layer.path = path.CGPath;
    layer.lineWidth = 1.0;
    layer.strokeColor = [UIColor grayColor].CGColor;
    
    CGPathRef bound = CGPathCreateCopyByStrokingPath(layer.path, nil, layer.lineWidth * 0.5, kCGLineCapButt, kCGLineJoinMiter, layer.miterLimit);
    layer.bounds = CGPathGetBoundingBox(bound);
    CGPathRelease(bound);
    
    layer.position = point;
    
    return layer;
}

- (CAShapeLayer *)createIndicatorWithColor:(UIColor *)color andPosition:(CGPoint)point {
    CAShapeLayer *layer = [CAShapeLayer new];
    
    UIBezierPath *path = [UIBezierPath new];
//    [path moveToPoint:CGPointMake(0, 0)];
//    [path addLineToPoint:CGPointMake(8, 0)];
//    [path addLineToPoint:CGPointMake(4, 5)];
    
        [path moveToPoint:CGPointMake(4, 0)];
        [path addLineToPoint:CGPointMake(8, 5)];
        [path addLineToPoint:CGPointMake(0, 5)];

    [path closePath];
    
    layer.path = path.CGPath;
    layer.lineWidth = 1.0;
    layer.fillColor = color.CGColor;
    
    CGPathRef bound = CGPathCreateCopyByStrokingPath(layer.path, nil, layer.lineWidth, kCGLineCapButt, kCGLineJoinMiter, layer.miterLimit);
    layer.bounds = CGPathGetBoundingBox(bound);
    CGPathRelease(bound);
    
    layer.position = point;
    
    return layer;
}

- (void)setUpInterface {
    
    CGFloat textLayerInterval = ScreenWidth / ( _numOfMenu * 2);
    CGFloat bgLayerInterval = ScreenWidth / _numOfMenu;
    
    NSMutableArray *tempTitles = [[NSMutableArray alloc] initWithCapacity:_numOfMenu];
    NSMutableArray *tempIndicators = [[NSMutableArray alloc] initWithCapacity:_numOfMenu];
    NSMutableArray *tempBgLayers = [[NSMutableArray alloc] initWithCapacity:_numOfMenu];
    
    
    for (int i = 0; i < _numOfMenu; i++) {
        //bgLayer
        CGPoint bgLayerPosition = CGPointMake((i+0.5)*bgLayerInterval, ScreenHeight/2);
        CALayer *bgLayer = [self createBgLayerWithColor:[UIColor whiteColor] andPosition:bgLayerPosition];
        [self.layer addSublayer:bgLayer];
        [tempBgLayers addObject:bgLayer];
        
        //title
        CGPoint titlePosition = CGPointMake( (i * 2 + 1) * textLayerInterval , ScreenHeight / 2);
        NSString *titleString = self.menuTitleArray[i];
        CATextLayer *title = [self createTextLayerWithNSString:titleString withColor:self.textColor andPosition:titlePosition];
        [self.layer addSublayer:title];
        [tempTitles addObject:title];

        //indicator
        CAShapeLayer *indicator = [self createIndicatorWithColor:self.indicatorColor andPosition:CGPointMake(titlePosition.x + title.bounds.size.width / 2 + 8, ScreenHeight / 2)];
        [self.layer addSublayer:indicator];
        [tempIndicators addObject:indicator];
        
        //separator
        if (i != (self.menuTitleArray.count-1)) {
            
            CGPoint separatorPosition = CGPointMake(CGRectGetMaxX(bgLayer.frame)-1, ScreenHeight/2) ;
            
            CAShapeLayer *separator = [self createSeparatorWithPosition:separatorPosition];
            
            [self.layer addSublayer:separator];
        }
        
    }

    
    _titles = [tempTitles copy];
    _indicators = [tempIndicators copy];
    _bgLayers = [tempBgLayers copy];
}

#pragma getters and setters

- (void)setMenuTitleArray:(NSArray *)menuTitleArray {
    _menuTitleArray = menuTitleArray;
    
    self.numOfMenu = menuTitleArray.count;
}

- (void)setNumOfMenu:(NSInteger)numOfMenu {
    _numOfMenu = numOfMenu;
    
    [self setUpInterface];
}

- (UIColor *)indicatorColor {
    if (!_indicatorColor) {
        _indicatorColor = [UIColor blackColor];
    }
    return _indicatorColor;
}

- (UIColor *)textColor {
    if (!_textColor) {
        _textColor = [UIColor blackColor];
    }
    return _textColor;
}

- (UIColor *)separatorColor {
    if (!_separatorColor) {
        _separatorColor = [UIColor blackColor];
    }
    return _separatorColor;
}

- (UITableView *)tableView1 {
    if (_tableView1 == nil) {
        _tableView1 = [[UITableView alloc] init];
        _tableView1.delegate = self;
        _tableView1.tag = 1;
        _tableView1.rowHeight = 35;
        _tableView1.dataSource = self;
    }
    return _tableView1;
}

- (UITableView *)tableView2 {
    if (_tableView2 == nil) {
        _tableView2 = [[UITableView alloc] init];
        _tableView2.rowHeight = 35;
        _tableView2.tag = 2;
        _tableView2.delegate = self;
        _tableView2.dataSource = self;
    }
    return _tableView2;
}

@end
