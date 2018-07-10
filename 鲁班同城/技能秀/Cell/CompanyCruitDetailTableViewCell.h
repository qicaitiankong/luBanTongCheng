//
//  CompanyCruitDetailTableViewCell.h
//  鲁班同城
//
//  Created by apple on 2018/7/10.
//  Copyright © 2018年 Mac. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "DetailSmallButtView.h"
#import "CompanyCruitDetailModel.h"


@interface CompanyCruitDetailTableViewCell : UITableViewCell

@property (strong,nonatomic) UILabel *jobLabel;

@property (strong,nonatomic) DetailSmallButtView *detailButtView;

@property (strong,nonatomic) UIButton *applyForJobButt;

@property (strong,nonatomic) UILabel *detailContentLabel;

@property (strong,nonatomic) CompanyCruitDetailModel *model;

@property (strong,nonatomic) NSIndexPath *indexPath;

@property (copy,nonatomic) void (^cliclDetailBlock)(NSIndexPath *path);


@end
