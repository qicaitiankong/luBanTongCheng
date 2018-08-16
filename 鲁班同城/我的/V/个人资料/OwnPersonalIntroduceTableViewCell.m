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
        [self.contentView addSubview:spaceView];
        //
        self.topDisplayLabel = [[CustomeLzhLabel alloc]initWithCustomerParamer:[UIFont getPingFangSCBold:16] titleColor:[UIColor colorWithHexString:@"#333333"] aligement:0];
        self.topDisplayLabel.frame = CGRectMake(15, spaceView.bottom, SCREEN_WIDTH - 30, 50);
        [self.contentView addSubview:self.topDisplayLabel];
        //
        self.introduceLabel = [[CustomeLzhLabel alloc]initWithCustomerParamer:[UIFont getPingFangSC:16] titleColor:[UIColor colorWithHexString:@"#666666"] aligement:0];
        self.introduceLabel.numberOfLines = 0;
        [self.contentView addSubview:self.introduceLabel];
        //
        self.soundView = [[MessageSoundView alloc]initWithFrame:CGRectMake(0, 0, 260, 40)];
        self.soundView.hidden = YES;
        [self.contentView addSubview:self.soundView];
        //
    }
    return self;
}

- (void)setModel:(OwnPersonalInfoModel*)model{
    _model = model;
    NSString *str = [model.introduceStr copy];
    NSData *soundData = model.nameSoundData;
    UIView *bottomView = self.topDisplayLabel;
    self.topDisplayLabel.text = @"个人介绍";
    if (str.length){
        self.introduceLabel.sd_resetLayout
        .leftEqualToView(self.topDisplayLabel)
        .rightSpaceToView(self.contentView, 10)
        .topSpaceToView(self.topDisplayLabel, 10)
        .autoHeightRatio(0);
        self.introduceLabel.text = str;
        bottomView = self.introduceLabel;
    }
    if (soundData){
        self.soundView.hidden = NO;
        self.soundView.sd_resetLayout
        .leftEqualToView(bottomView)
        .topSpaceToView(bottomView, 10)
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
