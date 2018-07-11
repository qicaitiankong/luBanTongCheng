//
//  TakeOrderQuotePriceModel.h
//  鲁班同城
//
//  Created by apple on 2018/7/11.
//  Copyright © 2018年 Mac. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface TakeOrderQuotePriceModel : NSObject

@property (strong,nonatomic) NSString *logoUrlStr;

@property (strong,nonatomic) UIImage *image;

@property (strong,nonatomic) NSString *personNameStr;

@property (strong,nonatomic) NSString *timeStr;

@property (strong,nonatomic) NSString *detailStr;

@property (strong,nonatomic) NSString *praiseStr;

@property (strong,nonatomic) NSString *ticketsNumberStr;

@property (strong,nonatomic) NSMutableArray *imageUrls;


//抢标列表

@property (strong,nonatomic) NSString *nickNameStr;

@property (strong,nonatomic) NSString *quoteStateStr;


@end
