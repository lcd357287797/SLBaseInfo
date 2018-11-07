//
//  SLBaseViewController.h
//  Objective-C
//
//  Created by S_Line on 2018/5/3.
//  Copyright © 2018年 S_Line. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface SLBaseViewController : UIViewController

/* 设置statusBar的状态 */
@property (assign, nonatomic) UIStatusBarStyle statusBarStyle;
/**
 Default is false
 是否将导航栏设为透明, 如果为true, 导航栏将变成透明, 同时所有对导航栏的颜色, 图片操作无效
 */
@property (nonatomic, assign) BOOL hideNavBarBack;
/* 隐藏导航栏, 完全的隐藏, 返回按钮, title也会隐藏 */
@property (nonatomic, assign) BOOL hideNavBar;
/* 导航栏的背景颜色, 默认是白色 */
@property (nonatomic, strong) UIColor *navColor;
/* 导航栏的背景图片, 设置了背景图片后设置背景色无效, 默认是nil */
@property (nonatomic, strong) UIImage *navImage;
/* 导航栏分割线的颜色, 默认是灰色 */
@property (nonatomic, strong) UIColor *navSepLineColor;
/* 导航栏的标题, 只支持一行 */
@property (nonatomic, copy) NSString *navTitle;
/* 导航栏带格式的标题, 支持两行 */
@property (nonatomic, copy) NSAttributedString *attTitle;
/**
 设置导航栏两边的按钮, 规则
 1. 如果设置了buttonImage, 则不考虑其他因素, 直接用图片作为返回按钮
 2. 如果没有buttonImage, 但是有buttonTitle, 则用buttonTitle作为返回按钮
 3. 如果buttonImage和buttonTitle都没有设置, 则使用默认的"nav_back.png"图片作为返回按钮, 右侧按钮默认不展示
 4. 如果左侧返回按钮不想要展示任何东西, 需要将buttonTitle传入" "字符串, 同时重写navBack方法
 */
/* 左侧返回按钮设置为文字 */
@property (nonatomic, copy) NSString *leftTitle;
/* 左侧返回按钮设置为图片 */
@property (nonatomic, strong) UIImage *leftImage;
/* 左侧按钮的图片 */
@property (nonatomic, strong) UIColor *leftColor;
/* 右侧返回按钮设置为文字 */
@property (nonatomic, copy) NSString *rightTitle;
/* 右侧返回按钮设置为图片 */
@property (nonatomic, strong) UIImage *rightImage;
/* 右侧按钮的图片 */
@property (nonatomic, strong) UIColor *rightColor;

#pragma mark ----- 导航栏点击事件
/* 左侧返回按钮点击事件 */
- (void)navBack;
/* 右侧按钮点击事件 */
- (void)navNext;

#pragma mark ----- app状态监听事件
/* 应用即将从后台进入前台时调用(在applicationDidBecomeActive之前) */
- (void)applicationWillEnterForeground;
/* 应用进入后台后调用 */
- (void)applicationDidEnterBackground;
/* 应用从后台进入前台后调用 */
- (void)applicationDidBecomeActive;
/* 应用即将进入后台前调用(在applicationDidEnterBackground之前) */
- (void)applicationWillResignActive;

#pragma mark ----- 仅仅是申明方法, 空白的实现, 方便快速创建
- (void)initNavBar;
- (void)initData;
- (void)initView;

@end
