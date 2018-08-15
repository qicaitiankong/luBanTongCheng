//
//  ShareHomePath.m
//  Liankeji
//
//  Created by 李自豪 on 16/12/1.
//  Copyright © 2016年 haichuanhuiwulianxinxi. All rights reserved.
//

#import "ShareHomePath.h"
static ShareHomePath *shareHomePath = nil;
@implementation ShareHomePath
+(ShareHomePath*)GetShareHome{
   static dispatch_once_t once;
    dispatch_once(&once, ^{
        shareHomePath = [[ShareHomePath alloc]init];
    });
    return shareHomePath;
}

- (NSMutableString*)getDocumentsPath{//存放数据
    NSArray *arr = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES);
    NSString *docupath = [arr objectAtIndex:0];
    NSMutableString *documentPath = [[NSMutableString alloc]initWithString:docupath];
    return documentPath;
}
- (NSString *)getCachePath{//下次启动需要的缓存文件
    NSArray *arr = NSSearchPathForDirectoriesInDomains(NSCachesDirectory, NSUserDomainMask, YES);
    NSString *cache = [arr objectAtIndex:0];
    return cache;
}

- (NSString *)getTmpPath{//tmp文件夹存放下次应用启用不需要的文件
    NSString *tmp = NSTemporaryDirectory();
    return tmp;
}
- (NSString *)getImagePath:(NSString*)imageName format:(NSString*)format{//获取当前应用程序中一个图片的路径
    NSString *imagePath = [[NSBundle mainBundle] pathForResource:imageName ofType:format];
    return imagePath;
}

//
- (NSString *)getWavSoundPath{
    NSMutableString *doucumentPath = [self getDocumentsPath];
    NSLog(@">>>>>>>>doucumentPath=%@",doucumentPath);
    [doucumentPath appendString:@"/lzhWav203.wav"];
    [self createFileAtPath:doucumentPath error:nil];
    return doucumentPath;
}

- (NSString *)getAmrSoundPath{
    NSMutableString *doucumentPath = [self getDocumentsPath];
    NSLog(@">>>>>>>>doucumentPath=%@",doucumentPath);
    [doucumentPath appendString:@"/lzhAmr203.amr"];
    [self createFileAtPath:doucumentPath error:nil];
    return doucumentPath;
}


- (BOOL)createFileAtPath:(NSString *)path error:(NSError *__autoreleasing *)error {
    BOOL isSuccess  = NO;
    NSFileManager *manager = [NSFileManager defaultManager];
    // 如果文件夹路径不存在，那么先创建文件夹
    BOOL exist = [manager fileExistsAtPath:path];
    if (NO == exist) {
        NSLog(@"文件不存在");
        // 创建文件
      isSuccess = [[NSFileManager defaultManager] createFileAtPath:path contents:nil attributes:nil];
        if(isSuccess){
            NSLog(@"文件创建成功");
        }else{
            NSLog(@"文件创建失败");
        }
    }else{
        isSuccess = YES;
         NSLog(@"文件已经存在");
    }
   
    /*创建文件
     *参数1：创建文件的路径
     *参数2：创建文件的内容（NSData类型）
     *参数3：文件相关属性
     */
    
    
    return isSuccess;
}

@end
