//
//  OwnPersonalInfoModel.m
//  鲁班同城
//
//  Created by apple on 2018/8/6.
//  Copyright © 2018年 Mac. All rights reserved.
//

#import "OwnPersonalInfoModel.h"

@implementation OwnPersonalInfoModel

+ (OwnPersonalInfoModel*)setModelFromDict:(NSDictionary*)webDict{
    OwnPersonalInfoModel *localModel = [[OwnPersonalInfoModel alloc]init];
//    address = "\U94f6\U5ea7\U534e\U5e9c";
//    age = 30;
//    area = "\U674e\U6ca7\U533a";
//    city = "\U9752\U5c9b\U5e02";
//    fansNum = 0;
//    focusNum = 0;
//    gender = "\U7537";
//    headImg = trefreds;
//    hireNum = 2;
//    id = 16;
//    isFocused = 2;
//    mobile = 17096177665;
//    province = "\U5c71\U4e1c\U7701";
//    realName = "\U674e\U674e\U674e";
//    realNamePath = "\U674e\U674e\U674e";
//    score = 0;
//    state = 0;
//    userType = "\U96f6\U5de5";
//    username = "<null>";
//    workExperience = "\U5de5\U4f5c\U7ecf\U5386";
//    workExperiencePath = fyweiueojref;
    
    if (localModel){
        localModel.nameStr = [NSString getResultStrBySeverStr:webDict[@"realName"]];
        localModel.addressStr = [NSString getResultStrBySeverStr:webDict[@"address"]];
         localModel.sexStr = [NSString getResultStrBySeverStr:webDict[@"gender"]];
        localModel.proviceStr = [NSString getResultStrBySeverStr:webDict[@"province"]];
         localModel.cityStr = [NSString getResultStrBySeverStr:webDict[@"city"]];
         localModel.areaStr = [NSString getResultStrBySeverStr:webDict[@"area"]];
        
        localModel.fansNum = [NSNumber getResultNumberBySeverStr:webDict[@"fansNum"]];
        localModel.focusNum = [NSNumber getResultNumberBySeverStr:webDict[@"focusNum"]];
        NSNumber *focusFlagNum = [NSNumber getResultNumberBySeverStr:webDict[@"isFocused"]];
        localModel.FoucedFlag = [focusFlagNum integerValue];
        NSNumber *ageNum = [NSNumber getResultNumberBySeverStr:webDict[@"age"]];
        localModel.ageNum= ageNum;
        localModel.starCountNumber = [NSNumber getResultNumberBySeverStr:webDict[@"score"]];
        localModel.introduceStr = @"";
        localModel.jobExperienceStr = [NSString getResultStrBySeverStr:webDict[@"workExperience"]];
        localModel.mobileStr = [NSString getResultStrBySeverStr:webDict[@"mobile"]];
        localModel.userPictureUrlStr = [NSString getResultStrBySeverStr:webDict[@"headImg"]];
        

        localModel.technologyArr = webDict[@"technologys"];
        localModel.jobArr = webDict[@"professions"];
        localModel.pictureInfoArr = webDict[@"technologysPic"];
        localModel.videoInfoArr = webDict[@"technologysVideo"];
        //
        NSArray * targetArr = [localModel getTargetTechnologyArr:localModel.technologyArr];
         NSArray * targetJobArr = [localModel getTargetTechnologyArr:localModel.jobArr];
        if (targetArr.count){
            localModel.technologyStr = [targetArr componentsJoinedByString:@","];
        }else{
            localModel.technologyStr = @"";
        }
        if (targetJobArr.count){
            localModel.jobStr = [targetJobArr componentsJoinedByString:@","];
        }else{
            localModel.jobStr = @"";
        }
        localModel.jobServiceNeedStr = @"";
        localModel.technologyServiceNeedStr = @"";
    }
    return localModel;
}

//将获取的技术，工作等数组数据解析为需要的字符串数组
- (NSMutableArray*)getTargetTechnologyArr:(NSArray*)originArr{
    NSMutableArray *localTechnologyArr = [[NSMutableArray alloc]init];
    for (NSDictionary *localDict in originArr){
        [localTechnologyArr addObject:localDict[@"name"]];
    }
    return localTechnologyArr;
}

@end
