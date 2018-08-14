//
//  RecordAndPlaySound.h
//  鲁班同城
//
//  Created by apple on 2018/8/14.
//  Copyright © 2018年 Mac. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <AudioToolbox/AudioToolbox.h>
#import <AVFoundation/AVFoundation.h>

@interface RecordAndPlaySound : NSObject<AVAudioRecorderDelegate,AVAudioPlayerDelegate>


//录制的wav 路径
@property (strong,nonatomic) NSURL *WavsoundFileUrl;
//录制的wav 数据
@property (strong,nonatomic) NSData *WavsoundData;

@property (strong,nonatomic) AVAudioPlayer *audioPlayer;

@property (strong,nonatomic) NSString *recordTimeStr;

//
//
- (void)startRecord;


- (void)endRecord;

- (void)playSound:(NSData*)soundData;


@end
