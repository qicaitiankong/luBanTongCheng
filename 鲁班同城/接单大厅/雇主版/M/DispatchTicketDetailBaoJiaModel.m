//
//  DispatchTicketDetailBaoJiaModel.m
//  鲁班同城
//
//  Created by apple on 2018/7/16.
//  Copyright © 2018 Mac. All rights reserved.
//

#import "DispatchTicketDetailBaoJiaModel.h"

@implementation DispatchTicketDetailBaoJiaModel

+ (DispatchTicketDetailBaoJiaModel*)setModelFromDict:(NSDictionary*)dict{
    DispatchTicketDetailBaoJiaModel *model = [[DispatchTicketDetailBaoJiaModel alloc]init];
    if (dict){
//        headImg = "http://img4.imgtn.bdimg.com/it/u=3956115742,3528028864&fm=27&gp=0.jpg";
//        mobile = "<null>";
//        quote = 4;
//        realName = "\U674e\U56db";
//        remark = fbvdsv;
//        remarkPath = "<null>";
//        score = 0;
        if ([[dict allKeys] containsObject:@"receiveOrderId"]){
             model.receiveOrderIdNum = [NSNumber getResultNumberBySeverStr:dict[@"receiveOrderId"]];
        }
        if ([[dict allKeys] containsObject:@"userId"]){
            model.baoJiaUserIdNum = [NSNumber getResultNumberBySeverStr:dict[@"userId"]];
        }
        if ([[dict allKeys] containsObject:@"heIsHired"]){
            model.heIsHired = [NSNumber getResultNumberBySeverStr:dict[@"heIsHired"]];
        }
        model.pictureUrlStr = [NSString getResultStrBySeverStr:dict[@"headImg"]];
        
        model.nickNameStr = [NSString getResultStrBySeverStr:dict[@"realName"]];
        model.mobileStr = [NSString getResultStrBySeverStr:dict[@"mobile"]];
        
        NSNumber *baojiaNum = [NSNumber getResultNumberBySeverStr:dict[@"quote"]];
        NSInteger baoJia = [baojiaNum integerValue];
        NSNumber *scoreNum = [NSNumber getResultNumberBySeverStr:dict[@"score"]];
        NSInteger score = [scoreNum integerValue];
        if (score < 1){
            score = 1;
        }
        model.baoJiaNameStr = [NSString stringWithFormat:@"%ld",baoJia];
        model.xinxinStr = [NSString stringWithFormat:@"%ld",score];
        model.beiZhuNameStr =  [NSString getResultStrBySeverStr:dict[@"remark"]];
    }else{
    }
    return model;
}

@end
