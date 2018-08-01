//
//  TakeOrderMainHallModel.m
//  鲁班同城
//
//  Created by apple on 2018/7/3.
//  Copyright © 2018年 Mac. All rights reserved.
//

#import "TakeOrderMainHallModel.h"

@implementation TakeOrderMainHallModel

+ (TakeOrderMainHallModel*)setModelFromDict:(NSDictionary*)dict{
    TakeOrderMainHallModel *localModel = [[TakeOrderMainHallModel alloc] init];
    if (dict){
        //                budget = "";
        //                createTime = "2018-07-25";
        //                headImg = "http://img2.imgtn.bdimg.com/it/u=907947422,4181136292&fm=27&gp=0.jpg";
        //                orderId = 1;
        //                orderSn = 220180725163903;
        //                receiveNum = 0;
        //                remark = "\U5907\U6ce8";
        //                userName = "\U7528\U62371";
        localModel.logoUrlStr = [NSString getResultStrBySeverStr:dict[@"headImg"]];
        localModel.personNameStr = [dict[@"userName"] copy];
        localModel.timeStr = [dict[@"createTime"] copy];
        localModel.detailStr = [dict[@"remark"] copy];
        localModel.praiseStr = [dict[@"budget"] copy];
        NSInteger receiveNum = [dict[@"receiveNum"] integerValue];
        localModel.ticketsNumberStr = [NSString stringWithFormat:@"%ld",receiveNum];
        localModel.orderID = [dict[@"orderId"] integerValue];
        localModel.orderNumberStr = [dict[@"orderSn"] copy];
        localModel.canReceive = [[NSNumber getResultBoolNumberBySeverStr:dict[@"canReceive"]] boolValue];
        localModel.isHiredMe = [[NSNumber getResultBoolNumberBySeverStr:dict[@"isHiredMe"]] boolValue];
    }else{
    }
    return localModel;
}




@end
