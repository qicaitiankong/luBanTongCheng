//
//  UIFont+CustomerFonts.m
//  鲁班同城
//
//  Created by apple on 2018/7/1.
//  Copyright © 2018年 Mac. All rights reserved.
//

#import "UIFont+CustomerFonts.h"

@implementation UIFont (CustomerFonts)

+ (UIFont *)getPingFangSC:(CGFloat)size{
    return [UIFont fontWithName:@"PingFang SC" size:size];
}

+ (UIFont *)getPingFangSCMedium:(CGFloat)size{
    return [UIFont fontWithName:@"PingFangSC-Medium" size:size];
}

+ (UIFont *)getPingFangSCRegular:(CGFloat)size{
    return [UIFont fontWithName:@"PingFangSC-Regular" size:size];
}

+ (UIFont *)getPingFangSCBold:(CGFloat)size{
    return [UIFont fontWithName:@"PingFangSC-Semibold" size:size];
}

//英文字体
//SanFranciscoText-Medium
+ (UIFont *)getSanFranciscoTextMedium:(CGFloat)size{
    return [UIFont fontWithName:@"SanFranciscoText-Medium" size:size];
}

//SanFranciscoDisplay-Medium
+ (UIFont *)getSanFranciscoDisplayMedium:(CGFloat)size{
    return [UIFont fontWithName:@"SanFranciscoDisplay-Medium" size:size];
}

//SanFranciscoText-Regular
+ (UIFont *)getSanFranciscoTextRegular:(CGFloat)size{
    return [UIFont fontWithName:@"SanFranciscoText-Regular" size:size];
}
//SanFranciscoDisplay-Regular
+ (UIFont *)getSanFranciscoDisplayRegular:(CGFloat)size{
    return [UIFont fontWithName:@"SanFranciscoDisplay-Regular" size:size];
}


@end
