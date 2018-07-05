//
//  RdvtarbarBigView.m
//  鲁班同城
//
//  Created by apple on 2018/7/5.
//  Copyright © 2018年 Mac. All rights reserved.
//

#import "RdvtarbarBigView.h"

@interface RdvtarbarBigView (){
    
}
@end

@implementation RdvtarbarBigView

- (instancetype)init
{
    self = [super init];
    if (self) {
        self.backgroundColor = [UIColor whiteColor];
        
        self.bigImageView = [[UIImageView alloc]init];
        self.bigImageView.backgroundColor = [UIColor whiteColor];
        self.bigImageView.contentMode = UIViewContentModeScaleAspectFill;
        [self addSubview:self.bigImageView];
        
        //
        self.backButt = [UIButton buttonWithType:UIButtonTypeCustom];
        [self addSubview:self.backButt];
    }
    return self;
}

-(void)layoutSubviews{
    [super layoutSubviews];
    self.bigImageView.frame =CGRectMake(0, 0, self.height , self.height);
   // self.bigImageView.layer.cornerRadius = self.bigImageView.height / 2;
    self.bigImageView.center = CGPointMake(self.width / 2, self.height / 2);
    UIImage *bigImage = [UIImage imageNamed:@"xiangji@3x.png"];
    [self.bigImageView setImage:bigImage];
    //
    [self.backButt setFrame:self.bigImageView.frame];
}



/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

@end
