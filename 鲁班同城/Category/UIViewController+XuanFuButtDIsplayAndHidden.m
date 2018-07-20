//
//  UIViewController+XuanFuButtDIsplayAndHidden.m
//  鲁班同城
//
//  Created by apple on 2018/7/19.
//  Copyright © 2018 Mac. All rights reserved.
//

#import "UIViewController+XuanFuButtDIsplayAndHidden.h"
#import "FirstPageViewController.h"

@implementation UIViewController (XuanFuButtDIsplayAndHidden)

- (void)displayXuanFuButt{
    AppDelegate *app = (AppDelegate*) [UIApplication sharedApplication].delegate;
    UINavigationController *firstNav = app.navArr[0];
    FirstPageViewController *firstPageVC = firstNav.viewControllers[0];
    if (firstPageVC.xuanFubuttView){
        firstPageVC.xuanFubuttView.hidden = NO;
    }
}
- (void)hiddenXuanFuButt{
    AppDelegate *app = (AppDelegate*) [UIApplication sharedApplication].delegate;
    UINavigationController *firstNav = app.navArr[0];
    FirstPageViewController *firstPageVC = firstNav.viewControllers[0];
    if (firstPageVC.xuanFubuttView){
        firstPageVC.xuanFubuttView.hidden = YES;
    }
}

@end
