//
//  DispatchTicketDetailBaoJiaTableViewSectionView.m
//  鲁班同城
//
//  Created by apple on 2018/7/16.
//  Copyright © 2018 Mac. All rights reserved.
//

#import "DispatchTicketDetailBaoJiaTableViewSectionView.h"

@implementation DispatchTicketDetailBaoJiaTableViewSectionView

- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        self.backgroundColor = [UIColor whiteColor];
        //
        UIView *topLine = [[UIView alloc]initWithFrame:CGRectMake(0, 0, frame.size.width, 1)];
        topLine.backgroundColor = [UIColor colorWithHexString:@"#DADADA"];
        [self addSubview:topLine];
        //
        self.displayLabel = [[CustomeLzhLabel alloc]initWithCustomerParamer:[UIFont getPingFangSCMedium:16] titleColor:[UIColor colorWithHexString:@"#333333"] aligement:0];
        
        self.displayLabel.frame = CGRectMake(20, topLine.bottom, frame.size.width, frame.size.height - 1) ;
        [self addSubview:self.displayLabel];
    }
    return self;
}

@end
