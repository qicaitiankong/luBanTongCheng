//
//  DispatchOrderDetailCellSureServiceCompleteGroupView.m
//  鲁班同城
//
//  Created by apple on 2018/7/17.
//  Copyright © 2018 Mac. All rights reserved.
//

#import "DispatchOrderDetailCellSureServiceCompleteGroupView.h"
#import <Masonry.h>

@interface DispatchOrderDetailCellSureServiceCompleteGroupView (){
    CGFloat imageViewWidth;
    CGFloat leftSpace;
}
@end

@implementation DispatchOrderDetailCellSureServiceCompleteGroupView


- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        self.backgroundColor = [UIColor colorWithHexString:@"#78CAC5"];
        //
        imageViewWidth = SCREEN_WIDTH * 0.106;
        //SCREEN_WIDTH * 0.106 + 8
        self.userImageView = [[UIImageView alloc]init];
        self.userImageView.backgroundColor = IMAGEVIEW_DEFAULT_COLOR;
        self.userImageView.layer.cornerRadius = imageViewWidth / 2;
        self.userImageView.clipsToBounds = YES;
        self.userImageView.frame = CGRectMake(8, 8, imageViewWidth, imageViewWidth);
        [self addSubview:self.userImageView];
        //
        self.nickNameLabel = [[CustomeLzhLabel alloc]initWithCustomerParamer:[UIFont getPingFangSCMedium:13] titleColor:[UIColor whiteColor] aligement:0];
        CGFloat predicateLabelWidth = [LzhReturnLabelHeight getLabelWidth:@"字字字字字字" font:[UIFont getPingFangSCMedium:13] targetHeight:self.userImageView.height / 2];
        self.nickNameLabel.frame = CGRectMake(self.userImageView.right + 15, self.userImageView.top, predicateLabelWidth, self.userImageView.height / 2);
        [self addSubview:self.nickNameLabel];
        //
        self.xinxinView = [[StarView alloc]initWithFrameCustomeStyle:CGRectMake(self.nickNameLabel.left, self.nickNameLabel.bottom, SCREEN_WIDTH * 0.213, imageViewWidth / 2) starWidth:12];
        self.xinxinView.backgroundColor = [UIColor colorWithHexString:@"#78CAC5"];
        [self addSubview:self.xinxinView];
        //
        CGFloat sureButtWidth = frame.size.width * 0.294;
        self.sureServiceButt = [[CustomeStyleCornerButt alloc]initWithFrame:CGRectMake(frame.size.width - 8 - sureButtWidth, 0, sureButtWidth, self.userImageView.height * 0.9) backColor:[UIColor whiteColor] cornerRadius:5 title:@"确认服务完成" titleColor:[UIColor colorWithHexString:@"#666666"] font:[UIFont getPingFangSCMedium:13]];
        self.sureServiceButt.center = CGPointMake(self.sureServiceButt.centerX, self.userImageView.centerY);
        [self addSubview:self.sureServiceButt];
        //10 + 15 = 25
        self.messageTipLabel = [[CustomeLzhLabel alloc]initWithCustomerParamer:[UIFont getPingFangSCMedium:13] titleColor:[UIColor whiteColor] aligement:0];
        self.messageTipLabel.frame = CGRectMake(self.xinxinView.left, self.userImageView.bottom + 10, frame.size.width - self.nickNameLabel.left - 8, 15);
        [self addSubview:self.messageTipLabel];
        //30 + 20 = 35
        CGFloat buttHeight = 30;
        CGFloat buttWidth = 80;
        NSArray *imageStrArr = @[@"send_message",@"mobile",@"smallCancel"];
        NSArray *titleArr = @[@"发消息",@"一键拨号",@"取消"];
        NSMutableArray *bottomButtArr = [[NSMutableArray alloc]init];
        for (int i = 0; i < 3; i ++){
           ImageAndLabelView *communicateButt = [[ImageAndLabelView alloc]initWithFrameSecondStyle:CGRectMake(0, 0, buttWidth, buttHeight) image:[UIImage imageNamed:imageStrArr[i]] title:titleArr[i] font:[UIFont getPingFangSCMedium:13]  titleColor:[UIColor whiteColor] imageSize:CGSizeMake(14, 13)];
            communicateButt.backgroundColor = [UIColor colorWithHexString:@"#78CAC5"];
            communicateButt.leftImageView.backgroundColor = communicateButt.backgroundColor;
            communicateButt.rightLabel.backgroundColor = communicateButt.backgroundColor;
            [self addSubview:communicateButt];
            [bottomButtArr addObject:communicateButt];
            switch (i) {
                case 0:
                    self.messageButtView = communicateButt;
                    break;
                case 1:
                    self.mobileButtView = communicateButt;
                    break;
                case 2:
                    self.cancelButtView = communicateButt;
                    break;
                default:
                    break;
            }
        }
        [bottomButtArr mas_distributeViewsAlongAxis:MASAxisTypeHorizontal withFixedItemLength:buttWidth leadSpacing:20 tailSpacing:10];
        CGFloat buttTop = self.messageTipLabel.top + self.messageTipLabel.height + 20;
        [bottomButtArr mas_makeConstraints:^(MASConstraintMaker *make) {
            make.height.mas_equalTo(buttHeight);
            make.top.mas_equalTo(self).offset(buttTop);
        }];
    }
    return self;
}

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

@end
