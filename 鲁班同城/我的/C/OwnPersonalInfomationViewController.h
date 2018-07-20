//
//  OwnPersonalInfomationViewController.h
//  鲁班同城
//
//  Created by apple on 2018/7/6.
//  Copyright © 2018年 Mac. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "BaseHiddenNavAndTabBarViewController.h"


@interface OwnPersonalInfomationViewController : BaseHiddenNavAndTabBarViewController
//0默认个人资料使用，否则排行榜使用
@property (assign,nonatomic) NSInteger vcKind;


@end
