//
//  PersonalInfoTechnologyChooseViewController.h
//  鲁班同城
//
//  Created by apple on 2018/7/5.
//  Copyright © 2018年 Mac. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "BasePersonalInfoViewController.h"
//派单页面技能选择也会用


@interface PersonalInfoTechnologyChooseViewController :BasePersonalInfoViewController
//1:技能 2:工作
@property (assign,nonatomic) NSInteger kindTag;

@property (copy,nonatomic) void (^selectedBlock)(NSMutableArray * modelArr);

@end
