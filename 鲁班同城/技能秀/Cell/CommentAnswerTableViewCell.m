//
//  CommentAnswerTableViewCell.m
//  鲁班同城
//
//  Created by apple on 2018/8/23.
//  Copyright © 2018年 Mac. All rights reserved.
//

#import "CommentAnswerTableViewCell.h"

@interface CommentAnswerTableViewCell (){
    CGFloat praiseButtWidth;
    CGFloat praiseNumLabelWidth;
}
@end



@implementation CommentAnswerTableViewCell

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
}

-(instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self){
        WS(weakSelf);
        self.contentView.backgroundColor = [UIColor whiteColor];
        praiseButtWidth = 25;
        praiseNumLabelWidth = [LzhReturnLabelHeight getLabelWidth:@"12345" font:[UIFont getPingFangSCMedium:11] targetHeight:20];
        //
        self.userImageView = [UIImageView new];
        self.userImageView.backgroundColor = IMAGEVIEW_DEFAULT_COLOR;
        self.userImageView.layer.cornerRadius = 20;
        self.userImageView.clipsToBounds = YES;
        //
        self.nameLabel = [[CustomeLzhLabel alloc]initWithCustomerParamer:[UIFont getPingFangSCMedium:14] titleColor:[UIColor colorWithHexString:@"#333333"] aligement:0];
        
        self.praiseButt = [[CustomerImageButt alloc]initWithFrame:CGRectMake(0, 0, praiseButtWidth,praiseButtWidth)];
        [self.praiseButt.imageView setImage:[UIImage imageNamed:@"clickGood"]];
        self.praiseButt.imageView.frame = CGRectMake(0, 0, 16, 16);
        self.praiseButt.imageView.center = CGPointMake(self.praiseButt.width / 2,self.praiseButt.height / 2);
        self.praiseButt.clickButtBlock = ^{
            if (weakSelf.clickGoodBlock){
                weakSelf.clickGoodBlock(weakSelf.indexPath);
            }
        };
        //
        self.praiseLabel = [[CustomeLzhLabel alloc]initWithCustomerParamer:[UIFont getPingFangSCMedium:11] titleColor:[UIColor colorWithHexString:@"#333333"] aligement:0];
        
        self.commentContentLabel = [[CustomeLzhLabel alloc]initWithCustomerParamer:[UIFont getPingFangSCMedium:12] titleColor:[UIColor colorWithHexString:@"#333333"] aligement:0];
        self.commentContentLabel.numberOfLines = 0;
        //
        self.timeLabel = [[CustomeLzhLabel alloc]initWithCustomerParamer:[UIFont getPingFangSCMedium:11] titleColor:[UIColor colorWithHexString:@"#333333"] aligement:0];
        //
         self.leftpraisedLabel = [[CustomeLzhLabel alloc]initWithCustomerParamer:[UIFont getPingFangSCMedium:11] titleColor:[UIColor colorWithHexString:@"#333333"] aligement:0];
        //
        self.concernButt = [[CustomeLabelButt alloc]initWithFrame:CGRectMake(0, 0, 60, 30)];
        self.concernButt.displayLabel.textAlignment = NSTextAlignmentCenter;
        self.concernButt.displayLabel.font = [UIFont getPingFangSCMedium:15];
        self.concernButt.displayLabel.textColor = [UIColor colorWithHexString:@"#F45151"];
        self.concernButt.displayLabel.text = @"关注";
        self.concernButt.clickButtBlock = ^{
            if (weakSelf.clickAddConcernBlock){
                weakSelf.clickAddConcernBlock();
            }
        };
        NSArray *viewArr = @[self.userImageView,self.concernButt,self.nameLabel,self.commentContentLabel,self.timeLabel,self.praiseLabel,self.praiseButt,self.leftpraisedLabel];
        [self.contentView sd_addSubviews:viewArr];
        //
        [self addOwnConstraints];
    }
    return self;
}


- (void)addOwnConstraints{
    self.userImageView.sd_layout
    .leftSpaceToView(self.contentView, 15)
    .widthIs(40)
    .topSpaceToView(self.contentView, 20)
    .heightIs(40);
    
    self.concernButt.sd_layout
    .rightSpaceToView(self.contentView, 10)
    .widthIs(60)
    .centerYEqualToView(self.userImageView)
    .heightIs(30);
    
    self.nameLabel.sd_layout
    .leftSpaceToView(self.userImageView, 15)
    .rightSpaceToView(self.concernButt, 20)
    .heightRatioToView(self.userImageView, 0.8)
    .centerYEqualToView(self.userImageView);
    
    self.commentContentLabel.sd_layout
    .leftEqualToView(self.nameLabel)
    .topSpaceToView(self.nameLabel, 15)
    .rightSpaceToView(self.contentView, 10)
    .autoHeightRatio(0);
    
    self.timeLabel.sd_layout
    .leftEqualToView(self.commentContentLabel)
    .widthIs(90)
    .topSpaceToView(self.commentContentLabel, 15)
    .heightIs(15);
    
    self.praiseLabel.sd_layout
    .leftSpaceToView(self.contentView, SCREEN_WIDTH - 10 - praiseNumLabelWidth)
    .widthIs(praiseNumLabelWidth)
    .heightIs(20)
    .topSpaceToView(self.timeLabel, 15);
    //
    self.praiseButt.sd_layout
    .rightSpaceToView(self.praiseLabel, 10)
    .widthIs(praiseButtWidth)
    .heightIs(praiseButtWidth)
    .centerYEqualToView(self.praiseLabel);
    
    self.leftpraisedLabel.sd_layout
    .rightSpaceToView(self.praiseButt, 10)
    .leftEqualToView(self.timeLabel)
    .heightIs(20)
    .centerYEqualToView(self.praiseLabel);
    
    
}

- (void)setModel:(CommentModel*)model{
    _model = model;
    if (model){
        self.nameLabel.text = model.nameStr;
        if (model.haveConcerned){
            self.concernButt.displayLabel.text = @"已关注";
        }else{
            self.concernButt.displayLabel.text = @"关注";
        }
        self.praiseLabel.text = [model.praiseStr copy];
        self.leftpraisedLabel.text = [NSString stringWithFormat:@"%@人赞过",model.praiseStr];
        self.commentContentLabel.text = model.commentContentStr;
        self.timeLabel.text = model.timeStr ;
        self.timeLabel.sd_resetLayout
        .leftEqualToView(self.commentContentLabel)
        .widthIs(90)
        .topSpaceToView(self.commentContentLabel, 15)
        .heightIs(15);
        
        self.praiseLabel.sd_resetLayout
        .leftSpaceToView(self.contentView, SCREEN_WIDTH - 10 - praiseNumLabelWidth)
        .widthIs(praiseNumLabelWidth)
        .heightIs(20)
        .topSpaceToView(self.timeLabel, 15);
        //
        self.praiseButt.sd_resetLayout
        .rightSpaceToView(self.praiseLabel, 10)
        .widthIs(praiseButtWidth)
        .heightIs(praiseButtWidth)
        .centerYEqualToView(self.praiseLabel);
        
        self.leftpraisedLabel.sd_resetLayout
        .rightSpaceToView(self.praiseButt, 10)
        .leftEqualToView(self.timeLabel)
        .heightIs(20)
        .centerYEqualToView(self.praiseLabel);
        
        
        UIView *botView = self.leftpraisedLabel;
        [self setupAutoHeightWithBottomView:botView bottomMargin:15];
    }
}








- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
