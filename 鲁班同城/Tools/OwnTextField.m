//
//  ownTextField.m
//  易彩票
//
//  Created by 李自豪 on 2017/11/4.
//  Copyright © 2017年 霸枪001. All rights reserved.
//

#import "OwnTextField.h"
@interface OwnTextField ()<UITextFieldDelegate>
@end

@implementation OwnTextField

- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        self.backgroundColor = [UIColor whiteColor];
        _myTextField = [[UITextField alloc]initWithFrame:CGRectMake(0, 0, frame.size.width, frame.size.height)];
        [self addSubview:_myTextField];
        //
        _myTextField.returnKeyType = UIReturnKeyDone;
        _myTextField.delegate = self;
    }
    return self;
}

- (instancetype)initWithFrameForBaoJIA:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        self.backgroundColor = [UIColor whiteColor];
        _myTextField = [[UITextField alloc]initWithFrame:CGRectMake(0, 0, frame.size.width - 40, frame.size.height)];
        [self addSubview:_myTextField];
        _myTextField.returnKeyType = UIReturnKeyDone;
        _myTextField.delegate = self;
        //
        UILabel *rightLabel = [[CustomeLzhLabel alloc]initWithCustomerParamer:[UIFont getPingFangSCMedium:13] titleColor:[UIColor colorWithHexString:@"#333333"] aligement:1];
        rightLabel.text = @"元";
        rightLabel.frame = CGRectMake(frame.size.width - 40, 0, 40, frame.size.height);
        [self addSubview:rightLabel];
        //
       
    }
    return self;
}

- (void)addOwnConstraints{
    self.myTextField.sd_layout
    .leftEqualToView(self)
    .rightEqualToView(self)
    .topEqualToView(self)
    .bottomEqualToView(self);
}


// called when 'return' key pressed. return NO to ignore.

- (BOOL)textFieldShouldReturn:(UITextField *)textField{
    [_myTextField resignFirstResponder];
    return YES;
}

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

@end
