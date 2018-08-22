//
//  CommentModel.h
//  鲁班同城
//
//  Created by apple on 2018/8/22.
//  Copyright © 2018年 Mac. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface CommentModel : NSObject

@property (strong,nonatomic) NSString *userImageUrlStr;

@property (strong,nonatomic) NSString *nameStr;

@property (strong,nonatomic) NSString *commentContentStr;

@property (strong,nonatomic) NSString *timeStr;

@property (strong,nonatomic) NSString *praiseStr;

@property (strong,nonatomic) NSString *answerNumStr;

@property (assign,nonatomic) BOOL haveClickPraise;


+ (CommentModel*)setModelFromDict:(NSDictionary*)dict;


@end
