//
//  UIImage+OwnCalculateImageSize.m
//  鲁班同城
//
//  Created by apple on 2018/8/8.
//  Copyright © 2018年 Mac. All rights reserved.
//

#import "UIImage+OwnCalculateImageSize.h"

@implementation UIImage (OwnCalculateImageSize)

+ (double) getImageSize:(UIImage*)image{
        NSData *data = UIImagePNGRepresentation(image);
        if (!data) {
            data = UIImageJPEGRepresentation(image, 0.5);//需要改成0.5才接近原图片大小，原因请看下文
        }
        double dataLength = [data length] * 1.0;
        NSArray *typeArray = @[@"bytes",@"KB",@"MB",@"GB",@"TB",@"PB", @"EB",@"ZB",@"YB"];
        NSInteger index = 0;
        while (dataLength > 1024) {
            dataLength /= 1024.0;
            index ++;
        }
    NSLog(@"image = %.3f %@",dataLength,typeArray[index]);
    return dataLength;
    
}


+ (NSString *)contentTypeForImageData:(NSData *)data {
    uint8_t c;
    [data getBytes:&c length:1];
    switch (c) {
        case 0xFF:
            return @"jpeg";
        case 0x89:
            return @"png";
        case 0x47:
            return @"gif";
        case 0x49:
        case 0x4D:
            return @"tiff";
        case 0x52:
            if ([data length] < 12) {
                return nil;
            }
            NSString *testString = [[NSString alloc] initWithData:[data subdataWithRange:NSMakeRange(0, 12)] encoding:NSASCIIStringEncoding];
            if ([testString hasPrefix:@"RIFF"] && [testString hasSuffix:@"WEBP"]) {
                return @"webp";
            }
            return nil;
    }
    return nil;
}



@end
