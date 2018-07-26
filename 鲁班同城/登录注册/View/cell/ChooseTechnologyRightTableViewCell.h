//
//  ChooseTechnologyRightTableViewCell.h
//  鲁班同城
//
//  Created by apple on 2018/7/6.
//  Copyright © 2018年 Mac. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "ChooseTechnologyLeftModel.h"


@interface ChooseTechnologyRightTableViewCell : UITableViewCell

@property (strong,nonatomic) UIImageView *userImageView;

@property (strong,nonatomic) UILabel *jobNameLabel;

@property (strong,nonatomic) UIImageView *rightImageView;


@property (strong,nonatomic) ChooseTechnologyLeftModel *model;

@property (strong,nonatomic) NSIndexPath *indexPath;


- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier cellHeight:(CGFloat)height cellWidth:(CGFloat)width;


@end
