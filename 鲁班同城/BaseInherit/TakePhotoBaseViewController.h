//
//  TakePhotoBaseViewController.h
//  鲁班同城
//
//  Created by apple on 2018/8/6.
//  Copyright © 2018年 Mac. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface TakePhotoBaseViewController : UIViewController


@property (copy,nonatomic) void (^selectedImageBlock)(NSData *pictureData,UIImage *selectedPicture);


- (void)callActionSheetFunc;

//带有删除样式的
- (void)callActionSheetWithChangeStyleFunc:(void (^)(void))deleteBolck insteadBlock:(void (^)(void))insteadBlock;


@end
