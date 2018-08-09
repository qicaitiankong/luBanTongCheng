//
//  UIImage+OwnCalculateImageSize.h
//  鲁班同城
//
//  Created by apple on 2018/8/8.
//  Copyright © 2018年 Mac. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UIImage (OwnCalculateImageSize)

+ (double) getImageSize:(UIImage*)image;

+ (NSString *)contentTypeForImageData:(NSData *)data;

@end
