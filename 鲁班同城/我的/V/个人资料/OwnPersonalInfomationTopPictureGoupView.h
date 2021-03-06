//
//  OwnPersonalInfomationTopPictureGoupView.h
//  鲁班同城
//
//  Created by apple on 2018/7/6.
//  Copyright © 2018年 Mac. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "CustomeStyleCornerButt.h"
#import  "CustomerImageButt.h"
#import "StarView.h"

@interface OwnPersonalInfomationTopPictureGoupView : UIView

@property (strong,nonatomic) UIImageView *topBigImaView;

@property (strong,nonatomic) CustomerImageButt *navReturnButt;

@property (strong,nonatomic) CustomerImageButt *addFriendButt;

@property (strong,nonatomic) CustomerImageButt *shareButt;

@property (strong,nonatomic) CustomeStyleCornerButt *editButt;

@property (strong,nonatomic) UIImageView *userlogoImaView;

//林工使用
@property (strong,nonatomic) UILabel *fenSiLabel;

@property (strong,nonatomic) UILabel *concernLabel;

@property (strong,nonatomic) UILabel *sexAndHomeLabel;

@property (strong,nonatomic) StarView * starGroupView;
//
//雇主使用属性
@property (strong,nonatomic) CustomeStyleCornerButt *changeNameButt;

@property (strong,nonatomic) CustomeLzhLabel *employmentNameLabel;



- (instancetype)initWithFrame:(CGRect)frame targetUseId:(NSInteger)targetUserID;

//根据关注修改是否显示
- (void)setEditButtDisplayByValue:(BOOL)isConcenrned;
//显示个人资料展示
- (void)findOwnInfoDisplay;

//雇主使用调整隐藏零工的
- (void)displayForEmployment;

@end
