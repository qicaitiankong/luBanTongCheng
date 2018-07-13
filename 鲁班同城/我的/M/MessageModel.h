//
//  MessageModel.h
//  鲁班同城
//
//  Created by apple on 2018/7/13.
//  Copyright © 2018 Mac. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface MessageModel : NSObject

@property (strong,nonatomic) UIImage *userImage;

@property (strong,nonatomic) NSString *nameStr;

@property (strong,nonatomic) NSString *jobStr;

@property (strong,nonatomic) NSString *messageStr;

@property (strong,nonatomic) NSString *timeStr;

@end
