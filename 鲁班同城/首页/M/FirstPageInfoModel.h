//
//  FirstPageInfoModel.h
//  鲁班同城
//
//  Created by apple on 2018/7/1.
//  Copyright © 2018年 Mac. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface FirstPageInfoModel : NSObject

@property (strong,nonatomic) NSString *bigImageUrlStr;

@property (strong,nonatomic) NSString *logoImageUrlStr;

@property (assign,nonatomic) CGFloat bigImageDisplayHeight;

@property (strong,nonatomic) NSString *companyNameStr;

@property (strong,nonatomic) NSString *concernCountStr;

@property (strong,nonatomic) UIImage *bigImage;

@property (strong,nonatomic) UIImage *logoImage;

+ (FirstPageInfoModel*)getModelFromDict:(NSDictionary*)dict;

- (void)getImageDisplayHeight:(UIImage*)image;

@end
