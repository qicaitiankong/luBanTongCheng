//
//  LaunchPiesTicketInputNameView.m
//  鲁班同城
//
//  Created by apple on 2018/7/18.
//  Copyright © 2018 Mac. All rights reserved.
//

#import "LaunchPiesTicketInputNameView.h"

@interface LaunchPiesTicketInputNameView (){
    
    BOOL needRightMapButt;
}


@end

@implementation LaunchPiesTicketInputNameView
@synthesize bottomLineView;
@synthesize mapChooseButtView;

- (instancetype)initWithFrame:(CGRect)frame needRightMapButt:(BOOL)needMapButt
{
    self = [super initWithFrame:frame];
    if (self) {
        needRightMapButt = needMapButt;
        self.backgroundColor = [UIColor whiteColor];
        
        self.leftImageView = [[UIImageView alloc] init];
        self.leftImageView.backgroundColor = [UIColor whiteColor];
        [self addSubview:self.leftImageView];
        
        self.nameLabel = [[CustomeLzhLabel alloc]initWithCustomerParamer:[UIFont getPingFangSCMedium:14] titleColor:[UIColor colorWithHexString:@"#666666"] aligement:0];
        [self addSubview:self.nameLabel];
        
       
        //
        if (needMapButt){
            mapChooseButtView = [[CustomerImageButt alloc]initWithFrame:CGRectMake(frame.size.width - 15 - 90, 0, 90, 25)];
            mapChooseButtView.center = CGPointMake(mapChooseButtView.centerX, frame.size.height / 2);
            [mapChooseButtView.imageView setImage:[UIImage imageNamed:@"mapChoose"]];
            [self addSubview:mapChooseButtView];
            mapChooseButtView.hidden = NO;
            //
            self.rightTextView = [[OwnTextView alloc] initWithFrame:CGRectMake(0, 0,frame.size.width - 10, frame.size.height)];
            self.rightTextView.writeTextView.backgroundColor = [UIColor whiteColor];
            self.rightTextView.writeTextView.font = [UIFont getPingFangSCMedium:14];
            [self addSubview:self.rightTextView];
        self.rightTextView.writeTextView.backgroundColor = [UIColor whiteColor];
        }else{
            mapChooseButtView.hidden = YES;
            self.rightTextField = [[OwnTextField alloc] initWithFrame:CGRectMake(0, 0, 40, frame.size.height)];
            self.rightTextField.myTextField.backgroundColor = [UIColor whiteColor];
            self.rightTextField.myTextField.font = [UIFont getPingFangSCMedium:14];
            [self addSubview:self.rightTextField];
            self.rightTextField.myTextField.backgroundColor = [UIColor whiteColor];
        }
        //
        bottomLineView = [[UIView alloc] init];
        bottomLineView.backgroundColor = [UIColor colorWithHexString:@"#C6C6C6"];
        [self addSubview:bottomLineView];
        //
    }
    return self;
}

- (void)addOwnConstraints:(UIImage *)iconImage{
    
    CGFloat leftimageWidth = 15;
    
    CGFloat leftImageViewHeight = 15 / (iconImage.size.width / iconImage.size.height);
    
    [self.leftImageView setImage:iconImage];
    self.leftImageView.sd_layout
    .leftSpaceToView(self, 10)
    .widthIs(leftimageWidth)
    .heightIs(leftImageViewHeight)
    .centerYEqualToView(self);
    
    //按照4个字长度
    CGFloat labelWidrh = [LzhReturnLabelHeight getLabelWidth:@"字字字字" font:[UIFont getPingFangSCMedium:14] targetHeight:leftImageViewHeight];
    
    self.nameLabel.sd_layout
    .leftSpaceToView(self.leftImageView, 10)
    .widthIs(labelWidrh)
    .heightIs(leftImageViewHeight)
    .topEqualToView(self.leftImageView);
    
    if(needRightMapButt){
        self.rightTextView.sd_resetLayout
        .leftSpaceToView(self.nameLabel, 10)
        .rightSpaceToView(mapChooseButtView, 10)
        .centerYEqualToView(self)
        .heightRatioToView(self, 0.6);
        [self.rightTextView adjustOwnSubViewFrame];
        //
        bottomLineView.sd_layout
        .leftEqualToView(self.nameLabel)
        .rightSpaceToView(self, 10)
        .bottomSpaceToView(self, 0)
        .heightIs(1);
    }else{
        self.rightTextField.sd_layout
        .leftSpaceToView(self.nameLabel, 10)
        .rightSpaceToView(self, 10)
        .centerYEqualToView(self)
        .heightRatioToView(self, 0.6);

        [self.rightTextField addOwnConstraints];
        bottomLineView.sd_layout
        .leftEqualToView(self.nameLabel)
        .rightSpaceToView(self, 10)
        .bottomSpaceToView(self, 0)
        .heightIs(1);
    }
    
   
    
}
@end
