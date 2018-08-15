//
//  PersonalInfoAddSoundButtView.h
//  鲁班同城
//
//  Created by apple on 2018/7/4.
//  Copyright © 2018年 Mac. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface PersonalInfoAddSoundButtView : UIView

@property (copy,nonatomic) void(^addSoundClickBlock)(void);

//报价中使用，其他用的是系统的initWithFrame
- (instancetype)initWithSecondUseFrame:(CGRect)frame;


- (void)addOwnContraints;



- (void)changeToAddSoundState;

- (void)changeToPlaySoundState;


@end
