//
//  ChangeNamePopView.m
//  鲁班同城
//
//  Created by apple on 2018/8/22.
//  Copyright © 2018年 Mac. All rights reserved.
//

#import "ChangeNamePopView.h"

@interface ChangeNamePopView (){
    
}


@end

@implementation ChangeNamePopView
@synthesize cancelButt;
@synthesize commitButt;


- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        self.backgroundColor = [UIColor whiteColor];
        self.layer.cornerRadius = 3;
        self.clipsToBounds = YES;

        //0.1+ 0.1
        UILabel *topTipLabel = [[CustomeLzhLabel alloc]initWithCustomerParamer:[UIFont getPingFangSCMedium:16] titleColor:[UIColor colorWithHexString:@"#333333"] aligement:1];
        topTipLabel.text = @"改名";
        topTipLabel.frame = CGRectMake(0, frame.size.height * 0.1, frame.size.width, frame.size.height * 0.1);
        [self addSubview:topTipLabel];
        //0.15+ 0.2
        self.commentTextView = [[OwnTextView alloc]initWithFrame:CGRectMake(0, topTipLabel.bottom + frame.size.height * 0.15, frame.size.width  * 0.75, frame.size.height * 0.2)];
        self.commentTextView.center = CGPointMake(frame.size.width / 2, self.commentTextView.centerY);
        
        self.commentTextView.backgroundColor = [UIColor colorWithHexString:@"#E2E2E2"];
        self.commentTextView.writeTextView.backgroundColor = self.commentTextView.backgroundColor;
        self.commentTextView.writeViewPlaceHolderLabel.textColor = [UIColor colorWithHexString:@"#999999"];
        self.commentTextView.writeViewPlaceHolderLabel.font = [UIFont getPingFangSCRegular:12];
        self.commentTextView.writeViewPlaceHolderLabel.text = @"请输入名字";
        [self addSubview:self.commentTextView];
        [self.commentTextView.writeTextView becomeFirstResponder];
        WS(weakSelf);
        self.commentTextView.keyBoardChangedBlock = ^(CGFloat keyBoardHeight) {
            weakSelf.frame = CGRectMake(weakSelf.x, SCREEN_HEIGHT - keyBoardHeight - weakSelf.height, weakSelf.width, weakSelf.height);
        };
        
        //0.3 + 0.15
         cancelButt = [[CustomeStyleCornerButt alloc]initWithFrame:CGRectMake(0, self.commentTextView.bottom + frame.size.height * 0.3, frame.size.width / 2, frame.size.height * 0.15) backColor:[UIColor colorWithHexString:@"#F5F5F5"] cornerRadius:-1 title:@"取消" titleColor:[UIColor colorWithHexString:@"#999999"] font:[UIFont getPingFangSCMedium:16]];
        [self addSubview:cancelButt];
        //
        UIColor *payBackCol = SPECIAL_BLUE_COLOR;
        commitButt = [[CustomeStyleCornerButt alloc]initWithFrame:CGRectMake(cancelButt.right, cancelButt.top, frame.size.width / 2, cancelButt.height) backColor:payBackCol cornerRadius:-1 title:@"确定" titleColor:[UIColor whiteColor] font:[UIFont getPingFangSCMedium:16]];
        [self addSubview:commitButt];
        //
    }
    return self;
}


@end
