//
//  SLNavigationController.m
//  Objective-C
//
//  Created by S_Line on 2018/5/4.
//  Copyright © 2018年 S_Line. All rights reserved.
//

#import "SLNavigationController.h"

@interface SLNavigationController ()

@end

@implementation SLNavigationController

- (void)viewDidLoad {
    [super viewDidLoad];
}

- (UIViewController *)childViewControllerForStatusBarStyle{
    return self.topViewController;
}

@end
