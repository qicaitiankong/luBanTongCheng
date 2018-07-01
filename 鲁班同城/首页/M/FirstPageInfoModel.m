//
//  FirstPageInfoModel.m
//  鲁班同城
//
//  Created by apple on 2018/7/1.
//  Copyright © 2018年 Mac. All rights reserved.
//

#import "FirstPageInfoModel.h"

@implementation FirstPageInfoModel

+ (FirstPageInfoModel*)getModelFromDict:(NSDictionary*)dict{
    FirstPageInfoModel *localModel = [[FirstPageInfoModel alloc] init];
    if (dict){
        
    }else{
        localModel.bigImage = [UIImage imageNamed:@""];
        localModel.logoImage = [UIImage imageNamed:@"test01"];
        localModel.companyNameStr = @"鲁班同城有限公司";
        localModel.concernCountStr = @"12345";
        
    }
    return localModel;
}

- (void)getImageDisplayHeight:(UIImage*)image{
    CGFloat height = 0;
    CGFloat WHproperty = image.size.width / image.size.height;
    CGFloat imageDisplayWidth = (SCREEN_WIDTH - 3 - 5 - 5) / 2;
    height = imageDisplayWidth / WHproperty;
    self.bigImageDisplayHeight = height;
}



@end
