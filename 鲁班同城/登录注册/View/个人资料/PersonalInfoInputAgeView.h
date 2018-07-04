//
//  PersonalInfoInputAgeView.h
//  鲁班同城
//
//  Created by apple on 2018/7/4.
//  Copyright © 2018年 Mac. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "OwnTextField.h"

@interface PersonalInfoInputAgeView : UIView

@property (strong,nonatomic) UIImageView *leftImageView;

@property (strong,nonatomic) UILabel *ageLabel;

@property (strong,nonatomic) OwnTextField *rightTextField;

- (void)addOwnConstraints:(UIImage *)iconImage;

@property (copy,nonatomic) void (^backButtBlock)(UITextField *textField);


@end
