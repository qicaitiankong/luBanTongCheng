//
//  TakePhotoBaseViewController.h
//  鲁班同城
//
//  Created by apple on 2018/8/6.
//  Copyright © 2018年 Mac. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface TakePhotoBaseViewController : UIViewController


@property (copy,nonatomic) void (^selectedImageBlock)(NSString *pictureBase64str,UIImage *selectedPicture);


- (void)callActionSheetFunc;


@end
