//
//  OwnPersonalPictureTableViewCell.m
//  鲁班同城
//
//  Created by apple on 2018/8/16.
//  Copyright © 2018年 Mac. All rights reserved.
//

#import "OwnPersonalPictureTableViewCell.h"
#import "SDWeiXinPhotoContainerView.h"


@interface OwnPersonalPictureTableViewCell (){
    UIView *spaceView;
    SDWeiXinPhotoContainerView *pictureView;
}

@property (strong,nonatomic) UILabel *topDisplayLabel;

@end


@implementation OwnPersonalPictureTableViewCell

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
        pictureView = [SDWeiXinPhotoContainerView new];
        [self.contentView addSubview:pictureView];
        pictureView.sd_layout
        .leftEqualToView(self.topDisplayLabel)
        .topSpaceToView(self.topDisplayLabel, 10);
    }
    return self;
}

- (void)setModel:(OwnPersonalInfoModel*)model{
    _model = model;
    UIView *bottomView = self.topDisplayLabel;
    
    NSArray *picUrlArr = nil;
    if (_path.row == 0){//视频使用
        picUrlArr = model.videoUrlStrArr;
        self.topDisplayLabel.text = @"技能-视频秀";
        bottomView = pictureView;
    }else{//图片使用
        picUrlArr = model.pictureUrlStrArr;
        self.topDisplayLabel.text = @"技能-图片秀";
        bottomView = pictureView;
    }
    [pictureView setPicPathStringsArray:picUrlArr];
    
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
