//
//  OrderTakingQuotePriceDetailTelephoneView.m
//  鲁班同城
//
//  Created by apple on 2018/7/16.
//  Copyright © 2018 Mac. All rights reserved.
//

#import "OrderTakingQuotePriceDetailTelephoneView.h"
@interface OrderTakingQuotePriceDetailTelephoneView (){
    UIView *bottomLineView;

}
@end

@implementation OrderTakingQuotePriceDetailTelephoneView
CGFloat leftLabelWidth;
CGFloat leftLabelHeight;
CGFloat rightLabelWidth;
CGFloat rightLabelHeight;

- (instancetype)initWithFrame:(CGRect)frame isNeedRightButt:(BOOL)need
{
    self = [super initWithFrame:frame];
    if (self) {
        self.backgroundColor = [UIColor whiteColor];
        leftLabelHeight = frame.size.height;
        //
        leftLabelWidth = [LzhReturnLabelHeight getLabelWidth:@"字字字" font:[UIFont getPingFangSCMedium:13]  targetHeight:leftLabelHeight];
        self.ownLeftLabel = [[CustomeLzhLabel alloc]initWithCustomerParamer:[UIFont getPingFangSCMedium:13] titleColor:[UIColor colorWithHexString:@"#333333"] aligement:0];
        self.ownLeftLabel.frame = CGRectMake(15, 0, leftLabelWidth, frame.size.height);
        self.ownLeftLabel.center = CGPointMake(self.ownLeftLabel.centerX, frame.size.height / 2);
        [self addSubview:self.ownLeftLabel];
        //
        self.telephoneButt = [UIButton buttonWithType:UIButtonTypeCustom];
        self.telephoneButt.backgroundColor = [UIColor whiteColor];
        self.telephoneButt.frame = CGRectMake(frame.size.width - 20 - 78, 0, 78, 20);
        self.telephoneButt.center = CGPointMake(self.telephoneButt.centerX, frame.size.height / 2);
        [self.telephoneButt addTarget:self action:@selector(clickTelephoneHandler) forControlEvents:UIControlEventTouchUpInside];
        [self addSubview:self.telephoneButt];
        //
        self.ownRightLabel = [[CustomeLzhLabel alloc]initWithCustomerParamer:[UIFont getPingFangSCMedium:13] titleColor:[UIColor colorWithHexString:@"#333333"] aligement:0];
        self.ownRightLabel.frame = CGRectMake(self.ownLeftLabel.right + 5, 0, self.telephoneButt.left - self.ownLeftLabel.right - 5 - 10, frame.size.height);
        rightLabelWidth = self.ownRightLabel.width;
        rightLabelHeight = self.ownRightLabel.height;
        self.ownRightLabel.backgroundColor = [UIColor whiteColor];
        self.ownRightLabel.center = CGPointMake(self.ownRightLabel.centerX, frame.size.height / 2);
        self.ownRightLabel.numberOfLines = 0;
        [self addSubview:self.ownRightLabel];
        //
        if (need == NO){
            self.telephoneButt.hidden = YES;
            self.ownRightLabel.frame = CGRectMake(self.ownLeftLabel.right + 5, 0, frame.size.width - self.ownLeftLabel.right - 5 - 10, frame.size.height);
             self.ownRightLabel.center = CGPointMake(self.ownRightLabel.centerX, frame.size.height / 2);
            rightLabelWidth = self.ownRightLabel.width;
            rightLabelHeight = self.ownRightLabel.height;
        }
        //
         bottomLineView = [[UIView alloc]initWithFrame:CGRectMake(0, frame.size.height - 1, frame.size.width, 1)];
        bottomLineView.backgroundColor = [UIColor colorWithHexString:@"#DADADA"];
        [self addSubview:bottomLineView];
    }
    return self;
}


- (void)adjustOwnDisplay:(NSString*)text{
    if(text.length){
        NSLog(@"重新调整约束");
        CGFloat textHeight = [LzhReturnLabelHeight getLabelHeight:text font:self.ownRightLabel.font width:self.ownRightLabel.width];
        
        self.ownRightLabel.frame = CGRectMake(self.ownRightLabel.x, 10, self.ownRightLabel.width, textHeight);
        self.ownLeftLabel.center = CGPointMake(self.ownLeftLabel.centerX, self.ownRightLabel.centerY);
        [self setFrame:CGRectMake(0, 0, self.width, self.ownRightLabel.bottom + 10)];
        
        bottomLineView.frame =  CGRectMake(0, self.height - 1, self.width, 1);
    }
}


- (void)clickTelephoneHandler{
    if (self.clickTelephoneBlock){
        self.clickTelephoneBlock();
    }
}


@end
