//
//  OwnPersonalInfoModel.h
//  鲁班同城
//
//  Created by apple on 2018/8/6.
//  Copyright © 2018年 Mac. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface OwnPersonalInfoModel : NSObject
//头像
@property (strong,nonatomic) NSString *userPictureUrlStr;

@property (strong,nonatomic) NSString *mobileStr;

@property (strong,nonatomic) NSString *nameStr;

@property (strong,nonatomic) NSNumber *ageNum;

@property (strong,nonatomic) NSString *sexStr;

@property (strong,nonatomic) NSString *proviceStr;

@property (strong,nonatomic) NSString *cityStr;

@property (strong,nonatomic) NSString *areaStr;


@property (strong,nonatomic) NSString *addressStr;

@property (strong,nonatomic) NSString *introduceStr;


@property (strong,nonatomic) NSNumber *focusNum;

@property (strong,nonatomic) NSNumber *fansNum;

@property (strong,nonatomic) NSNumber *starCountNumber;


@property (strong,nonatomic) NSString *jobExperienceStr;

@property (strong,nonatomic) NSMutableArray *technologyArr;

@property (strong,nonatomic) NSMutableArray *jobArr;

@property (strong,nonatomic) NSMutableArray *videoArr;

@property (strong,nonatomic) NSMutableArray *pictureArr;
//显示需要,,,
@property (strong,nonatomic) NSString *technologyStr;

@property (strong,nonatomic) NSString *jobStr;

@property (strong,nonatomic) NSArray *technologyPicArr;

@property (strong,nonatomic) NSArray *jobPicArr;


//修改信息上传时需要
//1,2,3,4
@property (strong,nonatomic) NSString* technologyServiceNeedStr;

@property (strong,nonatomic) NSString* jobServiceNeedStr;

@property (strong,nonatomic) NSString *technologyPicSeviceNeedStr;
//base64用,隔开
@property (strong,nonatomic) NSString *jobPicSeviceNeedStr;



+ (OwnPersonalInfoModel*)setModelFromDict:(NSDictionary*)webDict;




@end
