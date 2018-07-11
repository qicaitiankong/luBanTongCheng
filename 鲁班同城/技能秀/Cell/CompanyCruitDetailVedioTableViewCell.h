//
//  CompanyCruitDetailVedioTableViewCell.h
//  鲁班同城
//
//  Created by apple on 2018/7/11.
//  Copyright © 2018年 Mac. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "CompanyCruitDetailModel.h"
#import "SDWeiXinPhotoContainerView.h"

@interface CompanyCruitDetailVedioTableViewCell : UITableViewCell

@property (strong,nonatomic) UILabel *topTipLabel;

@property (strong,nonatomic) CompanyCruitDetailModel *model;

@property (strong,nonatomic) SDWeiXinPhotoContainerView *picContainerView;

@end
