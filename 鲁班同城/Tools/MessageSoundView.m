//
//  MessageSoundView.m
//  鲁班同城
//
//  Created by apple on 2018/7/9.
//  Copyright © 2018年 Mac. All rights reserved.
//

#import "MessageSoundView.h"


@interface MessageSoundView (){
    NSMutableArray *animationArr;
}

@end

@implementation MessageSoundView


- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
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
        [self addSubview:self.soundButt];
        //
        self.soundTimeLabel = [[CustomeLzhLabel alloc] initWithCustomerParamer:[UIFont getPingFangSCMedium:14] titleColor:[UIColor colorWithHexString:@"#666666"] aligement:0];
        self.soundTimeLabel.frame = CGRectMake(self.soundButt.right + 15, 0, frame.size.width - self.soundButt.right - 30, frame.size.height);
        self.soundTimeLabel.text = @"语音介绍";
        [self addSubview:self.soundTimeLabel];
    }
    return self;
}

- (void)startVoiceAnimation{
    if (self.soundButt.imageView.isAnimating == NO){
        [self.soundButt.imageView startAnimating];
    }
}
- (void)stopVoiceAnimation{
    [self.soundButt.imageView stopAnimating];
}
//
- (void)giveTimeToSoundView:(NSString*)timeStr{
    if (timeStr == nil || [timeStr length] == 0){
        self.soundTimeLabel.text = @"";
    }else{
        NSMutableString *dealTimeStr = [NSMutableString stringWithString:timeStr];
        self.soundTimeLabel.text = dealTimeStr;
    }
}

- (void)adjustSoundView{
    
}

@end
