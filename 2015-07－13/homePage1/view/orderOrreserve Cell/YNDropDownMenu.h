//
//  YNDropDownMenu.h
//  2015-07－13
//
//  Created by 农盟 on 15/7/22.
//  Copyright (c) 2015年 YN. All rights reserved.
//

#import <UIKit/UIKit.h>

@class YNDropDownMenu;

@protocol YNDropDownMenuDataSource <NSObject>



@end


@protocol YNDropDownMenuDelegate <NSObject>



@end

@interface YNDropDownMenu : UIView

@property (nonatomic, weak) id <YNDropDownMenuDataSource> dataSource;
@property (nonatomic, weak) id <YNDropDownMenuDelegate> delegate;


@property (nonatomic, strong) UIColor *indicatorColor;
@property (nonatomic, strong) UIColor *textColor;
@property (nonatomic, strong) UIColor *separatorColor;

@property (nonatomic, strong) NSArray *menuTitleArray;

@property (nonatomic, strong) NSArray *dataArray;

@end
