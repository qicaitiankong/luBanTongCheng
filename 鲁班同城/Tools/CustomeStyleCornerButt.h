//
//  CustomeStyleCornerButt.h
//  鲁班同城
//
//  Created by apple on 2018/7/4.
//  Copyright © 2018年 Mac. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface CustomeStyleCornerButt : UIView

@property (strong,nonatomic)  UIButton *loginButt;

@property (copy,nonatomic) void (^clickButtBlock)(void);
//radius 0:默认圆角为高度的一般
- (instancetype)initWithFrame:(CGRect)frame backColor:(UIColor *)color cornerRadius:(CGFloat)radius title:(NSString *)titles titleColor:(UIColor *)titleColor font:(UIFont*)fonts;

- (void)setButtTitle:(NSString*)title;

- (void)updateOwnConstraints;


@end
