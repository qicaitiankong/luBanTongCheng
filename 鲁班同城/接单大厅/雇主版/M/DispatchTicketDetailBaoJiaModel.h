//
//  DispatchTicketDetailBaoJiaModel.h
//  鲁班同城
//
//  Created by apple on 2018/7/16.
//  Copyright © 2018 Mac. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface DispatchTicketDetailBaoJiaModel : NSObject

@property (strong,nonatomic) UIImage *userImage;

@property (strong,nonatomic) NSString *nickNameStr;

@property (strong,nonatomic) NSString *xinxinStr;

@property (strong,nonatomic) NSString *baoJiaNameStr;

@property (strong,nonatomic) NSString *beiZhuNameStr;

@property (assign,nonatomic) BOOL shouldDisplayBottomView;

+ (DispatchTicketDetailBaoJiaModel*)setModelFromDict:(NSDictionary*)dict;


@end
