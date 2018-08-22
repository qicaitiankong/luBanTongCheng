//
//  WriteCommentKeyboardPop.m
//  鲁班同城
//
//  Created by apple on 2018/8/22.
//  Copyright © 2018年 Mac. All rights reserved.
//

#import "WriteCommentKeyboardPop.h"

@implementation WriteCommentKeyboardPop
WriteCommentKeyboardInputView *keyBoardInputView;
CustomeStyleCornerButt *backButt;

+ (void)showKeyBoardInputView:(void (^)(NSString* contentStr))inputContent leftTextViewTipStr:(NSString*)tipStr rightButtTitle:(NSString*)buttTitle{
    if (nil == keyBoardInputView){
         UIWindow *appWidow = [UIApplication sharedApplication].keyWindow;
        //
        backButt = [[CustomeStyleCornerButt alloc]initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, SCREEN_HEIGHT) backColor:[UIColor clearColor] cornerRadius:-1 title:@"" titleColor:[UIColor whiteColor] font:[UIFont systemFontOfSize:17]];
        backButt.backgroundColor = [UIColor clearColor];
        backButt.clickButtBlock = ^{
        [keyBoardInputView.leftInputTextView.writeTextView resignFirstResponder];
            [keyBoardInputView removeFromSuperview];
            [backButt removeFromSuperview];
            keyBoardInputView = nil;
            backButt = nil;
        };
        [appWidow addSubview:backButt];
        //
        keyBoardInputView = [[WriteCommentKeyboardInputView alloc]initWithFrame:CGRectMake(0, SCREEN_HEIGHT,SCREEN_WIDTH, SCREEN_HEIGHT * 0.08)];
        keyBoardInputView.leftInputTextView.writeViewPlaceHolderLabel.center = CGPointMake(keyBoardInputView.leftInputTextView.writeViewPlaceHolderLabel.centerX, keyBoardInputView.leftInputTextView.height / 2); keyBoardInputView.leftInputTextView.writeViewPlaceHolderLabel.text = tipStr;
        keyBoardInputView.rightButtView.displayLabel.text = buttTitle; keyBoardInputView.rightButtView.clickButtBlock = ^{
            inputContent([keyBoardInputView.leftInputTextView.writeTextView.text copy]);
            [keyBoardInputView.leftInputTextView.writeTextView resignFirstResponder];
                [keyBoardInputView removeFromSuperview];
                [backButt removeFromSuperview];
                keyBoardInputView = nil;
                backButt = nil;
            };
        [appWidow addSubview:keyBoardInputView];
    }
    [keyBoardInputView.leftInputTextView.writeTextView becomeFirstResponder];
}



@end
