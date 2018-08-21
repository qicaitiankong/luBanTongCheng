//
//  OwnPersonalInfomationTopPictureGoupView.m
//  鲁班同城
//
//  Created by apple on 2018/7/6.
//  Copyright © 2018年 Mac. All rights reserved.
//

#import "OwnPersonalInfomationTopPictureGoupView.h"

@interface OwnPersonalInfomationTopPictureGoupView (){
   
    UILabel *titleLabel;
    UIView *smallVerticalSpaceLine;
    UILabel *satisfyLabel;
    
}
@end

@implementation OwnPersonalInfomationTopPictureGoupView
@synthesize navReturnButt;
@synthesize shareButt;
@synthesize addFriendButt;
@synthesize editButt;

- (instancetype)initWithFrame:(CGRect)frame targetUseId:(NSInteger)targetUserID{
    self = [super initWithFrame:frame];
    if (self) {
        self.backgroundColor = [UIColor whiteColor];
        //
        UIImage *bigImage = [UIImage imageNamed:@"test05.jpeg"];
        CGFloat imageDisplayWidth = frame.size.width;
        CGFloat imageDisplayheight = imageDisplayWidth / (bigImage.size.width / bigImage.size.height);
        //
        //CGFloat returnButtTopSpace = STATUSBAR_HEIGHT + 5 ;
        //
        self.topBigImaView = [[UIImageView alloc]init];
        self.topBigImaView.backgroundColor = [UIColor grayColor];
        [self.topBigImaView setImage:bigImage];
        self.topBigImaView.frame = CGRectMake(0, 0, frame.size.width, imageDisplayheight);
        [self addSubview:self.topBigImaView];
        //
        navReturnButt = [NavTools getOwnNavStyleWhiteReturnButt];
        [self addSubview:navReturnButt];
        //
        shareButt = [[CustomerImageButt alloc]initWithFrame:CGRectMake(frame.size.width - 15 - 19, navReturnButt.top, 19, 19)];
        [shareButt.imageView setImage:[UIImage imageNamed:@"shareNav"]];
        [self addSubview:shareButt];
        //
        addFriendButt = [[CustomerImageButt alloc]initWithFrame:CGRectMake(shareButt.left - 20 - 18, navReturnButt.top, 18, 19)];
        [addFriendButt.imageView setImage:[UIImage imageNamed:@"addFriend"]];
        [self addSubview:addFriendButt];
        //
        CGFloat labelWidth = [LzhReturnLabelHeight getLabelWidth:@"鲁班同城" font:[UIFont getPingFangSCMedium:16] targetHeight:19];
        titleLabel = [[CustomeLzhLabel alloc]initWithCustomerParamer:[UIFont getPingFangSCMedium:16] titleColor:[UIColor colorWithHexString:@"#F5F5F5"] aligement:1];
        titleLabel.frame =  CGRectMake(0, navReturnButt.top, labelWidth, navReturnButt.height);
        titleLabel.center = CGPointMake(frame.size.width / 2, titleLabel.centerY);
        titleLabel.text = @"鲁班同城";
        [self addSubview:titleLabel];
        //
        self.userlogoImaView = [[UIImageView alloc]initWithFrame:CGRectMake(5, self.topBigImaView.bottom - 20, SCREEN_WIDTH * 0.258, SCREEN_WIDTH * 0.258)];
        self.userlogoImaView.backgroundColor = IMAGEVIEW_DEFAULT_COLOR;
        self.userlogoImaView.layer.cornerRadius = self.userlogoImaView.width / 2;
        self.userlogoImaView.clipsToBounds = YES;
        [self addSubview:self.userlogoImaView];
        //
         smallVerticalSpaceLine = [[UIView alloc]initWithFrame:CGRectMake(0, self.topBigImaView.bottom +10, 2, 14)];
        smallVerticalSpaceLine.backgroundColor = [UIColor grayColor];
        smallVerticalSpaceLine.center = CGPointMake(frame.size.width / 2, smallVerticalSpaceLine.center.y);
        [self addSubview:smallVerticalSpaceLine];
        //
        self.fenSiLabel = [[CustomeLzhLabel alloc] initWithCustomerParamer:[UIFont getPingFangSCMedium:14] titleColor:[UIColor colorWithHexString:@"#999999"] aligement:2];
        CGFloat fenSiLabelLeft = self.userlogoImaView.left + self.userlogoImaView.width + 5;
        CGFloat fenSiWidth = smallVerticalSpaceLine.left - fenSiLabelLeft - 5;
        self.fenSiLabel.frame = CGRectMake(fenSiLabelLeft, smallVerticalSpaceLine.top, fenSiWidth, smallVerticalSpaceLine.height);
        [self addSubview:self.fenSiLabel];
        //
        self.concernLabel = [[CustomeLzhLabel alloc] initWithCustomerParamer:[UIFont getPingFangSCMedium:14] titleColor:[UIColor colorWithHexString:@"#999999"] aligement:0];
        CGFloat concernLabelLeft = smallVerticalSpaceLine.left + smallVerticalSpaceLine.width + 5;
        CGFloat concernWidth = frame.size.width - concernLabelLeft - 5;
        self.concernLabel.frame = CGRectMake(concernLabelLeft, smallVerticalSpaceLine.top, concernWidth, smallVerticalSpaceLine.height);
        [self addSubview:self.concernLabel];
        //
        //添加雇主使用时显示信息
        self.changeNameButt = [[CustomeStyleCornerButt alloc]initWithFrame:CGRectMake(frame.size.width - 60, smallVerticalSpaceLine.top, 50, 25) backColor:[UIColor whiteColor] cornerRadius:5 title:@"改名" titleColor:[UIColor colorWithHexString:@"#999999"] font:[UIFont getPingFangSCMedium:14]];
        self.changeNameButt.layer.borderWidth = 1;
        self.changeNameButt.layer.borderColor =  [UIColor colorWithHexString:@"#E3E3E3"].CGColor;
        self.changeNameButt.hidden = YES;
        [self addSubview:self.changeNameButt];
        //
        self.employmentNameLabel = [[CustomeLzhLabel alloc]initWithParamer:15 titleColor:[UIColor colorWithHexString:@"#999999"] aligement:0];
        self.employmentNameLabel.frame = CGRectMake(self.userlogoImaView.width + 10, smallVerticalSpaceLine.top, self.changeNameButt.left - self.userlogoImaView.left - self.userlogoImaView.width - 20, self.changeNameButt.height);
        self.employmentNameLabel.hidden = YES;
        [self addSubview:self.employmentNameLabel];
        //
        CGFloat editLeft = self.userlogoImaView.left + self.userlogoImaView.width + 10;
        CGFloat editWith = frame.size.width - editLeft - 15;
        //
        NSString *editButtTitle = @"编辑个人资料";
        //是自己的资料才显示否则显示关注
        if (targetUserID != [[lzhGetAccountInfo getAccount].userID integerValue]){
            editButtTitle = @" 关注";
        }
        //
        UIView *editButtTopView = nil;
        if ([lzhGetAccountInfo getAccount].identityFlag){
             editButtTopView = self.employmentNameLabel;
        }else{
           editButtTopView = self.fenSiLabel;
        }
        editButt = [[CustomeStyleCornerButt alloc] initWithFrame:CGRectMake(editLeft, editButtTopView.bottom + 10, editWith, 30) backColor:[UIColor whiteColor] cornerRadius:15 title:editButtTitle titleColor:[UIColor colorWithHexString:@"#666666"] font:[UIFont getPingFangSCMedium:14]];
        editButt.layer.borderWidth = 1;
        editButt.layer.borderColor = [UIColor colorWithHexString:@"#E3E3E3"].CGColor;
        if (targetUserID != [[lzhGetAccountInfo getAccount].userID integerValue]){
            [editButt.loginButt setImage:[UIImage imageNamed:@"addConcern"] forState:UIControlStateNormal];
        }
        [self addSubview:editButt];
        //
        CGFloat homeLabelHeight = 20;
        CGFloat homeLabelWidth = [LzhReturnLabelHeight getLabelWidth:@"字   字字字字 字字字字字" font:[UIFont getPingFangSCMedium:14] targetHeight:homeLabelHeight];
        
        self.sexAndHomeLabel = [[CustomeLzhLabel alloc]initWithCustomerParamer:[UIFont getPingFangSCMedium:14] titleColor:[UIColor colorWithHexString:@"#666666"] aligement:0];
        self.sexAndHomeLabel.frame = CGRectMake(self.userlogoImaView.left, self.userlogoImaView.bottom + 10, homeLabelWidth, homeLabelHeight);
        [self addSubview:self.sexAndHomeLabel];
        //
        satisfyLabel = [[CustomeLzhLabel alloc]initWithCustomerParamer:[UIFont getPingFangSCMedium:14] titleColor:[UIColor colorWithHexString:@"#666666"] aligement:2];
        satisfyLabel.frame = CGRectMake(self.sexAndHomeLabel.right + 5, self.sexAndHomeLabel.top, 50, self.sexAndHomeLabel.height);
        satisfyLabel.text = @"满意度";
        [self addSubview:satisfyLabel];
        //
        self.starGroupView = [[StarView alloc]initWithFrame:CGRectMake(satisfyLabel.right + 10, satisfyLabel.top, frame.size.width - satisfyLabel.right - 25 , satisfyLabel.height)];
        [self addSubview:self.starGroupView];
        //
        [self setFrame:CGRectMake(self.x, self.y, self.width, self.starGroupView.bottom + 5)];
    }
    return self;
}

//雇主

- (void)displayForEmployment{
    smallVerticalSpaceLine.hidden = YES;
    self.fenSiLabel.hidden = YES;
    self.concernLabel.hidden = YES;
    self.starGroupView.hidden = YES;
    satisfyLabel.hidden = YES;
    //
    self.employmentNameLabel.hidden = NO;
    self.changeNameButt.hidden = NO;
    [editButt.loginButt setTitle:@"历史派单" forState:UIControlStateNormal];
}


- (void)setEditButtDisplayByValue:(BOOL)isConcenrned{
    if (isConcenrned){
        [editButt.loginButt setImage:[UIImage imageNamed:@"duiHao"] forState:UIControlStateNormal];
        [editButt.loginButt setTitle:@"已关注" forState:UIControlStateNormal];
    }else{
         [editButt.loginButt setImage:[UIImage imageNamed:@"addConcern"] forState:UIControlStateNormal];
        [editButt.loginButt setTitle:@"关注" forState:UIControlStateNormal];
    }
}

- (void)findOwnInfoDisplay{
    UIImage *dataImage = nil;
    [editButt.loginButt setImage:dataImage forState:UIControlStateNormal];
    [editButt.loginButt setTitle:@"编辑个人资料" forState:UIControlStateNormal];
}


@end
