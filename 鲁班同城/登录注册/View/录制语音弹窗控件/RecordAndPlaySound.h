//
//  RecordAndPlaySound.h
//  鲁班同城
//
//  Created by apple on 2018/8/14.
//  Copyright © 2018年 Mac. All rights reserved.
//

#import <Foundation/Foundation.h>

#import "ViewController.h"
//语音
#import <AudioToolbox/AudioToolbox.h>
#import <AVFoundation/AVFoundation.h>


@interface RecordAndPlaySound : NSObject

//录制的wav url
@property (strong,nonatomic) NSURL *WavsoundFileUrl;

//录制的wav 数据
@property (strong,nonatomic) NSData *WavsoundData;
//转换的amr Data
@property (strong,nonatomic) NSData *amrSoundData;


@property (strong,nonatomic) AVAudioPlayer *audioPlayer;

@property (assign,nonatomic) float recordTime;

//
- (instancetype)init:(id<AVAudioRecorderDelegate>)targetDelegate plyerDelegate:(id<AVAudioPlayerDelegate>)targetDelegate2;

//
- (void)startRecord;


- (void)endRecord;

- (void)playSound:(NSData*)soundData;

- (void)stopPlay;

@end
