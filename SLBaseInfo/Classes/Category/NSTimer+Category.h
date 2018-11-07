//
//  NSTimer+Category.h
//  Objective-C
//
//  Created by S_Line on 2018/8/30.
//  Copyright © 2018年 S_Line. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface NSTimer (Category)

+ (NSTimer *)sl_scheduledTimerWithTimeInterval:(NSTimeInterval)inerval repeats:(BOOL)repeats block:(void(^)(NSTimer *timer))block;
+ (NSTimer *)sl_timerWithTimeInterval:(NSTimeInterval)ti userInfo:(nullable id)userInfo repeats:(BOOL)repeats block:(void(^)(NSTimer *timer))block;

@end
