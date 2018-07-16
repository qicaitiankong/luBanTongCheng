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


@interface DispatchTicketDetailBaoJiaTableViewCell : UITableViewCell

@property (strong,nonatomic) UIImageView *userImageView;

@property (strong,nonatomic) UILabel *nickNameLabel;

@property (strong,nonatomic) UILabel *baoJiaLabel;

@property (strong,nonatomic) UILabel *beizhuLabel;

@property (strong,nonatomic) StarView *xinxinView;

@property (strong,nonatomic) DispatchTicketDetailBaoJiaModel *model;


@end
