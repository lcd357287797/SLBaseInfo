//
//  NSTimer+Category.m
//  Objective-C
//
//  Created by S_Line on 2018/8/30.
//  Copyright © 2018年 S_Line. All rights reserved.
//

#import "NSTimer+Category.h"

@implementation NSTimer (Category)

+ (NSTimer *)sl_scheduledTimerWithTimeInterval:(NSTimeInterval)inerval repeats:(BOOL)repeats block:(void(^)(NSTimer *timer))block {
    return [NSTimer scheduledTimerWithTimeInterval:inerval target:self selector:@selector(sl_blcokInvoke:) userInfo:[block copy] repeats:repeats];

}

+ (NSTimer *)sl_timerWithTimeInterval:(NSTimeInterval)ti userInfo:(nullable id)userInfo repeats:(BOOL)repeats block:(void(^)(NSTimer *timer))block {
    return [NSTimer timerWithTimeInterval:ti target:self selector:@selector(sl_blcokInvoke:) userInfo:[block copy] repeats:repeats];
}

+ (void)sl_blcokInvoke:(NSTimer *)timer {
    
    void (^block)(NSTimer *timer) = timer.userInfo;
    
    if (block) {
        block(timer);
    }
}

@end
