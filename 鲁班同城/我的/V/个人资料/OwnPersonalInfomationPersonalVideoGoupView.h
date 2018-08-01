//
//  OwnPersonalInfomationPersonalVideoGoupView.h
//  鲁班同城
//
//  Created by apple on 2018/7/6.
//  Copyright © 2018年 Mac. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "SDWeiXinPhotoContainerView.h"


@interface OwnPersonalInfomationPersonalVideoGoupView : UIView

@property (strong,nonatomic) UILabel *topTipLabel;

@property (strong,nonatomic) SDWeiXinPhotoContainerView *picContainView;

- (void)givePictureArr:(NSArray*)arr;


@end
