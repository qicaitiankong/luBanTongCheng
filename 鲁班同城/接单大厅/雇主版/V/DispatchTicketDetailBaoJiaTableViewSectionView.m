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
        self.displayLabel = [[CustomeLzhLabel alloc]initWithCustomerParamer:[UIFont getPingFangSCMedium:16] titleColor:[UIColor colorWithHexString:@"#333333"] aligement:0];
        
        self.displayLabel.frame = CGRectMake(20, 0, frame.size.width, frame.size.height) ;
        [self addSubview:self.displayLabel];
    }
    return self;
}

@end
