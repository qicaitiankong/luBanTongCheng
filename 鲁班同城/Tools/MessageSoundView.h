//
//  MessageSoundView.h
//  鲁班同城
//
//  Created by apple on 2018/7/9.
//  Copyright © 2018年 Mac. All rights reserved.
//

#import <UIKit/UIKit.h>

#import <AudioToolbox/AudioToolbox.h>
#import <AVFoundation/AVFoundation.h>


@interface MessageSoundView : UIView

@property (strong,nonatomic) UIButton* soundButt;
//
@property (strong,nonatomic) UILabel *soundTimeLabel;

@property (copy,nonatomic) void (^clickSoundViewBlock)(void);

@property (copy,nonatomic) void (^stopVoiceBlock)(void);


- (void)adjustSoundView;


- (void)giveTimeToSoundViewAndPlay:(NSString*)timeStr wavData:(NSData*)data;

- (void)stopVoiceVAnimation;

@end
