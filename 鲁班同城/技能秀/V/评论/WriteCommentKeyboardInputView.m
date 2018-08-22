//
//  WriteCommentKeyboardInputView.m
//  鲁班同城
//
//  Created by apple on 2018/8/22.
//  Copyright © 2018年 Mac. All rights reserved.
//

#import "WriteCommentKeyboardInputView.h"

@implementation WriteCommentKeyboardInputView


- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        self.backgroundColor = [UIColor whiteColor];
        //
        CGFloat rightButtWidth = [LzhReturnLabelHeight getLabelWidth:@"发布" font:[UIFont getPingFangSCMedium:17] targetHeight:frame.size.height] + 15;
        //
        self.leftInputTextView = [[OwnTextView alloc]initWithFrame:CGRectMake(15, 0, frame.size.width - 15 - rightButtWidth, frame.size.height * 0.8)];
        self.leftInputTextView.center = CGPointMake(self.leftInputTextView.centerX, frame.size.height / 2);
        self.leftInputTextView.backgroundColor = [UIColor colorWithHexString:@"#F4F4F4"];
    self.leftInputTextView.writeTextView.backgroundColor = self.leftInputTextView.backgroundColor;
    self.leftInputTextView.writeViewPlaceHolderLabel.backgroundColor = self.leftInputTextView.backgroundColor;
    self.leftInputTextView.writeTextView.inputAccessoryView = nil;
        WS(weakSelf);
        self.leftInputTextView.keyBoardChangedBlock = ^(CGFloat keyBoardHeight) {
            weakSelf.frame = CGRectMake(weakSelf.x,SCREEN_HEIGHT - keyBoardHeight - frame.size.height, weakSelf.width, weakSelf.height);
        };
        [self addSubview:self.leftInputTextView];
        //
        self.rightButtView = [[CustomeLabelButt alloc]initWithFrame:CGRectMake(self.leftInputTextView.right, 0, rightButtWidth, frame.size.height)];
        self.rightButtView.displayLabel.font = [UIFont getPingFangSCMedium:17];
        self.rightButtView.displayLabel.textAlignment = NSTextAlignmentCenter;
        self.rightButtView.displayLabel.text = @"发布";
        [self addSubview:self.rightButtView];
    }
    return self;
}



@end
