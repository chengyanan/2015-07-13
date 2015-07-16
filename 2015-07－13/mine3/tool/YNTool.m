//
//  YNTool.m
//  2015-07－13
//
//  Created by 农盟 on 15/7/15.
//  Copyright (c) 2015年 YN. All rights reserved.
//

#import "YNTool.h"
#import <MBProgressHUD.h>

@implementation YNTool

+ (BOOL)isPhoneNumber:(NSString *)phoneNumber {
    
    if (phoneNumber.length != 11) {
        return NO;
    }
    
    NSString *regular = @"^1[3|4|5|7|8|9][0-9]{9}$";
    
    NSRegularExpression *regex = [NSRegularExpression regularExpressionWithPattern:regular options:NSRegularExpressionAnchorsMatchLines error:NULL];
    
    NSTextCheckingResult *resault = [regex firstMatchInString:phoneNumber options:NSMatchingReportProgress range:NSMakeRange(0, phoneNumber.length)];
    
//    NSPredicate *numberPre = [NSPredicate predicateWithFormat:regular];
    
    NSRange range = resault.range;
    
    return (range.length == 11);
}

@end
