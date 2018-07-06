//
//  messagwSoundView.m
//  KR管理系统
//
//  Created by corill002 on 2017/9/30.
//  Copyright © 2017年 霸枪001. All rights reserved.
//

#import "messagwSoundView.h"
@interface messagwSoundView (){
    NSMutableArray *animationArr;
}
@end

//本view宽高比为
@implementation messagwSoundView


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
//
- (void)adjustSoundView{
    
}

- (void)setFrame:(CGRect)frame
{
    [super setFrame:frame];
}

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

@end
