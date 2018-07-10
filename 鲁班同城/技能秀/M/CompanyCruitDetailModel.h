//
//  CompanyCruitDetailModel.h
//  鲁班同城
//
//  Created by apple on 2018/7/10.
//  Copyright © 2018年 Mac. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface CompanyCruitDetailModel : NSObject

@property (strong,nonatomic) NSString *jobNameStr;

@property (strong,nonatomic) NSString *detailContentStr;

@property (assign,nonatomic) BOOL isDetailDisplayState;

+ (CompanyCruitDetailModel*)setModelFromDict:(NSDictionary*)dict;


@end
