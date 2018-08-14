//
//  BoFangYuYinOwnPop.m
//  鲁班同城
//
//  Created by apple on 2018/8/14.
//  Copyright © 2018年 Mac. All rights reserved.
//

#import "BoFangYuYinOwnPop.h"
#import "BoFangYuYinOwnPopView.h"

@interface BoFangYuYinOwnPop (){
    
}
@end

@implementation BoFangYuYinOwnPop
BoFangYuYinOwnPopView *playYuYinPopView;

+ (void)showPopView:(NSInteger)yuYinTime deleteBlock:(void (^)(void))deleteBlock completeBlock:(void (^)(void))completeBlock{
    playYuYinPopView = [[BoFangYuYinOwnPopView alloc]initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH * 0.8, 50) totalTime:yuYinTime];
    playYuYinPopView .sureBlock = ^{
        completeBlock();
    };
    playYuYinPopView.deleteBlock = ^{
        deleteBlock();
    };
    UIWindow *mainWindow = [UIApplication sharedApplication].keyWindow;
    //
    [mainWindow addSubview:playYuYinPopView  ];
    playYuYinPopView.center = CGPointMake(SCREEN_WIDTH / 2, SCREEN_HEIGHT / 2);

}

+ (void)dismissPopView{
    if (playYuYinPopView ){
        [playYuYinPopView .zheZhaoButt removeFromSuperview];
        [playYuYinPopView  removeFromSuperview];
    }
}
@end
