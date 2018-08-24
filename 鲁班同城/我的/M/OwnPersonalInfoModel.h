//
//  OwnPersonalInfoModel.h
//  鲁班同城
//
//  Created by apple on 2018/8/6.
//  Copyright © 2018年 Mac. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface OwnPersonalInfoModel : NSObject
//关注flag 0:未关注， 1：关注， 2用户查看自己信息
@property (assign,nonatomic) NSInteger FoucedFlag;

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
//技术字典数组
@property (strong,nonatomic) NSMutableArray *technologyArr;

//职业字典数组
@property (strong,nonatomic) NSMutableArray *jobArr;
//技能视屏信息数组
@property (strong,nonatomic) NSMutableArray *videoInfoArr;
//技能图片信息数组
@property (strong,nonatomic) NSMutableArray *pictureInfoArr;
//技能视屏图片url数组
@property (strong,nonatomic) NSMutableArray *videoUrlStrArr;
//技能图片url数组
@property (strong,nonatomic) NSMutableArray *pictureUrlStrArr;
//
//显示需要,,,
//技术
@property (strong,nonatomic) NSString *technologyStr;
//职业
@property (strong,nonatomic) NSString *jobStr;
//个人信息技能字符串数组
@property (strong,nonatomic) NSArray *targetTechSeviceArr;
//个人信息职业字符串数组
@property (strong,nonatomic) NSArray *targetJobArr;


//技能图片image
@property (strong,nonatomic) NSArray *technologyPicArr;
//技能视屏图片
@property (strong,nonatomic) NSArray *technologyVideoArr;

//名字语音wav
@property (strong,nonatomic) NSData *nameSoundData;
//名字语音amr
@property (strong,nonatomic) NSData *nameSoundAmrData;
//名字语音时间
@property (assign,nonatomic) NSInteger nameSoundTime;

@property (strong,nonatomic) NSString *nameSoundUrlStr;

//工作经历语音
@property (strong,nonatomic) NSData *workExperienceData;

@property (strong,nonatomic) NSData *workExperienceAmrData;

@property (strong,nonatomic) NSString *workExperienceUrlStr;

@property (assign,nonatomic) NSInteger workExperienceSoundTime;

- (NSData*)getWavData:(NSData*)amrData;



//修改信息上传时需要
//1,2,3,4
@property (strong,nonatomic) NSString* technologyServiceNeedStr;

@property (strong,nonatomic) NSString* jobServiceNeedStr;
//url路径逗号拼接用,隔开
@property (strong,nonatomic) NSString *technologyPicSeviceNeedStr;

//url路径逗号拼接用,隔开
@property (strong,nonatomic) NSString *technologyVideoSeviceNeedStr;



+ (OwnPersonalInfoModel*)setModelFromDict:(NSDictionary*)webDict;

//图片的获取是另外的接口，所以需要插入
- (NSMutableArray*)getTargetImageUrlStrArr:(NSArray*)originArr;




@end
