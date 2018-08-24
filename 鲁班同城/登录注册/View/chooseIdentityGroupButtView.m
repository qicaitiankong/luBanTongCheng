//
//  chooseIdentityGroupButtView.m
//  鲁班同城
//
//  Created by apple on 2018/8/17.
//  Copyright © 2018年 Mac. All rights reserved.
//

#import "chooseIdentityGroupButtView.h"

@implementation chooseIdentityGroupButtView

- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        self.capsualButtView = [[chooseIdentityButtView alloc]initWithFrame:CGRectMake(0, 0, frame.size.width, (frame.size.height - 25) / 2) title:@"我是零工"];
        WS(weakSelf);
        self.capsualButtView.clickButtBlock = ^{
            [weakSelf clickCapsualButt];
        };
        
        [self addSubview:self.capsualButtView];
        //
        self.employmentButtView = [[chooseIdentityButtView alloc]initWithFrame:CGRectMake(0, self.capsualButtView.bottom + 23, frame.size.width, (frame.size.height - 25) / 2) title:@"我是雇主"];
        [self.employmentButtView setSelectedState];
        self.employmentButtView.clickButtBlock = ^{
            [weakSelf clickEmplymentButt];
        };
        
        [self addSubview:self.employmentButtView];
    }
    return self;
}

- (void)clickCapsualButt{
    [self.capsualButtView setSelectedState];
    [self.employmentButtView setNormalState];
    self.selectedUserType = 1;
}

- (void)clickEmplymentButt{
    [self.capsualButtView setNormalState];
    [self.employmentButtView setSelectedState];
    self.selectedUserType = 0;

}




@end
