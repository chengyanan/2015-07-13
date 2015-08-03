//
//  YNOrderAndReserveViewController.m
//  2015-07－13
//
//  Created by 农盟 on 15/7/16.
//  Copyright (c) 2015年 YN. All rights reserved.
//

#import "YNOrderAndReserveViewController.h"
#import "YNOrderOrreserveCell.h"
#import <Masonry.h>
#import "YNDropDownMenu.h"
#import "YNElementModel.h"
#import "YNLevelModel.h"


@interface YNOrderAndReserveViewController ()<UITableViewDataSource, UITableViewDelegate>

@property (nonatomic, strong) UITableView *tableView;

@property (nonatomic, strong) YNDropDownMenu *dropDownMenu;

@property (nonatomic, strong) NSArray *topDataArray;

@end

@implementation YNOrderAndReserveViewController

#pragma mark - life cycle
- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.title = @"食堂";
    self.view.backgroundColor = [UIColor whiteColor];
    
    [self.view addSubview:self.tableView];
//    [self.view addSubview:self.dropDownMenu];
    
    [self setupLayout];
    
    self.dropDownMenu.menuTitleArray = @[@"附近", @"口味", @"排序"];
}


#pragma mark - UITableViewDataSource
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    
    return 10;
}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    YNOrderOrreserveCell *cell = [YNOrderOrreserveCell orderOrreservecell:tableView];
    cell.data = [NSDictionary dictionary];
    return cell;
}
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    return 80;
}

- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section {
    
    YNDropDownMenu *menu = [[YNDropDownMenu alloc] init];
    
    menu.menuTitleArray = @[@"附近", @"口味", @"排序"];
    
    menu.dataArray = self.topDataArray;
    
    return menu;
}

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section {
    
    return 44;
}

#pragma mark - UITableViewDelegate
#pragma mark - event response

#pragma mark - private Methods
- (void)setupLayout {
    
//    [self.dropDownMenu mas_makeConstraints:^(MASConstraintMaker *make) {
//        make.top.equalTo(self.view.mas_top).mas_equalTo(64);
//        make.left.right.equalTo(self.view);
//        make.height.mas_equalTo(44);
//    }];
    
//    [self.tableView mas_makeConstraints:^(MASConstraintMaker *make) {
//        make.top.equalTo(self.dropDownMenu.mas_bottom).mas_equalTo(-64);
//        make.left.right.bottom.equalTo(self.view);
//    }];
    
        [self.tableView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.equalTo(self.view);
            make.left.right.bottom.equalTo(self.view);
        }];
}

#pragma getters and setters
- (UITableView *)tableView {
    if (_tableView == nil) {
        _tableView = [[UITableView alloc] init];
        _tableView.delegate = self;
        _tableView.dataSource = self;
    }
    return _tableView;
}

- (YNDropDownMenu *)dropDownMenu {
    if (_dropDownMenu == nil) {
        _dropDownMenu = [[YNDropDownMenu alloc] init];
        
    }
    return _dropDownMenu;
}

- (NSArray *)topDataArray {
    if (_topDataArray == nil) {
        
        NSString *path = [[NSBundle mainBundle] pathForResource:@"orderOrReseverData" ofType:@"plist"];
        NSArray *tempArray = [NSArray arrayWithContentsOfFile:path];
        
        NSMutableArray *tempMutableArray = [NSMutableArray array];
        
        for (int i = 0; i< tempArray.count; i++) {
            YNLevelModel *levelModel = [[YNLevelModel alloc] initWithDictionary:tempArray[i]];
            
            levelModel.firstIndex = i;
            [tempMutableArray addObject:levelModel];
        }
        
        
        _topDataArray = [NSArray arrayWithArray:tempMutableArray];
    }
    
    return _topDataArray;
}

@end
