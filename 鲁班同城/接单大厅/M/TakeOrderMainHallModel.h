//
//  TakeOrderMainHallModel.h
//  鲁班同城
//
//  Created by apple on 2018/7/3.
//  Copyright © 2018年 Mac. All rights reserved.
//

#import <Foundation/Foundation.h>


@interface TakeOrderMainHallModel : NSObject
//订单id
@property (assign,nonatomic) NSInteger orderID;
//订单状态/派单状态。0：派单中。1：接单人满。2：已付款。3：已雇佣。4：已退款。5：确认接单。6：已完成。7：已取消。
@property (assign,nonatomic) NSInteger orderState;

//订单号
@property (strong,nonatomic) NSString *orderNumberStr;

@property (strong,nonatomic) NSString *logoUrlStr;

@property (strong,nonatomic) UIImage *image;

@property (strong,nonatomic) NSString *personNameStr;

@property (strong,nonatomic) NSString *timeStr;

@property (strong,nonatomic) NSString *detailStr;

@property (strong,nonatomic) NSString *praiseStr;

@property (strong,nonatomic) NSString *ticketsNumberStr;
//1:抢单，2:查看
//能否抢单（抢单）。true：能。false：不能。
@property (assign,nonatomic) BOOL canReceive;
////当前用户有没有被雇佣
@property (assign,nonatomic) BOOL isHiredMe;



+ (TakeOrderMainHallModel*)setModelFromDict:(NSDictionary*)dict;


@end
