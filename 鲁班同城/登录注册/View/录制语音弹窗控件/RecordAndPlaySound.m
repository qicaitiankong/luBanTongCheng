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

@property (weak,nonatomic) id<AVAudioRecorderDelegate> targetRecorderDele;

@property (weak,nonatomic) id<AVAudioPlayerDelegate> targetPlayerDele;

@end

@implementation RecordAndPlaySound

- (instancetype)init:(id<AVAudioRecorderDelegate>)targetDelegate plyerDelegate:(id<AVAudioPlayerDelegate>)targetDelegate2
{
    self = [super init];
    if (self) {
        self.targetRecorderDele = targetDelegate;
        self.targetPlayerDele = targetDelegate2;
    }
    return self;
}


- (void)setAudioSession{
    NSString *wavPathStr = [[ShareHomePath GetShareHome] getWavSoundPath];
    self.WavsoundFileUrl = [NSURL fileURLWithPath:wavPathStr];
    
    AVAudioSession *audioSession = [AVAudioSession sharedInstance];
    [audioSession setCategory:AVAudioSessionCategoryPlayAndRecord error:nil];
   
    [audioSession overrideOutputAudioPort:AVAudioSessionPortOverrideSpeaker error:nil];
     [audioSession setActive:YES error:nil];
    //
    NSDictionary *recordFormat = @{AVSampleRateKey : @(8000.f),
                                   AVFormatIDKey : @(kAudioFormatLinearPCM),
                                   AVLinearPCMBitDepthKey : @(16),
                                   AVNumberOfChannelsKey : @(1),
                                   AVEncoderAudioQualityKey : @(AVAudioQualityHigh)};
    
    self.recorder = [[AVAudioRecorder alloc] initWithURL:self.WavsoundFileUrl settings:recordFormat error:nil];
    self.recorder.delegate = self.targetRecorderDele;
    self.recorder.meteringEnabled = YES;
    //
}

- (void)startRecord
{
    NSLog(@"！！！！！！！！！！！！！！！startRecord");
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
        self.recordTime = self.recorder.currentTime;
        NSLog(@"录音时间:%f",self.recordTime);
         [self.recorder stop];
        NSLog(@"self.WavsoundFileUrl=%@",self.WavsoundFileUrl);
        self.WavsoundData = [NSData dataWithContentsOfURL:self.WavsoundFileUrl];
        [AudioConverter convertWavToAmrAtPath:[[ShareHomePath GetShareHome]getWavSoundPath] amrSavePath:[[ShareHomePath GetShareHome]getAmrSoundPath] asynchronize:NO completion:^(BOOL success, NSString * _Nullable resultPath) {
            self.amrSoundData = [NSData dataWithContentsOfFile:resultPath];
        }];
        //
        NSLog(@"录音停止");
        BOOL deleteSuc = [self.recorder deleteRecording];
        //再次清空包括amr文件
        [self cleanSoundOnFile];
        if (deleteSuc){
            NSLog(@"录音停止本地文件删除成功");
        }else{
            NSLog(@"录音停止本地文件删除失败");
        }
        //
        NSLog(@"\n\n\n\n\n\n\n\\n转换后的amr data %@",self.amrSoundData);
    }
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
        player.volume = 1.0;
        player.delegate = self.targetPlayerDele;
        self.audioPlayer = player;
        [self.audioPlayer play];
    }
}

- (void)stopPlay{
    if (self.audioPlayer.playing) {
        [self.audioPlayer stop];
    }
    if (self.recorder){
        [self.recorder stop];
    }
}
//清空文件中的语音
- (void)cleanSoundOnFile{
    NSDictionary *dict = @{};
    [dict writeToFile:[[ShareHomePath GetShareHome]getAmrSoundPath] atomically:YES];
     [dict writeToFile:[[ShareHomePath GetShareHome]getWavSoundPath] atomically:YES];
}


-(void)dealloc{
    if (self.audioPlayer){
        [self.audioPlayer stop];
    }
    if(self.recorder){
        [self.recorder stop];
    }
    self.recorder = nil;
    self.audioPlayer = nil;
    
}





@end
