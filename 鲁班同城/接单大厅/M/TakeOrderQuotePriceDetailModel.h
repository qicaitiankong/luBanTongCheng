//
//  TakeOrderQuotePriceDetailModel.h
//  鲁班同城
//
//  Created by apple on 2018/7/12.
//  Copyright © 2018 Mac. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface TakeOrderQuotePriceDetailModel : NSObject

@property (assign,nonatomic) NSInteger orderId;

@property (strong,nonatomic) NSString *logoUrlStr;

@property (strong,nonatomic) UIImage *image;

@property (strong,nonatomic) NSString *personNameStr;

@property (strong,nonatomic) NSString *timeStr;

@property (strong,nonatomic) NSString *detailStr;

@property (strong,nonatomic) NSString *praiseStr;

@property (strong,nonatomic) NSString *ticketsNumberStr;
//电话地址备注信息

@property (strong,nonatomic) NSString *personInfoTipStr;

@property (strong,nonatomic) NSString *personInfoStr;

@property (assign,nonatomic) NSInteger cellFlag;

@end
