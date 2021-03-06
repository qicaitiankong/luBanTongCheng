//
//  PersonalInfoAddPhotoFlagView.m
//  鲁班同城
//
//  Created by apple on 2018/7/5.
//  Copyright © 2018年 Mac. All rights reserved.
//

#import "PersonalInfoAddPhotoFlagView.h"
@interface PersonalInfoAddPhotoFlagView (){
    UIButton *backButt;
}

@end


@implementation PersonalInfoAddPhotoFlagView
@synthesize addImageView;

- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        self.backgroundColor = [UIColor whiteColor];
        self.layer.borderWidth = 1;
        self.layer.cornerRadius = 4;
        self.layer.borderColor = [UIColor colorWithHexString:@"#C6C6C6"].CGColor;
        
        self.imageView = [[UIImageView alloc] initWithFrame:CGRectMake(0, 0, frame.size.width, frame.size.height)];
        self.imageView.backgroundColor = [UIColor whiteColor];
       
        //
        backButt = [UIButton buttonWithType:UIButtonTypeCustom];
        backButt.frame = CGRectMake(0, 0, frame.size.width, frame.size.height);
        
        [backButt addTarget:self action:@selector(backButtHandler) forControlEvents:UIControlEventTouchUpInside];
        backButt.backgroundColor = [UIColor clearColor];
        
        //
        addImageView = [[UIImageView alloc]initWithFrame:CGRectMake(0, 0, 23, 23)];
        [addImageView setImage:[UIImage imageNamed:@"photoAddFlag"]];
        addImageView.center = CGPointMake(frame.size.width / 2, frame.size.height / 2);
        [self addSubview:self.imageView];
        [self addSubview:addImageView];
        //
        [self addSubview:backButt];
       
    }
    return self;
}

- (void)adjustConstraintsWhenNeed{
    self.imageView.sd_resetLayout
    .leftEqualToView(self)
    .topEqualToView(self)
    .widthIs(self.width)
    .heightEqualToWidth();
    //
    addImageView.sd_resetLayout
    .centerXEqualToView(self)
    .centerYEqualToView(self)
    .widthIs(23)
    .heightIs(23);
    //
    backButt.sd_resetLayout
    .leftEqualToView(self)
    .topEqualToView(self)
    .widthIs(self.width)
    .heightEqualToWidth();
}




- (void)backButtHandler{
    if (self.selectedAddPhotoBlock){
        NSLog(@"点击选择图片");
        self.selectedAddPhotoBlock(self.imageView);
    }
}

@end
