//
//  YNCallOutContentView.h
//  2015-07－13
//
//  Created by 农盟 on 15/7/31.
//  Copyright (c) 2015年 YN. All rights reserved.
//

#import <UIKit/UIKit.h>
@protocol YNCallOutContentViewDelegate <NSObject>

- (void)callOutContentViewTaped;

@end
@interface YNCallOutContentView : UIView

@property (nonatomic, assign) id<YNCallOutContentViewDelegate> delegate;

@end
