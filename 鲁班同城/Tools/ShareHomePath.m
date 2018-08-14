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
    NSMutableString *documentPath = [arr objectAtIndex:0];
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
    NSString *directory = [NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES)objectAtIndex:0];;
    NSString* fileDirectory = [[[directory stringByAppendingPathComponent:@"lzhWav200"]
                                stringByAppendingPathExtension:@"wav"]
                               stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding];
    
    
    return fileDirectory;
}

@end
