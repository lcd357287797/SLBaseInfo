//
//  SLBaseViewController.m
//  Objective-C
//
//  Created by S_Line on 2018/5/3.
//  Copyright © 2018年 S_Line. All rights reserved.
//

#import "SLBaseViewController.h"

#import <UIKit/UIKit.h>

@interface SLBaseViewController ()<UIGestureRecognizerDelegate>

@property (nonatomic, weak) UIImageView *navBarBackImageView;
@property (nonatomic, weak) UIImageView *sepLineImageView;
@property (nonatomic, weak) UILabel *titleLabel;

@end

@implementation SLBaseViewController

- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    [self.view bringSubviewToFront:self.navBarBackImageView];
    self.automaticallyAdjustsScrollViewInsets = NO;
    
    if (!self.hideNavBar) {
        [self.navigationController setNavigationBarHidden:self.hideNavBar animated:true];
    }
}

- (void)viewDidAppear:(BOOL)animated {
    [super viewDidAppear:animated];
    
    // 设置侧滑返回手势的代理
    self.navigationController.interactivePopGestureRecognizer.delegate = self;
    
    if (self.hideNavBar) {
        [self.navigationController setNavigationBarHidden:self.hideNavBar animated:true];
    }
}

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self resetNavBar];
    
    [self initBaseView];
    
    [self addNotifications];
}

- (void)initBaseView {
    self.hidesBottomBarWhenPushed = true;
    self.view.backgroundColor = [UIColor colorWithRed:238.0/255.0 green:238.0/255.0 blue:238.0/255.0 alpha:1];
}

#pragma mark ----- 添加监听事件
- (void)addNotifications {
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(applicationWillEnterForeground) name:UIApplicationWillEnterForegroundNotification object:nil];
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(applicationDidEnterBackground) name:UIApplicationDidEnterBackgroundNotification object:nil];
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(applicationDidBecomeActive) name:UIApplicationDidBecomeActiveNotification object:nil];
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(applicationWillResignActive) name:UIApplicationWillResignActiveNotification object:nil];
}

#pragma mark ----- 导航的相关设定
/**
 重置NavBar
 */
- (void)resetNavBar {
    
    UILabel *titleLabel = [[UILabel alloc] init];
    titleLabel.font = [UIFont boldSystemFontOfSize:17];
    titleLabel.textColor = [UIColor blackColor];
    titleLabel.textAlignment = NSTextAlignmentCenter;
    self.titleLabel = titleLabel;
    self.navigationItem.titleView = titleLabel;
    [self setNavTitleLabel];
    
    for (UIView *view in self.navigationController.navigationBar.subviews) {
#if DEBUG
        NSLog(@"self.navigationController.navigationBar.subviews.class: %@", [view class]);
#endif
        NSString *viewClassStr = NSStringFromClass([view class]);
        if ([viewClassStr isEqualToString:@"_UIBarBackground"] || [viewClassStr isEqualToString:@"_UINavigationBarBackground"]) {
            for (UIView *subView in view.subviews) {
#if DEBUG
                NSLog(@"_UIBarBackground.subview.class: %@", [subView class]);
#endif
                NSString *subViewClassStr = NSStringFromClass([subView class]);
                if ([subViewClassStr isEqualToString:@"UIVisualEffectView"] || [subViewClassStr isEqualToString:@"_UIBackdropView"]) {
                    // 将原本NavBar的毛玻璃效果给去掉
                    subView.alpha = 0;
                }
            }
        }
    }
    // 去除本来分割线的颜色
    self.navigationController.navigationBar.shadowImage = [UIImage new];
    [self.navigationController.navigationBar setBackgroundImage:[UIImage new] forBarMetrics:UIBarMetricsDefault];

    
    UIImageView *navBarBackImageView = [[UIImageView alloc] initWithFrame:CGRectMake(0, 0, [UIScreen mainScreen].bounds.size.width, [UIScreen mainScreen].bounds.size.height)];
    navBarBackImageView.tag = 999999;
    self.navBarBackImageView = navBarBackImageView;
    [self.view addSubview:navBarBackImageView];
    
    UIImageView *sepLineImageView = [[UIImageView alloc] initWithFrame:CGRectMake(0, navBarBackImageView.bounds.size.height - 1.0 / [UIScreen mainScreen].scale, navBarBackImageView.bounds.size.width, 1.0 / [UIScreen mainScreen].scale)];
    sepLineImageView.image = [self imageWithColor:[UIColor colorWithRed:204.0/255.0 green:204.0/255.0 blue:204.0/255.0 alpha:1]];
    sepLineImageView.contentMode = UIViewContentModeScaleToFill;
    self.sepLineImageView = sepLineImageView;
    [navBarBackImageView addSubview:sepLineImageView];
    
    [self setNavBarBackImageViewImage];
    [self setNavSepLine];
    
    [self setLeftBarButtonItems];
    [self setRightBarButtonItems];
}

/**
 设置新的NavBar的背景ImageView的image
 */
- (void)setNavBarBackImageViewImage {
    UIImage *image = [self imageWithColor:[UIColor whiteColor]];
    if (self.navColor) {
        image = [self imageWithColor:self.navColor];
    } else if (self.navImage) {
        image = self.navImage;
    }
    dispatch_async(dispatch_get_main_queue(), ^{
        self.navBarBackImageView.image = image;
    });
}

/**
 设置NavBar的Separator的颜色
 */
- (void)setNavSepLine {
    UIImage *shadowImage = [self imageWithColor:[UIColor colorWithRed:204.0/255.0 green:204.0/255.0 blue:204.0/255.0 alpha:1]];
    if (self.navSepLineColor) {
        shadowImage = [self imageWithColor:self.navSepLineColor];
    }
    self.sepLineImageView.image = shadowImage;
}

- (void)setNavTitleLabel {
    if (!self.titleLabel) {
        return;
    }
    
    if (self.attTitle) {
        self.titleLabel.numberOfLines = 2;
        self.titleLabel.attributedText = self.attTitle;
    } else if (self.navTitle) {
        self.titleLabel.numberOfLines = 1;
        self.titleLabel.text = self.navTitle;
    } else {
        self.titleLabel.numberOfLines = 1;
        self.titleLabel.text = @"";
    }
    
    [self.titleLabel sizeToFit];
}

/**
 设置左边的按钮, 规则
 1. 如果设置了leftImage, 则不考虑其他因素, 直接用图片作为返回按钮
 2. 如果没有leftImage, 但是有leftTitle, 则用leftTitle作为返回按钮
 3. 如果leftImage和leftTitle都没有设置,则使用默认的nav_back图片作为返回按钮
 4. 如果左侧返回按钮不想要展示任何东西, 需要将leftTitle传入" "字符串, 同时重写navBack方法
 */
- (void)setLeftBarButtonItems {
    UIBarButtonItem *item = [[UIBarButtonItem alloc] initWithImage:[UIImage imageNamed:@"nav_back"] style:UIBarButtonItemStyleDone target:self action:@selector(navBack)];
    if (self.leftImage) {
        item = [[UIBarButtonItem alloc] initWithImage:self.leftImage style:UIBarButtonItemStylePlain target:self action:@selector(navBack)];
    } else if (self.leftTitle && self.leftTitle.length > 0) {
        item = [[UIBarButtonItem alloc] initWithTitle:self.leftTitle style:UIBarButtonItemStylePlain target:self action:@selector(navBack)];
    }
    self.navigationItem.leftBarButtonItem = item;
    self.navigationItem.leftBarButtonItem.tintColor = self.leftColor ? self.leftColor : [UIColor blackColor];
}

/**
 设置左边的按钮, 规则
 1. 如果设置了rightImage, 则不考虑其他因素, 直接用图片作为返回按钮
 2. 如果没有rightImage, 但是有rightTitle, 则用rightTitle作为返回按钮
 3. 如果左侧返回按钮不想要展示任何东西, 需要将rightTitle传入" "字符串, 同时重写navBack方法
 */
- (void)setRightBarButtonItems {
    UIBarButtonItem *item = nil;
    if (self.rightImage) {
        item = [[UIBarButtonItem alloc] initWithImage:self.rightImage style:UIBarButtonItemStylePlain target:self action:@selector(navNext)];
    } else if (self.rightTitle && self.rightTitle.length > 0) {
        item = [[UIBarButtonItem alloc] initWithTitle:self.rightTitle style:UIBarButtonItemStylePlain target:self action:@selector(navNext)];
    }
    self.navigationItem.rightBarButtonItem = item;
    self.navigationItem.rightBarButtonItem.tintColor = self.rightColor ? self.rightColor : [UIColor blackColor];
}

#pragma mark ----- get和set方法
- (void)setStatusBarStyle:(UIStatusBarStyle)statusBarStyle {
    NSLog(@"setStatusBarStyle: %ld", (long)statusBarStyle);
    _statusBarStyle = statusBarStyle;
    [self setNeedsStatusBarAppearanceUpdate];
}

- (void)setNavColor:(UIColor *)navColor {
    if (!self.hideNavBarBack) {
        _navColor = navColor;
        [self setNavBarBackImageViewImage];
    }
}

- (void)setNavImage:(UIImage *)navImage {
    if (!self.hideNavBarBack) {
        _navImage = navImage;
        [self setNavBarBackImageViewImage];
    }
}

- (void)setNavSepLineColor:(UIColor *)navSepLineColor {
    if (!self.hideNavBarBack) {
        _navSepLineColor = navSepLineColor;
        [self setNavSepLine];
    }
}

- (void)setHideNavBarBack:(BOOL)hideNavBarBack {
    self.navSepLineColor = [UIColor clearColor];
    self.navColor = [UIColor clearColor];
    self.navImage = nil;
    _hideNavBarBack = hideNavBarBack;
}

- (void)setHideNavBar:(BOOL)hideNavBar {
    self.hideNavBarBack = hideNavBar;
    _hideNavBar = hideNavBar;
}

- (void)setNavTitle:(NSString *)navTitle {
    _navTitle = navTitle;
    [self setNavTitleLabel];
}

- (void)setAttTitle:(NSAttributedString *)attTitle {
    _attTitle = attTitle;
    [self setNavTitleLabel];
}

- (void)setLeftTitle:(NSString *)leftTitle {
    _leftTitle = leftTitle;
    [self setLeftBarButtonItems];
}

- (void)setLeftImage:(UIImage *)leftImage {
    _leftImage = leftImage;
    [self setLeftBarButtonItems];
}

- (void)setLeftColor:(UIColor *)leftColor {
    _leftColor = leftColor;
    [self setLeftBarButtonItems];
}

- (void)setRightTitle:(NSString *)rightTitle {
    _rightTitle = rightTitle;
    [self setRightBarButtonItems];
}

- (void)setRightImage:(UIImage *)rightImage {
    _rightImage = rightImage;
    [self setRightBarButtonItems];
}

- (void)setRightColor:(UIColor *)rightColor {
    _rightColor = rightColor;
    [self setRightBarButtonItems];
}

#pragma mark ----- 点击事件
- (void)navBack {
    if (self.navigationController.childViewControllers != nil && self.navigationController.childViewControllers.count > 1) {
        [self.navigationController popViewControllerAnimated:true];
    }
}

- (void)navNext {
    NSLog(@"导航栏右边的按钮点击了");
}

#pragma mark ----- UIGestureRecognizerDelegate
- (BOOL)gestureRecognizerShouldBegin:(UIGestureRecognizer *)gestureRecognizer {
    
    if (self.navigationController && self.navigationController.childViewControllers && self.navigationController.childViewControllers.count == 1) {
        if (gestureRecognizer == self.navigationController.interactivePopGestureRecognizer) {
            return false;
        }
    }
    
    return true;
}

#pragma mark ----- 监听事件响应方法
/**
 应用即将从后台进入前台时调用(在applicationDidBecomeActive之前)
 */
- (void)applicationWillEnterForeground {
    NSLog(@"applicationWillEnterForeground");
}

/**
 应用进入后台后调用
 */
- (void)applicationDidEnterBackground {
    NSLog(@"applicationDidEnterBackground");
}

/**
 应用从后台进入前台后调用
 */
- (void)applicationDidBecomeActive {
    NSLog(@"applicationDidBecomeActive");
}

/**
 应用即将进入后台前调用(在applicationDidEnterBackground之前)
 */
- (void)applicationWillResignActive {
    NSLog(@"applicationWillResignActive");
}

- (UIStatusBarStyle)preferredStatusBarStyle {
    return self.statusBarStyle;
}

#pragma mark ----- 仅仅是申明方法, 空白的实现, 方便快速创建
- (void)initNavBar{}
- (void)initData{}
- (void)initView{}

- (void)dealloc {
    NSLog(@"dealloc: %@ 释放了", [self class]);
    [[NSNotificationCenter defaultCenter] removeObserver:self];
}

#pragma mark ----- 便利方法
- (UIImage *)imageWithColor:(UIColor *)color {
    CGSize size = CGSizeMake(1, 1);
    UIGraphicsBeginImageContextWithOptions(size, NO, 0);
    CGContextRef context = UIGraphicsGetCurrentContext();
    CGContextSetFillColorWithColor(context, [color CGColor]);
    CGContextFillRect(context, CGRectMake(0, 0, size.width, size.height));
    UIImage * desImage = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    return desImage;
}

@end
