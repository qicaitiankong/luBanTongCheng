//
//  RecordAndPlaySound.m
//  鲁班同城
//
//  Created by apple on 2018/8/14.
//  Copyright © 2018年 Mac. All rights reserved.
//

#import "RecordAndPlaySound.h"



@interface RecordAndPlaySound ()

@property (strong,nonatomic) AVAudioRecorder *recorder;

@end

@implementation RecordAndPlaySound

- (void)setAudioSession{
    NSString *wavPathStr = [[ShareHomePath GetShareHome] getWavSoundPath];
    self.WavsoundFileUrl = [NSURL URLWithString:wavPathStr];
    
    AVAudioSession *audioSession = [AVAudioSession sharedInstance];
    [audioSession setCategory:AVAudioSessionCategoryPlayAndRecord error:nil];
    [audioSession setActive:YES error:nil];
    
    //[audioSession overrideOutputAudioPort:AVAudioSessionPortOverrideSpeaker error:nil];
    //
    NSDictionary *recordFormat = @{AVSampleRateKey : @(8000.f),
                                   AVFormatIDKey : @(kAudioFormatLinearPCM),
                                   AVLinearPCMBitDepthKey : @(16),
                                   AVNumberOfChannelsKey : @(1),
                                   AVEncoderAudioQualityKey : @(AVAudioQualityHigh)};
    
    self.recorder = [[AVAudioRecorder alloc] initWithURL:self.WavsoundFileUrl settings:recordFormat error:nil];
    self.recorder.delegate = self;
    self.recorder.meteringEnabled = YES;
}

- (void)startRecord
{
    [self setAudioSession];
    //准备录音
    if ([self.recorder prepareToRecord]){
        [self.recorder record];
        NSLog(@"录音开始");
    }else{
        NSLog(@"录音没有开始");
    }
}

- (void)endRecord{
    if (self.recorder){
        self.recordTimeStr = [NSString stringWithFormat:@"%.fs",self.recorder.currentTime];
        [self.recorder stop];
    }
    self.WavsoundData = [NSData dataWithContentsOfURL:self.WavsoundFileUrl];
    
}

//播放

- (void)playSound:(NSData*)soundData{
    [self.recorder stop];
    if (self.audioPlayer.playing) {
        [self.audioPlayer stop];
    }
    if(soundData == nil){
        [SVProgressHUD showErrorWithStatus:@"获取录音数据失败data=nil"];
    }else{
        AVAudioPlayer *player = [[AVAudioPlayer alloc]initWithData:soundData error:nil];
        player.delegate = self;
        player.volume = 1;
        self.audioPlayer = player;
        [self.audioPlayer play];
    }
}

-(void)dealloc{
    self.recorder = nil;
    self.audioPlayer = nil;
}





@end
