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
        
//        localModel.pictureInfoArr = webDict[@"technologysPic"];
//        localModel.videoInfoArr = webDict[@"technologysVideo"];
//        //再次解析得到视频和图片url字符串数组
//        localModel.videoUrlStrArr = [localModel getTargetImageUrlStrArr:localModel.videoInfoArr];
//
//        localModel.pictureUrlStrArr = [localModel getTargetImageUrlStrArr:localModel.pictureInfoArr];
        //技能和工作
        localModel.targetTechSeviceArr = [localModel getTargetTechnologyArr:localModel.technologyArr];
         localModel.targetJobArr = [localModel getTargetTechnologyArr:localModel.jobArr];
        if (localModel.targetTechSeviceArr.count){
            localModel.technologyStr = [localModel.targetTechSeviceArr componentsJoinedByString:@","];
        }else{
            localModel.technologyStr = @"";
        }
        if (localModel.targetJobArr.count){
            localModel.jobStr = [localModel.targetJobArr componentsJoinedByString:@","];
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

//将获取的视屏秀，图片秀数组数据解析为需要的url字符串数组
- (NSMutableArray*)getTargetImageUrlStrArr:(NSArray*)originArr{
    NSMutableArray *localTechnologyArr = [[NSMutableArray alloc]init];
    for (NSDictionary *localDict in originArr){
        [localTechnologyArr addObject:localDict[@"path"]];
    }
    return localTechnologyArr;
}

- (NSData*)getWavData:(NSData*)amrData{
    __block NSData *wavData = nil;
        if(amrData){
            NSString *amrPathStr = [[ShareHomePath GetShareHome] getAmrSoundPath];
            NSString *wavPathStr = [[ShareHomePath GetShareHome] getWavSoundPath];
            //NSLog(@"保存的服务器文件路径：%@",self.amrPathStr);
            BOOL suc =  [amrData writeToFile:amrPathStr atomically:YES];
            if (suc){
                NSLog(@"下载的amr 写入文件陈功");
                [AudioConverter convertAmrToWavAtPath:amrPathStr wavSavePath:wavPathStr asynchronize:NO completion:^(BOOL success, NSString * _Nullable resultPath) {
                    if (suc){
                        NSLog(@"服务器amr 转wav 转换成功");
                        wavData =  [[NSData dataWithContentsOfFile:wavPathStr] copy];
                        
                        NSDictionary *dict = @{};
                        [dict writeToFile:amrPathStr atomically:YES];
                        [dict writeToFile:wavPathStr atomically:YES];
                    }else{
                        [SVProgressHUD showErrorWithStatus:@"语音格式转换失败"];
                        NSLog(@"服务器amr 转wav 转换失败");
                    }
                    
                }];
            }else{
                [SVProgressHUD showErrorWithStatus:@"语音格式转换失败"];
                NSLog(@"下载的amr 写入文件失败");
            }
        }
    return wavData;
}


@end
