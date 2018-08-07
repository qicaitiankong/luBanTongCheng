//
//  RankModel.h
//  鲁班同城
//
//  Created by apple on 2018/7/17.
//  Copyright © 2018 Mac. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface RankModel : NSObject

@property (strong,nonatomic) NSNumber *userIdNum;

@property (strong,nonatomic) NSString *rankStr;

@property (strong,nonatomic) NSString *imageUrlStr;

@property (strong,nonatomic) UIImage *userImage;

@property (strong,nonatomic) NSString *nickName;

@property (strong,nonatomic) NSString *jobStr;

+ (RankModel*)setModelFromDict:(NSDictionary*)dict;


@end
