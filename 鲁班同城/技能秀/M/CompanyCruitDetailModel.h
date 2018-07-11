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

//图片cell专用数组
@property (strong,nonatomic) NSMutableArray *imageUrlArr;


+ (CompanyCruitDetailModel*)setModelFromDict:(NSDictionary*)dict;




@end
