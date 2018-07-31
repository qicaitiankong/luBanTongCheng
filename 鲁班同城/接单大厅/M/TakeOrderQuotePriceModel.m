//
//  TakeOrderQuotePriceModel.m
//  鲁班同城
//
//  Created by apple on 2018/7/11.
//  Copyright © 2018年 Mac. All rights reserved.
//

#import "TakeOrderQuotePriceModel.h"

@implementation TakeOrderQuotePriceModel

+ (TakeOrderQuotePriceModel*)setModelFromDict:(NSDictionary*)dict{
    TakeOrderQuotePriceModel *localModel = [[TakeOrderQuotePriceModel alloc] init];
    if (dict){
        localModel.logoUrlStr = [NSString getResultStrBySeverStr:dict[@"headImg"]];
        localModel.nickNameStr = [NSString getResultStrBySeverStr:dict[@"userName"]];
    }else{
//        localModel.logoUrlStr = @"";
//        localModel.image = [UIImage imageNamed:@"test07.jpg"];
//        localModel.nickNameStr = @"昵称昵称昵称";
//        localModel.quoteStateStr = @"已报价";
    }
    return localModel;
}
@end
