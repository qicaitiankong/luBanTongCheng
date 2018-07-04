//
//  PersonalInfoInputNameView.h
//  鲁班同城
//
//  Created by apple on 2018/7/4.
//  Copyright © 2018年 Mac. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "OwnTextField.h"
#import "PersonalInfoAddSoundButtView.h"


@interface PersonalInfoInputNameView : UIView

@property (strong,nonatomic) UIImageView *leftImageView;

@property (strong,nonatomic) UILabel *nameLabel;

@property (strong,nonatomic) OwnTextField *rightTextField;

@property (strong,nonatomic) PersonalInfoAddSoundButtView *addSoundView;

- (void)addOwnConstraints:(UIImage *)iconImage;

- (void)displayTextOrYuYin:(BOOL)isYuYin;


@end
