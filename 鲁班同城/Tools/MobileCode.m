//
//  MobileCode.m
//  鲁班同城
//
//  Created by Mac on 2018/6/27.
//  Copyright © 2018年 Mac. All rights reserved.
//

#import "MobileCode.h"

@implementation MobileCode
+ (void)withButtonState:(UIButton*)l_timeButton totalTime:(int)times{
    __block int timeout= times; //倒计时时间
    dispatch_queue_t queue = dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0);
    dispatch_source_t _timer = dispatch_source_create(DISPATCH_SOURCE_TYPE_TIMER, 0, 0,queue);
    dispatch_source_set_timer(_timer,dispatch_walltime(NULL, 0),1.0*NSEC_PER_SEC, 0); //每秒执行
    
    dispatch_source_set_event_handler(_timer, ^{
        if(timeout<=0){ //倒计时结束，关闭
            dispatch_source_cancel(_timer);
            dispatch_async(dispatch_get_main_queue(), ^{
                //设置界面的按钮显示 根据自己需求设置（倒计时结束后调用）
                
                [l_timeButton setTitle:@"获取验证码" forState:UIControlStateNormal];
                [l_timeButton setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
                //设置可点击
                l_timeButton.userInteractionEnabled = YES;
                //l_timeButton.backgroundColor = [UIColor orangeColor];
                
            });
        }else{
            //            int minutes = timeout / 60;    //这里注释掉了，这个是用来测试多于60秒时计算分钟的。
            if (timeout == 60){
                timeout = 59;
            }
            int seconds = timeout % 60;
            NSString *strTime = [NSString stringWithFormat:@"%d", seconds];
            dispatch_async(dispatch_get_main_queue(), ^{
                //设置界面的按钮显示 根据自己需求设置
                
                [l_timeButton setTitle:[NSString stringWithFormat:@"%@s后重新获取",strTime] forState:UIControlStateNormal];
               // UIColor *titleColor = RGBA(181, 181, 182, 1);
                //[l_timeButton setTitleColor:titleColor forState:UIControlStateNormal];
                //设置不可点击
                l_timeButton.userInteractionEnabled = NO;
                //l_timeButton.backgroundColor = [UIColor lightGrayColor];
            });
            timeout--;
        }
    });
    
    dispatch_resume(_timer);
    
}
@end
