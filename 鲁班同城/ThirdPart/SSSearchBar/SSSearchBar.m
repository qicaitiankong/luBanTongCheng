//
//  SSSearchBar.m
//  Demo
//
//  Created by xk jiang on 2017/10/10.
//  Copyright © 2017年 xk jiang. All rights reserved.
//

#import "SSSearchBar.h"
#import "UIImage+Tool.h"

@interface SSSearchBar () <UITextFieldDelegate>

// placeholder 和icon 和 间隙的整体宽度
@property (nonatomic, assign) CGFloat placeholderWidth;

@end

// icon宽度
static CGFloat const searchIconW = 16.0;
// icon与placeholder间距
static CGFloat const iconSpacing = 20.0;
// 占位文字的字体大小
static CGFloat const placeHolderFont = 15.0;

@implementation SSSearchBar


- (void)createToolsView{
    if (self.toolsView == nil){
        self.toolsView = [[KeyboardToolsView alloc]initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, 50) title:@"取消"];
        WS(weakSelf);
        self.toolsView.exixtButt.clickButtBlock = ^{
            
            [weakSelf.textField resignFirstResponder];
        };
    }
   
}


- (void)layoutSubviews {
    [super layoutSubviews];
    //
    [self createToolsView];
    // 设置背景图片
    UIImage *backImage = [UIImage imageWithColor:[UIColor whiteColor]];
    [self setBackgroundImage:backImage];
    for (UIView *view in [self.subviews lastObject].subviews) {
        if ([view isKindOfClass:[UITextField class]]) {
            UITextField *field = (UITextField *)view;
            self.textField = field;
            // 重设field的frame
            field.frame = CGRectMake(15.0, 0, self.frame.size.width-30.0, self.frame.size.height);
            [field setBackgroundColor:[UIColor colorWithHexString:@"#F5F5F5"]];
            field.textColor = [UIColor colorWithRed:51/255.0 green:51/255.0 blue:51/255.0 alpha:1];
            
            field.borderStyle = UITextBorderStyleNone;
            field.layer.cornerRadius = 3.0f;
            //field.clipsToBounds = YES;
             field.layer.masksToBounds = YES;
            field.inputAccessoryView = self.toolsView;
            // 设置占位文字字体颜色
            [field setValue:[UIColor colorWithHexString:@"#7D7D7D"] forKeyPath:@"_placeholderLabel.textColor"];
            [field setValue:[UIFont getPingFangSCMedium:15] forKeyPath:@"_placeholderLabel.font"];
            
            if (@available(iOS 11.0, *)) {
                // 先默认居中placeholder
                [self setPositionAdjustment:UIOffsetMake((field.frame.size.width-self.placeholderWidth)/2, 0) forSearchBarIcon:UISearchBarIconSearch];
            }
        }
    }
}

// 开始编辑的时候重置为靠左
- (BOOL)textFieldShouldBeginEditing:(UITextField *)textField {
    if (self.clickTextFieldBlock){
        self.clickTextFieldBlock();
    }
    NSLog(@"点击搜索框");
    if(self.isNeedSearch){
        // 继续传递代理方法
            if ([self.delegate respondsToSelector:@selector(searchBarShouldBeginEditing:)]) {
                [self.delegate searchBarShouldBeginEditing:self];
            }
            if (@available(iOS 11.0, *)) {
                [self setPositionAdjustment:UIOffsetZero forSearchBarIcon:UISearchBarIconSearch];
            }
    }
   
    return self.isNeedSearch;
}
// 结束编辑的时候设置为居中
- (BOOL)textFieldShouldEndEditing:(UITextField *)textField {
    if ([self.delegate respondsToSelector:@selector(searchBarShouldEndEditing:)]) {
        [self.delegate searchBarShouldEndEditing:self];
    }
    if (@available(iOS 11.0, *)) {
        [self setPositionAdjustment:UIOffsetMake((textField.frame.size.width-self.placeholderWidth)/2, 0) forSearchBarIcon:UISearchBarIconSearch];
    }
    return self.isNeedSearch;
}

// 计算placeholder、icon、icon和placeholder间距的总宽度
- (CGFloat)placeholderWidth {
    if (!_placeholderWidth) {
        CGSize size = [self.placeholder boundingRectWithSize:CGSizeMake(MAXFLOAT, MAXFLOAT) options:NSStringDrawingUsesLineFragmentOrigin|NSStringDrawingUsesFontLeading attributes:@{NSFontAttributeName:[UIFont getPingFangSCMedium:placeHolderFont]} context:nil].size;
        _placeholderWidth = size.width + iconSpacing + searchIconW;
    }
    return _placeholderWidth;
}


- (BOOL)textFieldShouldReturn:(UITextField *)textField{
    [self.textField resignFirstResponder];
    if (self.searchTextFieldBlock){
        self.searchTextFieldBlock([self.textField.text copy]);
    }
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
