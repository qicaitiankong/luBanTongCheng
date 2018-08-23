//
//  WriteCommentInputView.m
//  鲁班同城
//
//  Created by apple on 2018/8/22.
//  Copyright © 2018年 Mac. All rights reserved.
//

#import "WriteCommentInputView.h"

@interface WriteCommentInputView (){

}
@end


@implementation WriteCommentInputView

- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        self.backgroundColor = [UIColor whiteColor];
        self.layer.borderWidth = 1;
        self.layer.borderColor = [UIColor colorWithRed:248/255.0 green:248/255.0 blue:248/255.0 alpha:1].CGColor;
        UIView *baseView = [[UIView alloc]initWithFrame:CGRectMake(0, 0, frame.size.width * 0.946, frame.size.height * 0.9)];
        baseView.backgroundColor = [UIColor colorWithRed:244/255.0 green:244/255.0 blue:244/255.0 alpha:1];
        baseView.center = CGPointMake(frame.size.width / 2, frame.size.height / 2);
        [self addSubview:baseView];
        //
        CGFloat imageViewHeight = 15;
        CGFloat imageViewWidth = 13;
        self.pencilImageView = [[UIImageView alloc]initWithFrame:CGRectMake(15, 0, imageViewWidth, imageViewHeight)];
        //self.pencilImageView.backgroundColor = [UIColor grayColor];
        [self.pencilImageView setImage:[UIImage imageNamed:@"writeComment"]];
        self.pencilImageView.center = CGPointMake(self.pencilImageView.centerX, baseView.height / 2);
        [baseView addSubview:self.pencilImageView];
        //
        self.rightTipLabel = [[CustomeLzhLabel alloc]initWithCustomerParamer:[UIFont getPingFangSCMedium:15] titleColor:[UIColor colorWithHexString:@"#909090"] aligement:0];
        self.rightTipLabel.frame = CGRectMake(self.pencilImageView.right + 8, 0, baseView.width - self.pencilImageView.right, baseView.height);
        self.rightTipLabel.text = @"写评论";
        [baseView addSubview:self.rightTipLabel];
        //
        UIButton *backButt = [UIButton buttonWithType:UIButtonTypeCustom];
        backButt.frame = CGRectMake(0, 0, frame.size.width, frame.size.height);
        [backButt addTarget:self action:@selector(clickBackHandler) forControlEvents:UIControlEventTouchUpInside];
        [self addSubview:backButt];
        
    }
    return self;
}

- (void)clickBackHandler{
    if(self.clickButtClick){
        self.clickButtClick();
    }
}



@end
