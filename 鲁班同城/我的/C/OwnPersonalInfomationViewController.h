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

//要查看的用户个人userid
@property (assign,nonatomic) NSNumber *targetUserId;


@end
