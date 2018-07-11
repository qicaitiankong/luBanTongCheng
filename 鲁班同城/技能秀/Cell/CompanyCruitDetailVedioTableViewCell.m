//
//  CompanyCruitDetailVedioTableViewCell.m
//  鲁班同城
//
//  Created by apple on 2018/7/11.
//  Copyright © 2018年 Mac. All rights reserved.
//

#import "CompanyCruitDetailVedioTableViewCell.h"

@interface CompanyCruitDetailVedioTableViewCell (){
    CGFloat leftSpace;
    UIView *topLineView;
}
@end

@implementation CompanyCruitDetailVedioTableViewCell
@synthesize picContainerView;

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self){
        leftSpace = 15;
        self.contentView.backgroundColor = [UIColor whiteColor];
        //
        topLineView = [[UIView alloc]initWithFrame:CGRectMake(leftSpace, 0, SCREEN_WIDTH - 2 * leftSpace, 1)];
        topLineView.backgroundColor = [UIColor colorWithHexString:@"#BBBBBB"];
        [self.contentView addSubview:topLineView];
        //
        self.topTipLabel = [[CustomeLzhLabel alloc]initWithCustomerParamer:[UIFont getPingFangSCMedium:15] titleColor:[UIColor colorWithHexString:@"#666666"] aligement:0];
        self.topTipLabel.frame = CGRectMake(leftSpace,topLineView.bottom + 10, SCREEN_WIDTH - 30, 15);
        [self.contentView addSubview:self.topTipLabel];
        //
        picContainerView = [SDWeiXinPhotoContainerView new];
        picContainerView.isVideoUse = YES;
        [self.contentView addSubview:picContainerView];
        //
        picContainerView.sd_layout
        .leftEqualToView(self.topTipLabel);

    }
    return self;
}

- (void)setModel:(CompanyCruitDetailModel *)model
{
    _model = model;
    //
    self.topTipLabel.text = @"小视频";
    picContainerView.picPathStringsArray = model.imageUrlArr;
    UIView *bottomView = nil;
    //
    CGFloat picContainerTopMargin = 0;
    if (model.imageUrlArr.count) {
        picContainerTopMargin = 10;
        picContainerView.sd_layout.topSpaceToView(self.topTipLabel, picContainerTopMargin);
        bottomView = picContainerView;
    }else{
        bottomView = self;
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
