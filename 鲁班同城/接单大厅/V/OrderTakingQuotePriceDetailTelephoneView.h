//
//  OrderTakingQuotePriceDetailTelephoneView.h
//  鲁班同城
//
//  Created by apple on 2018/7/16.
//  Copyright © 2018 Mac. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface OrderTakingQuotePriceDetailTelephoneView : UIView

@property (strong,nonatomic) UILabel *ownLeftLabel;

@property (strong,nonatomic) UILabel *ownRightLabel;

@property (strong,nonatomic) UIButton *telephoneButt;

@property (copy,nonatomic) void (^clickTelephoneBlock)(void);

- (instancetype)initWithFrame:(CGRect)frame isNeedRightButt:(BOOL)need;

- (void)adjustViewHeigthByContent:(NSString*)str;


@end
