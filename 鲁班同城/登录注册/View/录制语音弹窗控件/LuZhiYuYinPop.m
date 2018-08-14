//
//  LuZhiYuYinPop.m
//  鲁班同城
//
//  Created by apple on 2018/8/14.
//  Copyright © 2018年 Mac. All rights reserved.
//

#import "LuZhiYuYinPop.h"
#import "LuZhiYuYinPopView.h"


@interface LuZhiYuYinPop (){
    
}

@end


@implementation LuZhiYuYinPop
LuZhiYuYinPopView *yuYinPopView;

+ (void)showPopView:(void (^)(void))canceledBlock completeBlock:(void (^)(void))completeBlock{
       yuYinPopView = [[LuZhiYuYinPopView alloc]initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH * 0.8, 50)];
        yuYinPopView.sureBlock = ^{
            completeBlock();
        };
        yuYinPopView.tag = 62;
        UIWindow *mainWindow = [UIApplication sharedApplication].keyWindow;
    //
        [mainWindow addSubview:yuYinPopView ];
        yuYinPopView .center = CGPointMake(SCREEN_WIDTH / 2, SCREEN_HEIGHT / 2);
    
}

+ (void)dismissPopView{
     UIWindow *mainWindow = [UIApplication sharedApplication].keyWindow;
    UIView *subView = [mainWindow viewWithTag:62];
    if (subView){
        [yuYinPopView.zheZhaoButt removeFromSuperview];
        [subView removeFromSuperview];
    }
}




@end
