//
//  CustomeStyleCornerButt.m
//  鲁班同城
//
//  Created by apple on 2018/7/4.
//  Copyright © 2018年 Mac. All rights reserved.
//

#import "CustomeStyleCornerButt.h"

@interface CustomeStyleCornerButt (){
   
}
@end
@implementation CustomeStyleCornerButt
@synthesize loginButt;

- (instancetype)initWithFrame:(CGRect)frame backColor:(UIColor *)color cornerRadius:(CGFloat)radius title:(NSString *)titles titleColor:(UIColor *)titleColor font:(UIFont*)fonts
{
    self = [super initWithFrame:frame];
    if (self) {
        
        loginButt = [UIButton buttonWithType:UIButtonTypeCustom];
        loginButt.frame = CGRectMake(0, 0, frame.size.width, frame.size.height);
        self.clipsToBounds = YES;
        if (color == nil){
            
        }else{
            self.backgroundColor = [UIColor whiteColor];
            loginButt.backgroundColor = color;
        }
        
        [loginButt addTarget:self action:@selector(loginHandler) forControlEvents:UIControlEventTouchUpInside];
        [loginButt setTitle:titles forState:UIControlStateNormal];
        loginButt.titleLabel.font = fonts;
        UIColor *buttTitleColor = titleColor;
        [loginButt setTitleColor:buttTitleColor forState:UIControlStateNormal];
        if(radius == 0){
            loginButt.layer.cornerRadius = frame.size.height / 2;
        }else{
            loginButt.layer.cornerRadius = radius;
        }
        [self addSubview:loginButt];
    }
    return self;
}

- (void)loginHandler{
    if (self.clickButtBlock){
        self.clickButtBlock();
    }
}

- (void)setButtTitle:(NSString*)title{
     [loginButt setTitle:title forState:UIControlStateNormal];
}

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

@end
