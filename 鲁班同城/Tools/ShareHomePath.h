//
//  ShareHomePath.h
//  Liankeji
//
//  Created by 李自豪 on 16/12/1.
//  Copyright © 2016年 haichuanhuiwulianxinxi. All rights reserved.
//

#import <Foundation/Foundation.h>
@interface ShareHomePath : NSObject
+(ShareHomePath*)GetShareHome;
- (NSMutableString*)getDocumentsPath;
- (NSString *)getCachePath;
- (NSString *)getTmpPath;
- (NSString *)getImagePath:(NSString*)imageName format:(NSString*)format;//获取当前应用程序中一个图片的路径

- (NSString *)getWavSoundPath;

- (NSString *)getAmrSoundPath;

@end
