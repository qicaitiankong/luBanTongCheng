//
//  BoFangYuYinOwnPopView.m
//  鲁班同城
//
//  Created by apple on 2018/8/14.
//  Copyright © 2018年 Mac. All rights reserved.
//

#import "BoFangYuYinOwnPopView.h"

@interface BoFangYuYinOwnPopView (){
    
    NSTimer *myTimeer;
    NSInteger totalTime;
    UILabel *changeTimeLabel;
    UILabel *totalTimeLabel;
    UIProgressView * timeProgressView;

}


@end


@implementation BoFangYuYinOwnPopView
@synthesize tipLabel;

- (instancetype)initWithFrame:(CGRect)frame totalTime:(NSInteger)times
{
    self = [super initWithFrame:frame];
    if (self) {
        self.layer.cornerRadius = 5;
        totalTime = times;
        //
        UIView *backView = [[UIView alloc]init];
        backView.backgroundColor = [UIColor grayColor];
        backView.alpha = 0.65;
        backView.frame = CGRectMake(0, 0, 100, 100);
        backView.layer.cornerRadius = 5;
        [self addSubview:backView];
        //
        tipLabel = [[CustomeLzhLabel alloc] initWithCustomerParamer:[UIFont getPingFangSCBold:24] titleColor:[UIColor colorWithHexString:@"#E1E1E1"] aligement:1];
        tipLabel.text = @"播放中";
        tipLabel.numberOfLines = 0;
        tipLabel.frame=  CGRectMake(0, 10, frame.size.width, 50);
        [self addSubview:tipLabel];
        //
        UIImageView *logoImageView = [[UIImageView alloc]initWithFrame:CGRectMake(0, tipLabel.bottom + 15, frame.size.width * 0.25, frame.size.width * 0.25 / 0.6)];
        logoImageView.center = CGPointMake(frame.size.width / 2, logoImageView.centerY);
        [logoImageView setImage:[UIImage imageNamed:@"huaTong"]];
        [self addSubview:logoImageView];
        //
        timeProgressView = [[UIProgressView alloc]init];
        //高度设置无用的，系统不允许修改
        timeProgressView.frame = CGRectMake(frame.size.width * 0.1, logoImageView.bottom + 20, frame.size.width * 0.8, 100);
        //甚至进度条的风格颜色值，默认是蓝色的
    timeProgressView.progressTintColor=SPECIAL_BLUE_COLOR;
        
        //表示进度条未完成的，剩余的轨迹颜色,默认是灰色
        timeProgressView.trackTintColor =[UIColor whiteColor];
        [self addSubview:timeProgressView];
        //
        changeTimeLabel = [[CustomeLzhLabel alloc]initWithCustomerParamer:[UIFont getPingFangSC:17] titleColor:[UIColor whiteColor] aligement:0];
        changeTimeLabel.frame = CGRectMake(frame.size.width * 0.09, timeProgressView.bottom + 10, frame.size.width * 0.4, 40);
        [self addSubview:changeTimeLabel];
        //
        totalTimeLabel = [[CustomeLzhLabel alloc]initWithCustomerParamer:[UIFont getPingFangSC:17] titleColor:[UIColor whiteColor] aligement:2];
        totalTimeLabel.frame = CGRectMake(changeTimeLabel.right, changeTimeLabel.top, frame.size.width * 0.4, 40);
        [self addSubview:totalTimeLabel];
        //
        WS(weakSelf);
        UIColor *buttColor = SPECIAL_BLUE_COLOR;
        CustomeStyleCornerButt *sureButt = [[CustomeStyleCornerButt alloc]initWithFrame:CGRectMake(frame.size.width * 0.09, changeTimeLabel.bottom + 15, frame.size.width * 0.32, frame.size.width * 0.32 / 2) backColor:buttColor cornerRadius:5 title:@"完成" titleColor:[UIColor whiteColor] font:[UIFont getPingFangSC:16]];
        sureButt.clickButtBlock = ^{
            [weakSelf sureClick];
        };
        [self addSubview:sureButt];
        //
        CustomeStyleCornerButt *deleteButt = [[CustomeStyleCornerButt alloc]initWithFrame:CGRectMake(sureButt.right + frame.size.width * 0.18, changeTimeLabel.bottom + 15, frame.size.width * 0.32, frame.size.width * 0.32 / 2) backColor:buttColor cornerRadius:5 title:@"删除" titleColor:[UIColor whiteColor] font:[UIFont getPingFangSC:16]];
        deleteButt.clickButtBlock = ^{
            [weakSelf deleteClick];
        };
        [self addSubview:deleteButt];
        //
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
        
        totalTimeLabel.text = [NSNumber getMinutesFormat:totalTime];
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
    changeTimeLabel.text = [NSNumber getMinutesFormat:time];
    timeProgressView.progress = time / (float)totalTime;
    if (time >= totalTime){
        [self stopTimer];
    }
}

- (void)sureClick{
    if (self.sureBlock){
        [self stopTimer];
        self.sureBlock();
    }
}

- (void)deleteClick{
    if (self.deleteBlock){
        [self stopTimer];
        self.deleteBlock();
    }
}

-(void)dealloc{
    [self stopTimer];
}

@end
