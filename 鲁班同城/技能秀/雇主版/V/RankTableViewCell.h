//
//  RankTableViewCell.h
//  鲁班同城
//
//  Created by apple on 2018/7/17.
//  Copyright © 2018 Mac. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "RankModel.h"

@interface RankTableViewCell : UITableViewCell

@property (strong,nonatomic) UILabel *rankLabel;

@property (strong,nonatomic) UIImageView *userImageView;

@property (strong,nonatomic) UILabel *nickLabel;

@property (strong,nonatomic) UILabel *jobLabel;

@property (strong,nonatomic) CustomeStyleCornerButt *ownRightButt;

@property (strong,nonatomic) RankModel *model;

@property (strong,nonatomic) NSIndexPath *indexPath;

@end
