//
//  UIColor+Color.h
//  Objective-C
//
//  Created by S_Line on 2018/5/4.
//  Copyright © 2018年 S_Line. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UIColor (Color)

+ (UIColor *)colorWithHex:(uint) hex alpha:(CGFloat)alpha;
+ (UIColor *)colorWithHex:(NSUInteger)hex;
+ (UIColor *)colorWithHexString:(NSString *)hexString;

@end
