//
//  OwnTextView.m
//  鲁班同城
//
//  Created by apple on 2018/7/5.
//  Copyright © 2018年 Mac. All rights reserved.
//

#import "OwnTextView.h"
#import "KeyboardToolsView.h"

@interface OwnTextView ()<UITextViewDelegate>{
    
}
@property (strong,nonatomic) KeyboardToolsView *toolView;

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
        [self createToolsView];
    self.writeTextView.inputAccessoryView=self.toolView;
        [self addSubview:self.writeTextView];
        //
        UIColor *LabelTitleColor = RGBA(180, 180, 180, 1);
        self.writeViewPlaceHolderLabel = [[CustomeLzhLabel alloc]initWithParamer:15 titleColor:LabelTitleColor aligement:0];
        self.writeViewPlaceHolderLabel.frame = CGRectMake(2, 0, frame.size.width, 30);
        self.writeViewPlaceHolderLabel.userInteractionEnabled = NO;
        
        self.writeViewPlaceHolderLabel.text = @"";
        [self.writeTextView addSubview:self.writeViewPlaceHolderLabel];
         [[NSNotificationCenter defaultCenter]addObserver:self selector:@selector(keyboardChanged:) name:UIKeyboardWillChangeFrameNotification object:nil];
    }
    return self;
}

-(void)keyboardChanged:(NSNotification *)notification{
    CGRect keyboardFrame =[notification.userInfo[UIKeyboardFrameEndUserInfoKey]CGRectValue];
    keyboardFrame = [notification.userInfo[UIKeyboardFrameEndUserInfoKey]CGRectValue];
    NSLog(@"键盘高度发生变化%lf",keyboardFrame.size.height);
    if (self.keyBoardChangedBlock){
        self.keyBoardChangedBlock(keyboardFrame.size.height);
    }
}


- (void) textViewDidChange:(UITextView *)textView{
    NSLog(@"%@",textView.text);
    if ([textView.text length] == 0) {
        [self.writeViewPlaceHolderLabel setHidden:NO];
    }else{
        [self.writeViewPlaceHolderLabel setHidden:YES];
        
    }
}

- (void)adjustOwnSubViewFrame{
    //self.writeTextView.frame = CGRectMake(self.writeTextView.x,self.writeTextView.y, self.width, self.height);
    self.writeTextView.sd_resetLayout
    .leftEqualToView(self)
    .rightEqualToView(self)
    .topEqualToView(self)
    .bottomEqualToView(self);
}



-(void)textViewDidBeginEditing:(UITextView *)textView{
    NSLog(@"DidBeginEditing");
    
}

- (void)createToolsView{
    self.toolView = [[KeyboardToolsView alloc]initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, 50) title:@"退出"];
    
    WS(weakSelf);
     self.toolView.exixtButt.clickButtBlock = ^{
        [weakSelf.writeTextView resignFirstResponder];
        if (weakSelf.keyBoardExistBlock){
            weakSelf.keyBoardExistBlock();
        }
        
    };
}
-(void)dealloc{
    [[NSNotificationCenter defaultCenter]removeObserver:self name:UIKeyboardWillChangeFrameNotification object:nil];
}

@end
