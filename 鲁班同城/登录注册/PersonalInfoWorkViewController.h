//
//  PersonalInfoWorkViewController.h
//  鲁班同城
//
//  Created by apple on 2018/7/4.
//  Copyright © 2018年 Mac. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "OwnPersonalInfoModel.h"
#import "BasePersonalInfoViewController.h"

@interface PersonalInfoWorkViewController : BasePersonalInfoViewController

//修改前的模型
@property (strong,nonatomic) OwnPersonalInfoModel *orinalInfoModel;
//修改中存储的模型
@property (strong,nonatomic) OwnPersonalInfoModel *amendingInfoModel;

@end
