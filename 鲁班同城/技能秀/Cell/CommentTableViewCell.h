//
//  CommentTableViewCell.h
//  鲁班同城
//
//  Created by apple on 2018/8/22.
//  Copyright © 2018年 Mac. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "CommentModel.h"

@interface CommentTableViewCell : UITableViewCell

@property (strong,nonatomic) UIImageView *userImageView;

@property (strong,nonatomic) UILabel *nameLabel;

@property (strong,nonatomic) UILabel *commentContentLabel;

@property (strong,nonatomic) UILabel *timeLabel;

@property (strong,nonatomic) UILabel *praiseLabel;

@property (strong,nonatomic) CustomerImageButt *praiseButt;

@property (strong,nonatomic) CustomeStyleCornerButt *answerButtView;

@property (strong,nonatomic) NSIndexPath *indexPath;

@property (strong,nonatomic) CommentModel *model;


@end
