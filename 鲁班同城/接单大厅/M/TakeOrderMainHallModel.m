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
        
    }else{
        localModel.image = [UIImage imageNamed:@"test07.jpg"];
        localModel.timeStr = @"2018-6-6";
        localModel.personNameStr = @"发起人名称";
        localModel.detailStr = @"详细要求：工作要求详细要求：工作要求详细要求工作要求详细要求工作要求详细要求工作要求详细要求。";
        localModel.praiseStr = @"赏金：99+";
        localModel.ticketsNumberStr = @"抢单名额 3/10";
    }
    return localModel;
}




@end
