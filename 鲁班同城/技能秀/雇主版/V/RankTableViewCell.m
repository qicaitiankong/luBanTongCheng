//
//  RankTableViewCell.m
//  鲁班同城
//
//  Created by apple on 2018/7/17.
//  Copyright © 2018 Mac. All rights reserved.
//

#import "RankTableViewCell.h"
#import "CustomeStyleCornerButt.h"

@interface RankTableViewCell (){
    CGFloat imageViewWidth;
}
@end

@implementation RankTableViewCell

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self){
        imageViewWidth = SCREEN_HEIGHT * 0.074;
        self.contentView.backgroundColor = [UIColor whiteColor];
        self.rankLabel = [[CustomeLzhLabel alloc]initWithCustomerParamer:[UIFont getPingFangSCMedium:16] titleColor:[UIColor colorWithHexString:@"#666666"] aligement:0];
        //
        self.userImageView = [[UIImageView alloc]init];
        self.userImageView.backgroundColor = IMAGEVIEW_DEFAULT_COLOR;
        self.userImageView.layer.cornerRadius = imageViewWidth / 2;
        //
        self.nickLabel = [[CustomeLzhLabel alloc]initWithCustomerParamer:[UIFont getPingFangSCMedium:13] titleColor:[UIColor colorWithHexString:@"#666666"] aligement:0];
        //
         self.jobLabel= [[CustomeLzhLabel alloc]initWithCustomerParamer:[UIFont getPingFangSCMedium:13] titleColor:[UIColor colorWithHexString:@"#333333"] aligement:0];
        //
        UIColor *buttBackCol = SPECIAL_BLUE_COLOR;
        self.ownRightButt = [[CustomeStyleCornerButt alloc]initWithFrame:CGRectMake(0, 0, 68, 26) backColor:buttBackCol cornerRadius:5 title:@"查看" titleColor:[UIColor whiteColor] font:[UIFont getPingFangSCMedium:12]];
        WS(weakSelf);
        self.ownRightButt.clickButtBlock = ^{
            [weakSelf clickRightButt];
        };
        NSArray *viewArr = @[self.userImageView,self.rankLabel,self.ownRightButt,self.nickLabel,self.jobLabel];
        [self.contentView sd_addSubviews:viewArr];
        //
        [self addOwnConstraints];
        //
    }
    return self;
}

- (void)addOwnConstraints{
    
    self.userImageView.sd_layout
    .leftSpaceToView(self.contentView, 65)
    .widthIs(imageViewWidth)
    .heightEqualToWidth()
    .topSpaceToView(self.contentView, 15);
    //
    self.rankLabel.sd_layout
    .leftSpaceToView(self.contentView, 20)
    .centerYEqualToView(self.userImageView)
    .widthIs(50)
    .heightIs(15);
    //
    self.ownRightButt.sd_layout
    .rightSpaceToView(self.contentView, 20)
    .widthIs(68)
    .heightIs(26)
    .centerYEqualToView(self.userImageView);
    
    self.nickLabel.sd_layout
    .leftSpaceToView(self.userImageView, 15)
    .rightSpaceToView(self.ownRightButt, 10)
    .topEqualToView(self.userImageView)
    .heightRatioToView(self.userImageView, 0.5);
    
    self.jobLabel.sd_layout
    .leftSpaceToView(self.userImageView, 15)
    .rightSpaceToView(self.ownRightButt, 10)
    .topSpaceToView(self.nickLabel, 0)
    .heightRatioToView(self.userImageView, 0.5);
    //
}

- (void)setModel:(RankModel*)model{
    _model = model;
    if (model){
        self.rankLabel.text = [model.rankStr copy];
        [self.userImageView setImage:model.userImage];
        self.nickLabel.text = [model.nickName copy];
        self.jobLabel.text = [model.jobStr copy];
        [self setupAutoHeightWithBottomView:self.userImageView bottomMargin:15];
    }
}

- (void)clickRightButt{
    if (self.clickRightButtBlock){
        self.clickRightButtBlock(self.indexPath);
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
