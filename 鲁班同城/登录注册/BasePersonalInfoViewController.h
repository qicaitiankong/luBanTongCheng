//
//  BasePersonalInfoViewController.h
//  鲁班同城
//
//  Created by apple on 2018/7/4.
//  Copyright © 2018年 Mac. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface BasePersonalInfoViewController : UIViewController

@property (copy,nonatomic) void (^leftBarbuttBlock)(void);

@property (copy,nonatomic) void (^rightBarbuttBlock)(void);


@end
