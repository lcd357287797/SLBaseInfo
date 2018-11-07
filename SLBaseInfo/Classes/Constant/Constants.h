//
//  Constants.h
//  Objective-C
//
//  Created by S_Line on 2018/5/4.
//  Copyright © 2018年 S_Line. All rights reserved.
//

#ifndef Constants_h
#define Constants_h

#ifdef DEBUG
//# define SLog(fmt, ...) NSLog((@"\n[文件名:%s]" "\n[函数名:%s]" "\n[行号:%d]\n\n" fmt "\n\n"), __FILE__, __FUNCTION__, __LINE__, ##__VA_ARGS__);
# define SLog(fmt, ...) NSLog((fmt), ##__VA_ARGS__);
#else
# define SLog(...);
#endif

extern CGFloat const kMargin_Horizontal;
extern CGFloat const kMargin_Ten_Point;

extern CGFloat kScreenWidth;
extern CGFloat kScreenHeight;
extern CGFloat kStatusBarHeight;
extern CGFloat kNavigationBarHeight;
extern CGFloat kSafeBottomMargin;

extern BOOL IS_IPHONE_X;

extern CGFloat kOnePixelWidth;
extern CGFloat kOnePixelAdjustOffset;

extern NSInteger const navBarBackImageViewTag;

#endif /* Constants_h */
