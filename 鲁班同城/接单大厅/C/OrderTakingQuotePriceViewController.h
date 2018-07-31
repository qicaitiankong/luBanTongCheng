//
//  OrderTakingQuotePriceViewController.h
//  鲁班同城
//
//  Created by apple on 2018/7/11.
//  Copyright © 2018年 Mac. All rights reserved.
//
#import <UIKit/UIKit.h>
#import "BaseDisplayNaviViewController.h"

@interface OrderTakingQuotePriceViewController : BaseDisplayNaviViewController

//yes：报价详情， no:报价页面
@property (assign,nonatomic) BOOL isBapJiaDetail;


@property (assign,nonatomic) NSInteger orderId;

@end
