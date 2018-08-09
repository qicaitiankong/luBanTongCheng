//
//  PersonalInfoAddPhotoFlagView.h
//  鲁班同城
//
//  Created by apple on 2018/7/5.
//  Copyright © 2018年 Mac. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface PersonalInfoAddPhotoFlagView : UIView

@property (strong,nonatomic) UIImageView *imageView;

@property (strong,nonatomic) UIImageView *addImageView;

@property (copy,nonatomic) void (^selectedAddPhotoBlock)(UIImageView* imageView);
//当该空间的父控件使用sdautolauaut应该再次调整里面子空间
- (void)adjustConstraintsWhenNeed;


@end
