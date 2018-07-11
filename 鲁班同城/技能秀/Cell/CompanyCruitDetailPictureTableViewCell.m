//
//  CompanyCruitDetailPictureTableViewCell.m
//  鲁班同城
//
//  Created by apple on 2018/7/11.
//  Copyright © 2018年 Mac. All rights reserved.
//

#import "CompanyCruitDetailPictureTableViewCell.h"
#import "SDWeiXinPhotoContainerView.h"

@interface CompanyCruitDetailPictureTableViewCell (){
    CGFloat leftSpace;
    SDWeiXinPhotoContainerView *picContainerView;
}
@end


@implementation CompanyCruitDetailPictureTableViewCell

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self){
        leftSpace = 15;
        self.contentView.backgroundColor = [UIColor whiteColor];
        self.topTipLabel = [[CustomeLzhLabel alloc]initWithCustomerParamer:[UIFont getPingFangSCMedium:15] titleColor:[UIColor colorWithHexString:@"#666666"] aligement:0];
        self.topTipLabel.frame = CGRectMake(leftSpace, 10, SCREEN_WIDTH - 30, 15);
        [self.contentView addSubview:self.topTipLabel];
        //
         picContainerView = [SDWeiXinPhotoContainerView new];
        [self.contentView addSubview:picContainerView];
        //
        self.detailContentLabel = [[CustomeLzhLabel alloc]initWithCustomerParamer:[UIFont getPingFangSCMedium:12] titleColor:[UIColor colorWithHexString:@"#666666"] aligement:0];
        self.detailContentLabel.numberOfLines = 0;
        self.detailContentLabel.frame = CGRectMake(self.topTipLabel.left, self.topTipLabel.bottom + 17, SCREEN_WIDTH - 2 * leftSpace, 10);
        [self.contentView addSubview:self.detailContentLabel];
        //
        picContainerView.sd_layout
        .leftEqualToView(self.topTipLabel);
        //
        self.detailContentLabel.sd_layout
        .leftEqualToView(picContainerView)
        .topSpaceToView(picContainerView, 17)
        .rightSpaceToView(self.contentView, leftSpace)
        .autoHeightRatio(0);
        
    }
    return self;
}

- (void)setModel:(CompanyCruitDetailModel *)model
{
    _model = model;
    //
    self.topTipLabel.text = @"环境图";
    picContainerView.picPathStringsArray = model.imageUrlArr;
    self.detailContentLabel.text = [model.detailContentStr copy];
    //
    CGFloat picContainerTopMargin = 0;
    if (model.imageUrlArr.count) {
        picContainerTopMargin = 10;
        picContainerView.sd_layout.topSpaceToView(self.topTipLabel, picContainerTopMargin);
        self.detailContentLabel.sd_layout
        .topSpaceToView(picContainerView, 17);
    
    }else{
        self.detailContentLabel.sd_layout
       .topSpaceToView(self.topTipLabel, 17);
    }
    
    [self setupAutoHeightWithBottomView:self.detailContentLabel bottomMargin:15];
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
