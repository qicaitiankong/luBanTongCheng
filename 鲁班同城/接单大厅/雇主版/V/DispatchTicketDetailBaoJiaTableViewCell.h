//
//  DispatchTicketDetailBaoJiaTableViewCell.h
//  鲁班同城
//
//  Created by apple on 2018/7/16.
//  Copyright © 2018 Mac. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "StarView.h"
#import "DispatchTicketDetailBaoJiaModel.h"
#import "DispatchOrderDetailCellSureServiceCompleteGroupView.h"
#import "MessageSoundView.h"


@interface DispatchTicketDetailBaoJiaTableViewCell : UITableViewCell

@property (strong,nonatomic) UIImageView *userImageView;

@property (strong,nonatomic) UILabel *nickNameLabel;

@property (strong,nonatomic) UILabel *baoJiaLabel;

@property (strong,nonatomic) UILabel *beizhuLabel;

@property (strong,nonatomic) StarView *xinxinView;

@property (strong,nonatomic) MessageSoundView *soundView;


@property (strong,nonatomic) DispatchTicketDetailBaoJiaModel *model;

@property (strong,nonatomic) NSIndexPath *indexPath;

@property (strong,nonatomic) DispatchOrderDetailCellSureServiceCompleteGroupView *bottomGroupView;

@property (copy,nonatomic) void (^clickButtBlock)(NSInteger index,NSIndexPath *path);

@property (copy,nonatomic) void (^stopVoiceBlock)(NSIndexPath *path);

@end
