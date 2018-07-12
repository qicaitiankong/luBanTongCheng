//
//  TakeOrderQuotePriceDetaiSectionView.h
//  鲁班同城
//
//  Created by apple on 2018/7/12.
//  Copyright © 2018 Mac. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface TakeOrderQuotePriceDetaiSectionView : UIView

@property (strong,nonatomic) UILabel *topDisplayLabel;

@property (strong,nonatomic) UILabel *botDisplayLabel;

- (instancetype)initWithFrame:(CGRect)frame backImageHeight:(CGFloat)imageHieght image:(UIImage*)image;

@end
