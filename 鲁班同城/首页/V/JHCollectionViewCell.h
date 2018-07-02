//
//  JHCollectionViewCell.h
//  WaterfallCollection
//
//  Created by Jivan on 2017/3/17.
//  Copyright © 2017年 Jivan. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "ConcernDisplayView.h"
#import "WaterCellRecuritJobView.h"
#import "FirstPageInfoModel.h"

@interface JHCollectionViewCell : UICollectionViewCell

@property (strong, nonatomic) UIImageView *topImageView;

@property (strong,nonatomic) UIImageView *companyLogoView;

@property (strong, nonatomic) UILabel *companyNamelabel;
//招工信息
@property (strong,nonatomic) WaterCellRecuritJobView * firstJobInfoView;

@property (strong,nonatomic) WaterCellRecuritJobView * secondJobInfoView;


@property (strong,nonatomic) ConcernDisplayView *concernView;

@property (strong,nonatomic) FirstPageInfoModel *model;

- (void)setModel:(FirstPageInfoModel*)model;

@end
