//
//  PersonalInfoVideoViewController.h
//  鲁班同城
//
//  Created by apple on 2018/7/4.
//  Copyright © 2018年 Mac. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "BasePersonalInfoViewController.h"
#import "TakePhotoBaseViewController.h"
#import "OwnPersonalInfoModel.h"

@interface PersonalInfoVideoViewController : TakePhotoBaseViewController

//修改前的模型
@property (strong,nonatomic) OwnPersonalInfoModel *orinalInfoModel;

//修改中存储的模型
@property (strong,nonatomic) OwnPersonalInfoModel *amendingInfoModel;

@end
