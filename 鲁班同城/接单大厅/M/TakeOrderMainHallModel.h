//
//  TakeOrderMainHallModel.h
//  鲁班同城
//
//  Created by apple on 2018/7/3.
//  Copyright © 2018年 Mac. All rights reserved.
//

#import <Foundation/Foundation.h>


@interface TakeOrderMainHallModel : NSObject

@property (strong,nonatomic) NSString *logoUrlStr;

@property (strong,nonatomic) UIImage *image;

@property (strong,nonatomic) NSString *personNameStr;

@property (strong,nonatomic) NSString *timeStr;

@property (strong,nonatomic) NSString *detailStr;

@property (strong,nonatomic) NSString *praiseStr;

@property (strong,nonatomic) NSString *ticketsNumberStr;
//1:抢单，2:查看
@property (assign,nonatomic) NSInteger kindFlag;

+ (TakeOrderMainHallModel*)setModelFromDict:(NSDictionary*)dict;


@end
