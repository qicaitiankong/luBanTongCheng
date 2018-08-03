//
//  OrderTakingQuotePriceDetailViewController.h
//  鲁班同城
//
//  Created by apple on 2018/7/12.
//  Copyright © 2018 Mac. All rights reserved.
//
//确认接单页面

#import <UIKit/UIKit.h>
#import "BaseDisplayNaviViewController.h"

@interface OrderTakingQuotePriceDetailViewController : BaseDisplayNaviViewController

@property (assign,nonatomic) NSInteger orderId;
//单子状态(针对于该派单的而不是当前用户的)
@property (assign,nonatomic) NSInteger stateFlag;

@property (copy,nonatomic) void (^refreshDataAfterTakeOrderBlock)(void);


@end
