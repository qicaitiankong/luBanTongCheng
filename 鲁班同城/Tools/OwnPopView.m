//
//  OwnPopView.m
//  鲁班同城
//
//  Created by apple on 2018/8/2.
//  Copyright © 2018年 Mac. All rights reserved.
//

#import "OwnPopView.h"
#import "CommitPopView.h"

@interface OwnPopView (){
   
}
@end


@implementation OwnPopView

+ (void)popView:(UIImage*)image title:(NSString*)message targetVC:(UIViewController*)vc backButtClickBlock:(void (^)(void))ButtClickBlock sureButtClickBlock:(void (^)(void))sureClickBlock{
  
    UIWindow *appWindow = APP_MAIN_WINDOW;
    UIButton *popbackButt = [UIButton buttonWithType:UIButtonTypeCustom];
        popbackButt.frame = CGRectMake(0, 0, SCREEN_WIDTH, SCREEN_HEIGHT);
        popbackButt.backgroundColor = [UIColor grayColor];
        popbackButt.alpha = POP_VIEW_ALPHA;
        [popbackButt addTarget:vc action:@selector(popBackButtHandler) forControlEvents:UIControlEventTouchUpInside];
        [appWindow addSubview:popbackButt];
        CommitPopView *popView = [[CommitPopView alloc]initWithFrame:CGRectMake(0, 0, 194, 223)];
        popView.center = CGPointMake(SCREEN_WIDTH / 2, SCREEN_HEIGHT  / 2);
        [appWindow addSubview:popView];
        popView.sureBlock = ^{
            sureClickBlock();
        };
}
- (void)popBackButtHandler{
    
}
@end
