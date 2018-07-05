//
//  OwnTextView.m
//  鲁班同城
//
//  Created by apple on 2018/7/5.
//  Copyright © 2018年 Mac. All rights reserved.
//

#import "OwnTextView.h"

@interface OwnTextView ()<UITextViewDelegate>{
    
}
@property (strong,nonatomic) UIView *toolView;

@end

@implementation OwnTextView

- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        self.backgroundColor = [UIColor whiteColor];
        self.writeTextView = [[UITextView alloc]initWithFrame:CGRectMake(0, 0 , frame.size.width, frame.size.height )];
        //self.writeTextView.backgroundColor = [UIColor grayColor];
        self.writeTextView.font = [UIFont systemFontOfSize:15];
        self.writeTextView.delegate = self;
        self.writeTextView.inputAccessoryView=self.toolView;
        [self addSubview:self.writeTextView];
        //
        UIColor *LabelTitleColor = RGBA(180, 180, 180, 1);
        self.writeViewPlaceHolderLabel = [[CustomeLzhLabel alloc]initWithParamer:15 titleColor:LabelTitleColor aligement:0];
        self.writeViewPlaceHolderLabel.frame = CGRectMake(2, 0, frame.size.width, 30);
        self.writeViewPlaceHolderLabel.userInteractionEnabled = NO;
        
        self.writeViewPlaceHolderLabel.text = @"";
        [self.writeTextView addSubview:self.writeViewPlaceHolderLabel];
    }
    return self;
}
- (void) textViewDidChange:(UITextView *)textView{
    NSLog(@"%@",textView.text);
    if ([textView.text length] == 0) {
        [self.writeViewPlaceHolderLabel setHidden:NO];
    }else{
        [self.writeViewPlaceHolderLabel setHidden:YES];
        
    }
}


@end
