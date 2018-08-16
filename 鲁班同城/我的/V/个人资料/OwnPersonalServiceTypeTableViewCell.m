//
//  OwnPersonalServiceTypeTableViewCell.m
//  鲁班同城
//
//  Created by apple on 2018/8/16.
//  Copyright © 2018年 Mac. All rights reserved.
//

#import "OwnPersonalServiceTypeTableViewCell.h"
#import "CustomerLabelView.h"

@interface OwnPersonalServiceTypeTableViewCell (){
    NSMutableArray *itemArr;
    CGFloat viewWidth;
    CGFloat viewHeight;
    CGFloat horizontalSpace;
    CGFloat verticalSpace;
    //
    UIView *spaceView;
}
@end

@implementation OwnPersonalServiceTypeTableViewCell


-(instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self){
        self.contentView.backgroundColor = [UIColor whiteColor];
        
        itemArr = [[NSMutableArray alloc]init];
         viewWidth = SCREEN_WIDTH * 0.293;
         viewHeight = SCREEN_HEIGHT * 0.044;
         horizontalSpace = (SCREEN_WIDTH - 3 *viewWidth) / 4;
         verticalSpace = 10;
        //
        spaceView = [[UIView alloc]initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, 25)];
        spaceView.backgroundColor = IMAGEVIEW_DEFAULT_COLOR;
        [self.contentView addSubview:spaceView];
        //
        self.topDisplayLabel = [[CustomeLzhLabel alloc]initWithCustomerParamer:[UIFont getPingFangSCBold:16] titleColor:[UIColor colorWithHexString:@"#333333"] aligement:0];
        self.topDisplayLabel.frame = CGRectMake(15, spaceView.bottom, SCREEN_WIDTH - 30, 50);
        [self.contentView addSubview:self.topDisplayLabel];
        //
        spaceView.sd_layout
        .leftEqualToView(self.contentView)
        .rightEqualToView(self.contentView)
        .topEqualToView(self.contentView)
        .heightIs(25);
        //
        self.topDisplayLabel.sd_layout
        .leftSpaceToView(self.contentView, 15)
        .rightSpaceToView(self.contentView, 15)
        .topSpaceToView(spaceView, 0)
        .heightIs(50);
        //
        for (int k = 0; k < 3; k ++){
            CustomerLabelView *itemView = [[CustomerLabelView alloc]init];
            [self.contentView addSubview:itemView];
            [itemArr addObject:itemView];
        }
    }
    return self;
}


- (void)setModel:(OwnPersonalInfoModel*)model{
    _model = model;
    NSArray *infoArr = nil;
    if (_path.row == 0){
        infoArr = model.targetTechSeviceArr;
    }else{
        infoArr = model.targetJobArr;
    }
    NSInteger itemCount = itemArr.count;
    //
    if (infoArr.count > itemCount){//需要增加创建
        for (int k = 0; k < infoArr.count - itemCount; k ++){
            CustomerLabelView *itemView = [[CustomerLabelView alloc]init];
            [self.contentView addSubview:itemView];
            [itemArr addObject:itemView];
        }
    }
    //先全部隐藏
    for (CustomerLabelView *itemView in itemArr){
        itemView.hidden = YES;
    }
    UIView *botView = self.topDisplayLabel;
    //再显示需要的
    NSLog(@"infoArr.count=%ld,itemArr.count=%ld",infoArr.count,itemArr.count);
    for (int k = 0; k < infoArr.count; k ++){
        CustomerLabelView *itemView = itemArr[k];
        itemView.hidden = NO;
        verticalSpace =  75 + 15 + (k / 3) * 15 + viewHeight * (k / 3);
        
        itemView.sd_resetLayout
        .leftSpaceToView(self.contentView, horizontalSpace * (k % 3 + 1) + viewWidth * (k % 3))
        .topSpaceToView(self.contentView, verticalSpace)
        .widthIs(viewWidth)
        .heightIs(viewHeight);
        
        [itemView giveTitles:infoArr[k]];
        botView = itemView;
    }
    
    [self setupAutoHeightWithBottomView:botView bottomMargin:15];
}



- (void)awakeFromNib {
    [super awakeFromNib];
    
}


- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
