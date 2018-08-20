//
//  MessageSoundView.m
//  鲁班同城
//
//  Created by apple on 2018/7/9.
//  Copyright © 2018年 Mac. All rights reserved.
//

#import "MessageSoundView.h"


@interface MessageSoundView ()<AVAudioPlayerDelegate>{
    NSMutableArray *animationArr;
}

@property (strong,nonatomic) AVAudioPlayer *player;

@end

@implementation MessageSoundView


- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        //
        self.backgroundColor = [UIColor colorWithHexString:@"#74BE50"];
        animationArr = [NSMutableArray array];
        for (int k = 0; k < 3; k ++){
            NSString *imageNameStr = [NSString stringWithFormat:@"SenderVoiceNodePlaying0%d",k + 1];
            UIImage *animationIma = [UIImage imageNamed:imageNameStr];
            [animationArr addObject:animationIma];
        }
        //
        self.soundButt = [UIButton buttonWithType:UIButtonTypeCustom];
        self.soundButt.imageView.animationImages = animationArr;
        self.soundButt.imageView.animationDuration = 1;
        [self.soundButt setImage:animationArr[2] forState:UIControlStateNormal];
        self.soundButt.backgroundColor = self.backgroundColor;
        self.soundButt.frame = CGRectMake(10, 0, frame.size.height * 0.45,frame.size.height * 0.45);
        self.soundButt.center = CGPointMake(self.soundButt.centerX, frame.size.height / 2);
        [self.soundButt addTarget:self action:@selector(clickSoundButt) forControlEvents:UIControlEventTouchUpInside];
        [self addSubview:self.soundButt];
        //
        self.soundTimeLabel = [[CustomeLzhLabel alloc] initWithCustomerParamer:[UIFont getPingFangSCMedium:14] titleColor:[UIColor colorWithHexString:@"#666666"] aligement:0];
        self.soundTimeLabel.frame = CGRectMake(self.soundButt.right + 15, 0, frame.size.width - self.soundButt.right - 30, frame.size.height);
        self.soundTimeLabel.text = @"语音介绍";
        [self addSubview:self.soundTimeLabel];
    }
    return self;
}


- (void)clickSoundButt{
    if (self.clickSoundViewBlock){
        self.clickSoundViewBlock();
    }
}
- (void)startVoiceAnimation{
    if (self.player.isPlaying){
        [SVProgressHUD showInfoWithStatus:@"有其他语音正在播放"];
        return;
    }
    if (NO == self.soundButt.imageView.isAnimating){
        [self.soundButt.imageView startAnimating];
    }
}
- (void)stopVoicePlay{
    //
    [self.player stop];
    //
    [self.soundButt.imageView stopAnimating];
}
//
- (void)giveTimeToSoundViewAndPlay:(NSString*)timeStr wavData:(NSData*)data{
    if (timeStr == nil || [timeStr length] == 0){
        self.soundTimeLabel.text = @"";
    }else{
        NSMutableString *dealTimeStr = [NSMutableString stringWithString:timeStr];
        self.soundTimeLabel.text = dealTimeStr;
    }
    if (self.player.isPlaying){
        [SVProgressHUD showInfoWithStatus:@"有语音正在播放"];
        return;
    }
    //
    self.player = [[AVAudioPlayer alloc]initWithData:data error:nil];
    self.player.volume = 1.0;
    self.player.delegate = self;
    //
    [self.player prepareToPlay];
    BOOL suc =  [self.player play];
    //
    if (suc){
          [self startVoiceAnimation];
    }
    NSLog(@"开始语音播放");
}

- (void)adjustSoundView{
    
}




-(void)audioPlayerDidFinishPlaying:(AVAudioPlayer *)player successfully:(BOOL)flag{
     NSLog(@"audioPlayerDidFinishPlaying");
    [self stopVoicePlay];
    
}

-(void)audioPlayerDecodeErrorDidOccur:(AVAudioPlayer *)player error:(NSError *)error{
    NSLog(@"audioPlayerDecodeErrorDidOccur");
     [self stopVoicePlay];
}

-(void)audioPlayerEndInterruption:(AVAudioPlayer *)player{
    NSLog(@"PlayerEndInterruption");
    [self stopVoicePlay];
}
-(void)audioPlayerBeginInterruption:(AVAudioPlayer *)player{
    NSLog(@"audioPlayerBeginInterruption");
    [self stopVoicePlay];
}
- (void)audioPlayerEndInterruption:(AVAudioPlayer *)player withOptions:(NSUInteger)flags{
    NSLog(@"audioPlayerEndInterruption2");
    [self stopVoicePlay];
}

-(void)dealloc{
    if (self.player.isPlaying){
         [self.player stop];
    }
    self.player = nil;
}


@end
