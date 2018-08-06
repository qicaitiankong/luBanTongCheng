//
//  PersonalInfoInputAgeView.h
//  鲁班同城
//
//  Created by apple on 2018/7/4.
//  Copyright © 2018年 Mac. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "OwnTextField.h"
#import "PersonalInfoAddSoundButtView.h"

@interface PersonalInfoInputAgeView : UIView

@property (strong,nonatomic) UIImageView *leftImageView;

@property (strong,nonatomic) UILabel *ageLabel;

@property (strong,nonatomic) OwnTextField *rightTextField;

@property (strong,nonatomic) PersonalInfoAddSoundButtView *addSoundView;

@property (copy,nonatomic) void (^backButtBlock)(UITextField *textField);

@property (strong,nonatomic) UIImageView *flagImageView;

- (void)addOwnConstraints:(UIImage *)iconImage;

- (void)displayTextOrYuYin:(BOOL)isYuYin;


- (void)hiddenBottomLine:(BOOL)hid;



@end
