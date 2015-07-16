//
//  YNOrderOrreserveCell.h
//  2015-07－13
//
//  Created by 农盟 on 15/7/16.
//  Copyright (c) 2015年 YN. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface YNOrderOrreserveCell : UITableViewCell

+ (instancetype)orderOrreservecell:(UITableView *)tableview;

@property (nonatomic, strong) NSDictionary *data;
@end
