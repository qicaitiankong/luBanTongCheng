//
//  CommentAnswerTableViewCell.h
//  鲁班同城
//
//  Created by apple on 2018/8/23.
//  Copyright © 2018年 Mac. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "CommentModel.h"
#import "CustomeLabelButt.h"

@interface CommentAnswerTableViewCell : UITableViewCell

@property (strong,nonatomic) UIImageView *userImageView;

@property (strong,nonatomic) CustomeLabelButt *concernButt;

@property (strong,nonatomic) UILabel *nameLabel;

@property (strong,nonatomic) UILabel *commentContentLabel;

@property (strong,nonatomic) UILabel *timeLabel;

@property (strong,nonatomic) UILabel *praiseLabel;

@property (strong,nonatomic) UILabel *leftpraisedLabel;

@property (strong,nonatomic) CustomerImageButt *praiseButt;

@property (strong,nonatomic) NSIndexPath *indexPath;

@property (strong,nonatomic) CommentModel *model;


@property (copy,nonatomic) void (^clickAddConcernBlock)(void);

@property (copy,nonatomic) void (^clickGoodBlock)(NSIndexPath *indexPath);


@end
