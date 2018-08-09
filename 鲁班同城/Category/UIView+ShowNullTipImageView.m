//
//  UIView+ShowNullTipImageView.m
//  鲁班同城
//
//  Created by apple on 2018/8/9.
//  Copyright © 2018年 Mac. All rights reserved.
//

#import "UIView+ShowNullTipImageView.h"

@implementation UIView (ShowNullTipImageView)

+ (void)showNullTipView:(UIView*)targetView{
    if(targetView){
        UIImage *targetImage = [UIImage imageNamed:@"nullRecord"];
        CGFloat height = targetView.width / (targetImage.size.width / targetImage.size.height);
        UIImageView *imageView = [[UIImageView alloc]initWithFrame:CGRectMake(0, 0, targetView.width, height)];
        imageView.tag = 136;
        imageView.backgroundColor = [UIColor whiteColor];
        [imageView setImage:targetImage];
        [targetView addSubview:imageView];
        imageView.center = CGPointMake(imageView.centerX, targetView.centerY);
    }
}

+ (void)hiddenNullTipView:(UIView*)targetView{
    if (targetView){
        UIImageView *targetImageView = [targetView viewWithTag:136];
        [targetImageView removeFromSuperview];
    }
    
}
@end
