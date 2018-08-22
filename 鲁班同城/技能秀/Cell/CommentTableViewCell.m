//
//  CommentTableViewCell.m
//  鲁班同城
//
//  Created by apple on 2018/8/22.
//  Copyright © 2018年 Mac. All rights reserved.
//

#import "CommentTableViewCell.h"

@interface CommentTableViewCell (){
    CGFloat praiseButtWidth;
}
@end


@implementation CommentTableViewCell

-(instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self){
        self.contentView.backgroundColor = [UIColor whiteColor];
        praiseButtWidth = 16;
        //
        self.userImageView = [UIImageView new];
        self.userImageView.backgroundColor = IMAGEVIEW_DEFAULT_COLOR;
        self.userImageView.layer.cornerRadius = 20;
        self.userImageView.clipsToBounds = YES;
        //
        self.nameLabel = [[CustomeLzhLabel alloc]initWithCustomerParamer:[UIFont getPingFangSCMedium:14] titleColor:[UIColor colorWithHexString:@"#333333"] aligement:0];
        
        self.praiseButt = [[CustomerImageButt alloc]initWithFrame:CGRectMake(0, 0, praiseButtWidth,praiseButtWidth)];
        [self.praiseButt.imageView setImage:[UIImage imageNamed:@"clickPraise"]];
        
        self.praiseLabel = [[CustomeLzhLabel alloc]initWithCustomerParamer:[UIFont getPingFangSCMedium:14] titleColor:[UIColor colorWithHexString:@"#333333"] aligement:0];
        
         self.commentContentLabel = [[CustomeLzhLabel alloc]initWithCustomerParamer:[UIFont getPingFangSCMedium:16] titleColor:[UIColor colorWithHexString:@"#333333"] aligement:0];
        self.commentContentLabel.numberOfLines = 0;
        //
        self.timeLabel = [[CustomeLzhLabel alloc]initWithCustomerParamer:[UIFont getPingFangSCMedium:13] titleColor:[UIColor colorWithHexString:@"#333333"] aligement:0];
        //
        self.answerButtView = [[CustomeStyleCornerButt alloc]initWithFrame:CGRectMake(0, 0, 60, 30) backColor:[UIColor whiteColor] cornerRadius:5 title:@"0回复" titleColor:[UIColor colorWithHexString:@"#333333"] font:[UIFont getPingFangSCMedium:13]];
        self.answerButtView.layer.borderWidth = 1;
        self.answerButtView.layer.borderColor = [UIColor colorWithHexString:@"#E3E3E3"].CGColor;
        
        NSArray *viewArr = @[self.userImageView,self.praiseLabel,self.praiseButt,self.nameLabel,self.commentContentLabel,self.timeLabel,self.answerButtView];
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
    
    self.praiseLabel.sd_layout
    .leftSpaceToView(self.contentView, SCREEN_WIDTH - 50)
    .widthIs(40)
    .heightRatioToView(self.userImageView, 0.8)
    .centerYEqualToView(self.userImageView);
    //
    self.praiseButt.sd_layout
    .rightSpaceToView(self.praiseLabel, 10)
    .widthIs(praiseButtWidth)
    .heightIs(praiseButtWidth)
    .centerYEqualToView(self.userImageView);
    
    self.nameLabel.sd_layout
    .leftSpaceToView(self.userImageView, 15)
    .rightSpaceToView(self.praiseButt, 20)
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
    
    self.answerButtView.sd_layout
    .leftSpaceToView(self.timeLabel, 15)
    .widthIs(60)
    .heightIs(30)
    .centerYEqualToView(self.timeLabel);
    
    
}






- (void)setModel:(CommentModel*)model{
    _model = model;
    if (model){
        self.nameLabel.text = [model.nameStr copy];
        self.praiseLabel.text = [model.praiseStr copy];
        self.commentContentLabel.text = [model.commentContentStr copy];
        self.timeLabel.text = [model.timeStr copy];
        [self.answerButtView.loginButt setTitle:[model.answerNumStr copy] forState:UIControlStateNormal];
        
        self.timeLabel.sd_resetLayout
        .leftEqualToView(self.commentContentLabel)
        .widthIs(90)
        .topSpaceToView(self.commentContentLabel, 15)
        .heightIs(15);
        
        self.answerButtView.sd_resetLayout
        .leftSpaceToView(self.timeLabel, 15)
        .widthIs(60)
        .heightIs(30)
        .centerYEqualToView(self.timeLabel);
        
        
        UIView *botView = self.answerButtView;
        [self setupAutoHeightWithBottomView:botView bottomMargin:15];
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
