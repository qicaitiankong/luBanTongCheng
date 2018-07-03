//
//  MyInfoTableHeaderView.h
//  鲁班同城
//
//  Created by apple on 2018/7/3.
//  Copyright © 2018年 Mac. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "WithDrawView.h"


@interface MyInfoTableHeaderView : UIView

@property (strong,nonatomic) UIImageView *userImageView;

@property (strong,nonatomic) UILabel *userNameLabel;
//佣金
@property (strong,nonatomic) UILabel *commissionLabel;

@property (strong,nonatomic) UILabel *commissionTipLabel;

@property (strong,nonatomic) WithDrawView *withDrawView;


@end
