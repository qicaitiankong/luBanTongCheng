//
//  messagwSoundView.h
//  KR管理系统
//
//  Created by corill002 on 2017/9/30.
//  Copyright © 2017年 霸枪001. All rights reserved.
//录完音后显示的控件

#import <UIKit/UIKit.h>

@interface messagwSoundView : UIView

@property (strong,nonatomic) UIButton* soundButt;
//
@property (strong,nonatomic) UILabel *soundTimeLabel;

- (void)adjustSoundView;

- (void)startVoiceAnimation;

- (void)stopVoiceAnimation;

- (void)giveTimeToSoundView:(NSString*)timeStr;

@end
