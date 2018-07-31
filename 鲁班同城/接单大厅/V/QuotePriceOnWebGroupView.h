//
//  QuotePriceOnWebGroupView.h
//  鲁班同城
//
//  Created by apple on 2018/7/11.
//  Copyright © 2018年 Mac. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "OwnTextView.h"

@interface QuotePriceOnWebGroupView : UIView

@property (copy,nonatomic) CustomeStyleCornerButt *takeOrderButt;

@property (strong,nonatomic)  OwnTextField *moneyTextfield;

@property (strong,nonatomic) OwnTextView *beiZhuTextView;


@end
