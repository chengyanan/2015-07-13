//
//  UITextField+LeftAndRightView.h
//  2015-07－13
//
//  Created by 农盟 on 15/7/14.
//  Copyright (c) 2015年 YN. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UITextField (LeftAndRightView)

- (void)leftImageViewName:(NSString *)imageName rightView:(UIView *)rightView placeHolder:(NSString *)placeHolder keyBoardType:(UIKeyboardType)keyBoardType;
@end
