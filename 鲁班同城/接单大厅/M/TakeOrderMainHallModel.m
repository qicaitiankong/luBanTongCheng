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
        if ([dict[@"headImg"] isKindOfClass:[NSNull class]]){
            localModel.logoUrlStr = @"";
        }else{
            localModel.logoUrlStr = [dict[@"headImg"] copy];
        }
        localModel.personNameStr = [dict[@"userName"] copy];
        localModel.timeStr = [dict[@"createTime"] copy];
        localModel.detailStr = [dict[@"remark"] copy];
        localModel.praiseStr = [dict[@"budget"] copy];
        NSInteger receiveNum = [dict[@"receiveNum"] integerValue];
        localModel.ticketsNumberStr = [NSString stringWithFormat:@"%ld",receiveNum];
        localModel.orderID = [dict[@"orderId"] integerValue];
        localModel.orderNumberStr = [dict[@"orderSn"] copy];

    }else{
//        localModel.image = [UIImage imageNamed:@"test07.jpg"];
//        localModel.timeStr = @"2018-6-6";
//        localModel.personNameStr = @"发起人名称";
//        localModel.detailStr = @"详细要求：工作要求详细要求：工作要求详细要求工作要求详细要求工作要求详细要求工作要求详细要求。";
//        localModel.praiseStr = @"赏金：99+";
//        localModel.ticketsNumberStr = @"抢单名额 3/10";
    }
    return localModel;
}




@end
