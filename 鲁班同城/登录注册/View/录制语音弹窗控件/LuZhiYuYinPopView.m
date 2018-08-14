//
//  LuZhiYuYinPopView.m
//  鲁班同城
//
//  Created by apple on 2018/8/14.
//  Copyright © 2018年 Mac. All rights reserved.
//

#import "LuZhiYuYinPopView.h"

@interface LuZhiYuYinPopView (){
    NSTimer *myTimeer;
}
@end

@implementation LuZhiYuYinPopView
@synthesize tipLabel;

- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        self.layer.cornerRadius = 5;
        //
        UIView *backView = [[UIView alloc]init];
       backView.backgroundColor = [UIColor grayColor];
        backView.alpha = 0.65;
        backView.frame = CGRectMake(0, 0, 100, 100);
        backView.layer.cornerRadius = 5;
        [self addSubview:backView];
        //
        tipLabel = [[CustomeLzhLabel alloc] initWithCustomerParamer:[UIFont getPingFangSCBold:24] titleColor:[UIColor colorWithHexString:@"#E1E1E1"] aligement:1];
        tipLabel.text = @"正在录音";
        tipLabel.numberOfLines = 0;
        tipLabel.frame=  CGRectMake(0, 10, frame.size.width, 50);
        [self addSubview:tipLabel];
        //
        UIImageView *logoImageView = [[UIImageView alloc]initWithFrame:CGRectMake(0, tipLabel.bottom + 15, frame.size.width * 0.25, frame.size.width * 0.25 / 0.6)];
        logoImageView.center = CGPointMake(frame.size.width / 2, logoImageView.centerY);
        [logoImageView setImage:[UIImage imageNamed:@"huaTong"]];
        [self addSubview:logoImageView];
        //
        self.timeLabel = [[CustomeLzhLabel alloc]initWithCustomerParamer:[UIFont getPingFangSC:24] titleColor:[UIColor colorWithHexString:@"#E1E1E1"] aligement:1];
        self.timeLabel.frame = CGRectMake(0, logoImageView.bottom + 10, frame.size.width, 40);
        [self addSubview:self.timeLabel];
        //
        WS(weakSelf);
        UIColor *buttColor = SPECIAL_BLUE_COLOR;
        CustomeStyleCornerButt *sureButt = [[CustomeStyleCornerButt alloc]initWithFrame:CGRectMake(0, self.timeLabel.bottom + 15, frame.size.width * 0.32, frame.size.width * 0.32 / 2) backColor:buttColor cornerRadius:5 title:@"完成" titleColor:[UIColor whiteColor] font:[UIFont getPingFangSC:16]];
        sureButt.center = CGPointMake(frame.size.width / 2, sureButt.centerY);
        sureButt.clickButtBlock = ^{
            [weakSelf sureClick];
        };
        [self addSubview:sureButt];
        [self setFrame:CGRectMake(frame.origin.x, frame.origin.y, frame.size.width, sureButt.bottom + 20)];
        [backView setFrame:CGRectMake(0, 0, frame.size.width,sureButt.bottom + 20 )];
        //
        self.zheZhaoButt = [UIButton buttonWithType:UIButtonTypeCustom];
        [self.zheZhaoButt addTarget:self action:@selector(zheZhaoDianji) forControlEvents:UIControlEventTouchUpInside];
        [self.zheZhaoButt setFrame:CGRectMake(0, 0, SCREEN_WIDTH, SCREEN_HEIGHT)];
        UIWindow *mainWindow = [UIApplication sharedApplication].keyWindow;
        [mainWindow addSubview:self.zheZhaoButt];
        //
        [self createTimer];
        
    }
    return self;
}

- (void)zheZhaoDianji{
    NSLog(@"遮罩点击")
}

- (void)createTimer{
    myTimeer = [NSTimer scheduledTimerWithTimeInterval:1 target:self selector:@selector(timerHandler:) userInfo:nil repeats:YES] ;
}

- (void)stopTimer{
    if (myTimeer){
        [myTimeer invalidate];
        myTimeer = nil;
    }
   
}

- (void)timerHandler:(NSTimer*)timer{
    NSLog(@"定时器执行");
    static NSInteger time = 0;
    time ++;
    NSDictionary *resultDict = [self getMinutesFormat:time];
    NSInteger minute = [resultDict[@"minute"] integerValue];
    NSInteger seconds = [resultDict[@"second"] integerValue];
    self.timeLabel.text = [NSString stringWithFormat:@"%02ld : %02ld",minute,seconds];
}

- (NSDictionary*)getMinutesFormat:(NSInteger)time{
    NSInteger miniute = 0;
    NSInteger seconds = 0;
    if (time % 60){
        miniute = time / 60;
        seconds = time - miniute * 60;
    }else{
        seconds = time;
    }
    NSDictionary *resultDict = @{@"minute":[NSNumber numberWithInteger:miniute],@"second":[NSNumber numberWithInteger:seconds]};
    return resultDict;
}


- (void)sureClick{
    if (self.sureBlock){
        [self stopTimer];
        self.sureBlock();
    }
}

-(void)dealloc{
       [self stopTimer];
}


@end
