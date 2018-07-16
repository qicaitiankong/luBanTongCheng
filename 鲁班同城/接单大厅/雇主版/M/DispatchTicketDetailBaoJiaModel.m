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
        
    }else{
        model.userImage = [UIImage imageNamed:@"test01"];
        model.nickNameStr = @"昵称昵称";
        model.baoJiaNameStr = @"报价： 1200元";
        model.beiZhuNameStr = @"备注： 备注说明  这里显示 包括语音";
    }
    return model;
}

@end
