//
//  DispatchTicketDetailBaoJiaModel.h
//  鲁班同城
//
//  Created by apple on 2018/7/16.
//  Copyright © 2018 Mac. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface DispatchTicketDetailBaoJiaModel : NSObject

@property (strong,nonatomic) NSString *pictureUrlStr;

@property (strong,nonatomic) NSString *nickNameStr;

@property (strong,nonatomic) NSString *xinxinStr;

@property (strong,nonatomic) NSString *baoJiaNameStr;

@property (strong,nonatomic) NSString *beiZhuNameStr;

@property (strong,nonatomic) NSString *mobileStr;


@property (assign,nonatomic) BOOL shouldDisplayBottomView;

@property (assign,nonatomic) NSInteger modelIndex;

+ (DispatchTicketDetailBaoJiaModel*)setModelFromDict:(NSDictionary*)dict;


@end
