//
//  StarView.h
//  鲁班同城
//
//  Created by apple on 2018/7/9.
//  Copyright © 2018年 Mac. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface StarView : UIView

@property (assign,nonatomic) NSInteger starCount;

- (void)lzhUpdateConstraints;

- (void)setYellowStar:(float)count;

- (instancetype)initWithFrameCustomeStyle:(CGRect)frame starWidth:(CGFloat)width;


@end
