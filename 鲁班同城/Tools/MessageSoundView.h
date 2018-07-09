//
//  MessageSoundView.h
//  鲁班同城
//
//  Created by apple on 2018/7/9.
//  Copyright © 2018年 Mac. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface MessageSoundView : UIView

@property (strong,nonatomic) UIButton* soundButt;
//
@property (strong,nonatomic) UILabel *soundTimeLabel;

- (void)adjustSoundView;

- (void)startVoiceAnimation;

- (void)stopVoiceAnimation;

- (void)giveTimeToSoundView:(NSString*)timeStr;


@end
