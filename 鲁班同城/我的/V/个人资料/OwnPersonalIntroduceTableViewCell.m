//
//  OwnPersonalIntroduceTableViewCell.m
//  鲁班同城
//
//  Created by apple on 2018/8/16.
//  Copyright © 2018年 Mac. All rights reserved.
//

#import "OwnPersonalIntroduceTableViewCell.h"

@interface OwnPersonalIntroduceTableViewCell (){
    UIView *spaceView;
    
}

@property (strong,nonatomic) UILabel *topDisplayLabel;

@end


@implementation OwnPersonalIntroduceTableViewCell

-(instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self){
        spaceView = [[UIView alloc]initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, 25)];
        spaceView.backgroundColor = IMAGEVIEW_DEFAULT_COLOR;
        //
        self.topDisplayLabel = [[CustomeLzhLabel alloc]initWithCustomerParamer:[UIFont getPingFangSCBold:16] titleColor:[UIColor colorWithHexString:@"#333333"] aligement:0];
        self.topDisplayLabel.frame = CGRectMake(15, spaceView.bottom, SCREEN_WIDTH - 30, 50);
        //
        self.introduceLabel = [[CustomeLzhLabel alloc]initWithCustomerParamer:[UIFont getPingFangSC:16] titleColor:[UIColor colorWithHexString:@"#666666"] aligement:0];
        
        self.introduceLabel.numberOfLines = 0;
        //
        self.soundView = [[MessageSoundView alloc]initWithFrame:CGRectMake(0, 0, 260, 40)];
        self.soundView.hidden = YES;
        //
        NSArray *viewArr = @[spaceView,self.topDisplayLabel,self.introduceLabel,self.soundView];
        [self.contentView sd_addSubviews:viewArr];
        [self addConstraints];
    }
    return self;
}
- (void)addConstraints{
    spaceView.sd_layout
    .leftEqualToView(self.contentView)
    .topEqualToView(self.contentView)
    .rightEqualToView(self.contentView)
    .heightIs(25);
    
    self.topDisplayLabel.sd_layout
    .leftSpaceToView(self.contentView, 15)
    .rightSpaceToView(self.contentView, 15)
    .topSpaceToView(spaceView, 0)
    .heightIs(50);
    
    self.introduceLabel.sd_layout
    .leftEqualToView(self.topDisplayLabel)
    .rightEqualToView(self.topDisplayLabel)
    .topSpaceToView(self.topDisplayLabel, 10)
    .autoHeightRatio(0);
    
    self.soundView.sd_layout
    .leftEqualToView(self.topDisplayLabel)
    .topSpaceToView(self.introduceLabel, 15)
    .widthIs(260)
    .heightIs(40);
    
}



- (void)setModel:(OwnPersonalInfoModel*)model{
    _model = model;
    NSString *str = [model.introduceStr copy];
    UIView *bottomView = self.topDisplayLabel;
    self.topDisplayLabel.text = @"个人介绍";
    
    if (str.length){
        self.introduceLabel.sd_resetLayout
        .leftEqualToView(self.topDisplayLabel)
        .rightSpaceToView(self.contentView, 10)
        .topSpaceToView(self.topDisplayLabel, 10)
        .autoHeightRatio(0);
        self.introduceLabel.text = str;
        //bottomView = self.introduceLabel;
    }
    if (model.nameSoundUrlStr.length){
        self.soundView.hidden = NO;
        self.soundView.sd_resetLayout
        .leftEqualToView(self.introduceLabel)
        .topSpaceToView(self.introduceLabel, 10)
        .widthIs(260)
        .heightIs(40);
        bottomView = self.soundView;
    }else{
        self.soundView.hidden = YES;
    }
    
    [self setupAutoHeightWithBottomView:bottomView bottomMargin:15];
    
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
