//
//  DispatchTicketDetailBaoJiaTableViewCell.m
//  鲁班同城
//
//  Created by apple on 2018/7/16.
//  Copyright © 2018 Mac. All rights reserved.
//

#import "DispatchTicketDetailBaoJiaTableViewCell.h"
#import "CustomeStyleCornerButt.h"

@interface DispatchTicketDetailBaoJiaTableViewCell (){
    CustomeStyleCornerButt *findUpButt;
    ImageAndLabelView *communicateButt;
    CustomeStyleCornerButt *employButt;
    CGFloat leftSpace;
    CGFloat imageViewWidth;
    CGFloat buttWidth;
    CGFloat buttHeight;
    CGFloat buttSpace;
}
@end

@implementation DispatchTicketDetailBaoJiaTableViewCell

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self){
        self.contentView.backgroundColor = [UIColor whiteColor];
        //
        leftSpace = 15;
        imageViewWidth = SCREEN_WIDTH * 0.106;
        //
        self.userImageView = [[UIImageView alloc]init];
        self.userImageView.backgroundColor = IMAGEVIEW_DEFAULT_COLOR;
        self.userImageView.layer.cornerRadius = imageViewWidth / 2;
        self.userImageView.clipsToBounds = YES;
        //
        self.nickNameLabel = [[CustomeLzhLabel alloc]initWithCustomerParamer:[UIFont getPingFangSCMedium:13] titleColor:[UIColor colorWithHexString:@"#333333"] aligement:0];
        //
        self.xinxinView = [[StarView alloc]initWithFrameCustomeStyle:CGRectMake(0, 0, SCREEN_WIDTH * 0.213, imageViewWidth / 2) starWidth:12];
        self.xinxinView.backgroundColor = [UIColor whiteColor];
        //
         buttWidth = SCREEN_WIDTH * 0.138;
         buttHeight = buttWidth / 2;;
         buttSpace = 10;
        
        findUpButt = [[CustomeStyleCornerButt alloc] initWithFrame:CGRectMake(0, 0, buttWidth, buttHeight) backColor:[UIColor whiteColor] cornerRadius:5 title:@"查看" titleColor:[UIColor colorWithHexString:@"#666666"] font:[UIFont getPingFangSCMedium:10]];
        findUpButt.layer.cornerRadius = 5;
        findUpButt.layer.borderColor = [UIColor colorWithHexString:@"#999999"].CGColor;
        findUpButt.layer.borderWidth = 1;
        WS(weakSelf);
        findUpButt.clickButtBlock = ^{
            [weakSelf clickButt:0];
        };
        //
        communicateButt = [[ImageAndLabelView alloc]initWithFrameSecondStyle:CGRectMake(0, 0, findUpButt.width, findUpButt.height) image:[UIImage imageNamed:@"icon_message_white"] title:@"沟通" font:[UIFont getPingFangSCMedium:10]  titleColor:[UIColor whiteColor] imageSize:CGSizeMake(14, 13)];
        communicateButt.backgroundColor = [UIColor colorWithHexString:@"#FF7E00"];
        communicateButt.layer.cornerRadius = 5;
        communicateButt.leftImageView.backgroundColor = communicateButt.backgroundColor;
        communicateButt.rightLabel.backgroundColor = communicateButt.backgroundColor;
        communicateButt.clickBackButt  = ^{
            [weakSelf clickButt:1];
        };
        //
        UIColor *employmentColor = SPECIAL_BLUE_COLOR;
         employButt = [[CustomeStyleCornerButt alloc] initWithFrame:CGRectMake(0, 0, findUpButt.width, findUpButt.height) backColor:employmentColor cornerRadius:5 title:@"雇佣" titleColor:[UIColor whiteColor] font:[UIFont getPingFangSCMedium:10]];
        employButt.clickButtBlock = ^{
            [weakSelf clickButt:2];
        };
        //
         self.baoJiaLabel = [[CustomeLzhLabel alloc]initWithCustomerParamer:[UIFont getPingFangSCMedium:13] titleColor:[UIColor colorWithHexString:@"#333333"] aligement:0];
        //
         self.beizhuLabel = [[CustomeLzhLabel alloc]initWithCustomerParamer:[UIFont getPingFangSCMedium:13] titleColor:[UIColor colorWithHexString:@"#333333"] aligement:0];
        self.beizhuLabel.numberOfLines = 0;
        //
        self.bottomGroupView = [[DispatchOrderDetailCellSureServiceCompleteGroupView alloc]initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH - 2 * leftSpace, SCREEN_WIDTH * 0.106 + 100)];
        self.bottomGroupView.messageButtView.clickBackButt = ^{
            [weakSelf clickButt:3];
        };
        self.bottomGroupView.mobileButtView.clickBackButt = ^{
            [weakSelf clickButt:4];
        };
        self.bottomGroupView.cancelButtView.clickBackButt = ^{
            [weakSelf clickButt:5];
        };
        self.bottomGroupView.sureServiceButt.clickButtBlock = ^{
            [weakSelf clickButt:6];
        };
        //
        NSArray *viewArr = @[self.userImageView,self.nickNameLabel,self.xinxinView,findUpButt,communicateButt,employButt,self.baoJiaLabel,self.beizhuLabel,self.bottomGroupView];
        [self.contentView sd_addSubviews:viewArr];
        //
        [self addOwnConstraints];
    }
    return self;
}

- (void)addOwnConstraints{
    //
    self.userImageView.sd_layout
    .leftSpaceToView(self.contentView, leftSpace)
    .topSpaceToView(self.contentView, 20)
    .widthIs(imageViewWidth)
    .heightEqualToWidth();
    //
    self.nickNameLabel.sd_layout
    .leftSpaceToView(self.userImageView, SCREEN_WIDTH * 0.053)
    .widthIs(SCREEN_WIDTH * 0.213)
    .topEqualToView(self.userImageView)
    .heightIs(imageViewWidth / 2);
    //
    self.xinxinView.sd_layout
    .leftEqualToView(self.nickNameLabel)
    .topSpaceToView(self.nickNameLabel, 0)
    .widthRatioToView(self.nickNameLabel, 1)
    .heightIs(imageViewWidth / 2);
    //
    findUpButt.sd_layout
    .leftSpaceToView(self.nickNameLabel, SCREEN_WIDTH * 0.08)
    .widthIs(buttWidth)
    .centerYEqualToView(self.userImageView)
    .heightIs(buttHeight);
    //
    communicateButt.sd_layout
    .leftSpaceToView(findUpButt, buttSpace)
    .widthIs(buttWidth)
    .centerYEqualToView(self.userImageView)
    .heightIs(buttHeight);
    //
    employButt.sd_layout
    .leftSpaceToView(communicateButt, buttSpace)
    .widthIs(buttWidth)
    .centerYEqualToView(self.userImageView)
    .heightIs(buttHeight);
    //
    self.baoJiaLabel.sd_layout
    .leftEqualToView(self.userImageView)
    .rightSpaceToView(self.contentView, leftSpace)
    .topSpaceToView(self.userImageView, 20)
    .heightIs(15);
    //
    self.beizhuLabel.sd_layout
    .leftEqualToView(self.userImageView)
    .rightSpaceToView(self.contentView, leftSpace)
    .topSpaceToView(self.baoJiaLabel, 20)
    .autoHeightRatio(0);
    //
    self.bottomGroupView.sd_layout
    .leftEqualToView(self.beizhuLabel)
    .topSpaceToView(self.beizhuLabel, 10)
    .rightSpaceToView(self.contentView, leftSpace)
    .heightIs(SCREEN_WIDTH * 0.106 + 115);
    //
}

- (void)setModel:(DispatchTicketDetailBaoJiaModel*)model{
    _model = model;
    if (model){
        [self.userImageView setImage:model.userImage];
        self.nickNameLabel.text = [model.nickNameStr copy];
        self.baoJiaLabel.text = [model.baoJiaNameStr copy];
        self.beizhuLabel.text = [model.beiZhuNameStr copy];
        [self.xinxinView setYellowStar:[model.xinxinStr floatValue]];
        //
        self.bottomGroupView.sd_resetLayout
        .leftEqualToView(self.beizhuLabel)
        .topSpaceToView(self.beizhuLabel, 10)
        .rightSpaceToView(self.contentView, leftSpace)
        .heightIs(SCREEN_WIDTH * 0.106 + 115);
        //
        UIView *bottomView = nil;
        if (model.shouldDisplayBottomView){
            bottomView = self.bottomGroupView;
            self.bottomGroupView.hidden = NO;
            //
            [self.bottomGroupView.userImageView setImage:model.userImage];
            self.bottomGroupView.nickNameLabel.text = [model.nickNameStr copy];
            [self.bottomGroupView.xinxinView setYellowStar:[model.xinxinStr floatValue]];
            self.bottomGroupView.messageTipLabel.text = @"已通知师傅接单，请保持电话通畅。";
            
        }else{
            bottomView = self.beizhuLabel;
            self.bottomGroupView.hidden = YES;
        }
        [self setupAutoHeightWithBottomView:bottomView bottomMargin:15];
    }
}

- (void)clickButt:(NSInteger)flag{
    if (self.clickButtBlock){
        self.clickButtBlock(flag,self.path);
    }
}


- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
