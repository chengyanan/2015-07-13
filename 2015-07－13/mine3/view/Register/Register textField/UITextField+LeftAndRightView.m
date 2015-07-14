//
//  UITextField+LeftAndRightView.m
//  2015-07－13
//
//  Created by 农盟 on 15/7/14.
//  Copyright (c) 2015年 YN. All rights reserved.
//

#import "UITextField+LeftAndRightView.h"

@implementation UITextField (LeftAndRightView)

- (void)leftImageViewName:(NSString *)imageName rightView:(UIView *)rightView placeHolder:(NSString *)placeHolder keyBoardType:(UIKeyboardType)keyBoardType {
    
    self.backgroundColor = [UIColor whiteColor];
    self.clearButtonMode = UITextFieldViewModeWhileEditing;

    if (imageName) {
        
        UIImageView *leftView = [[UIImageView alloc] initWithImage:[UIImage imageNamed:imageName]];
        leftView.contentMode = UIViewContentModeScaleAspectFit;
        leftView.frame = CGRectMake(0, 0, 38, 30);
        
        self.leftView = leftView;
        self.leftViewMode = UITextFieldViewModeAlways;
    }
    
    if (rightView) {
        
        self.rightView = rightView;
        self.rightViewMode = UITextFieldViewModeAlways;
    }
    
    if (placeHolder) {
        self.placeholder = placeHolder;
    }
    
    if (keyBoardType) {
        self.keyboardType = keyBoardType;
    }

}

@end
