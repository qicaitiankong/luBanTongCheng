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
        model.pictureUrlStr = [dict[@"headImg"] copy];
        
        model.nickNameStr = [dict[@"realName"] copy];
        model.mobileStr = [dict[@"mobile"] copy];
        NSInteger baoJia = [dict[@"quote"] integerValue];
        NSInteger score = [dict[@"score"] integerValue];
        if (score < 1){
            score = 1;
        }
        model.baoJiaNameStr = [NSString stringWithFormat:@"%ld",baoJia];
        model.xinxinStr = [NSString stringWithFormat:@"%ld",score];
        model.beiZhuNameStr = [dict[@"remark"] copy];;
    }else{
    }
    return model;
}

@end
