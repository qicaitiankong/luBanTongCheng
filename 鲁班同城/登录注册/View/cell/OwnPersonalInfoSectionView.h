//
//  OwnPersonalInfoSectionView.h
//  鲁班同城
//
//  Created by apple on 2018/8/6.
//  Copyright © 2018年 Mac. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface OwnPersonalInfoSectionView : UIView

@property (strong,nonatomic) CustomeLzhLabel *rightTopTipLabel;

- (instancetype)initWithFrame:(CGRect)frame image:(UIImage*)leftImage title:(NSString *)leftTitle;

@end
