//
//  EmploymentRecordModel.h
//  鲁班同城
//
//  Created by apple on 2018/7/18.
//  Copyright © 2018 Mac. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface EmploymentRecordModel : NSObject

@property (strong,nonatomic) NSString *topNameStr;

@property (strong,nonatomic) NSString *stateStr;

@property (strong,nonatomic) NSString *companyNameStr;

@property (strong,nonatomic) NSString *timeStr;

@property (strong,nonatomic) NSString *addressStr;

@property (assign,nonatomic) CGFloat addressHeight;

+ (EmploymentRecordModel*)setModelFromDict:(NSDictionary*)dict;

@end
