//
//  ChageNamePop.m
//  鲁班同城
//
//  Created by apple on 2018/8/22.
//  Copyright © 2018年 Mac. All rights reserved.
//

#import "ChageNamePop.h"

@implementation ChageNamePop
ChageNamePop *selfClass;

+ (void)showPopView:(void (^)(NSString* nameStr))sureBlock{
     selfClass = [[ChageNamePop alloc]init];
    if (selfClass){
        UIWindow *keyWindow = [UIApplication sharedApplication].keyWindow;
        //
        selfClass.zheZhaoView = [[UIView alloc]initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, SCREEN_HEIGHT)];
        selfClass.zheZhaoView.backgroundColor = [UIColor grayColor];
        selfClass.zheZhaoView.alpha = 0.45;
        [keyWindow addSubview:selfClass.zheZhaoView];
        //
        selfClass.popView = [[ChangeNamePopView alloc]initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH * 0.75, SCREEN_HEIGHT * 0.35)];
        selfClass.popView.center = CGPointMake(SCREEN_WIDTH / 2, SCREEN_HEIGHT  * 0.35);
        selfClass.popView.cancelButt.clickButtBlock = ^{
            [selfClass.popView.commentTextView resignFirstResponder];
            [selfClass removePopView];
        };
        selfClass.popView.commitButt.clickButtBlock = ^{
            [selfClass.popView.commentTextView resignFirstResponder];
        sureBlock([selfClass.popView.commentTextView.writeTextView.text copy]);
            
            [selfClass removePopView];
        };
        [keyWindow addSubview:selfClass.popView];
    }
}

- (void)removePopView{
    [selfClass.popView removeFromSuperview];
    [selfClass.zheZhaoView removeFromSuperview];
    selfClass.popView = nil;
    selfClass.zheZhaoView = nil;
}





@end
