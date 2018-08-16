//
//  OwnPersonalIntroduceTableViewCell.h
//  鲁班同城
//
//  Created by apple on 2018/8/16.
//  Copyright © 2018年 Mac. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "MessageSoundView.h"
#import "OwnPersonalInfoModel.h"

@interface OwnPersonalIntroduceTableViewCell : UITableViewCell

@property (strong,nonatomic) UILabel *introduceLabel;


@property (strong,nonatomic) MessageSoundView *soundView;

@property (strong,nonatomic) OwnPersonalInfoModel *model;

@end
