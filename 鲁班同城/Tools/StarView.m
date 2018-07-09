//
//  StarView.m
//  鲁班同城
//
//  Created by apple on 2018/7/9.
//  Copyright © 2018年 Mac. All rights reserved.
//

#import "StarView.h"
#import <Masonry.h>

@interface StarView (){
    NSMutableArray *starImageArr;
}
@end


@implementation StarView

- (instancetype)initWithFrame:(CGRect)frame
{
    
    self = [super initWithFrame:frame];
    if (self) {
        //默认不支持点击
        self.userInteractionEnabled = NO;
        
        self.backgroundColor = [UIColor whiteColor];
        starImageArr = [NSMutableArray array];
        //
        for(NSInteger i = 0; i < 5; i ++){
            UIImageView *starView = [[UIImageView alloc]init];
            //starView.backgroundColor = [UIColor yellowColor];
            [starView setImage:[UIImage imageNamed:@"myInfoGrayStar"]];
            [self addSubview:starView];
            [starImageArr addObject:starView];
        }
        [self lzhAddConstraints];
    }
    return self;
}

- (void)lzhAddConstraints{
    [starImageArr mas_distributeViewsAlongAxis:MASAxisTypeHorizontal withFixedItemLength:15 leadSpacing:0 tailSpacing:0];
    [starImageArr mas_makeConstraints:^(MASConstraintMaker *make) {
        make.height.mas_equalTo(15);
        make.centerY.mas_equalTo(self);
    }];
    
}
- (void)lzhUpdateConstraints{
    [starImageArr mas_distributeViewsAlongAxis:MASAxisTypeHorizontal withFixedItemLength:15 leadSpacing:0 tailSpacing:0];
    [starImageArr mas_updateConstraints:^(MASConstraintMaker *make) {
        make.height.mas_equalTo(15);
        make.centerY.mas_equalTo(self);
    }];
}

- (void)setYellowStar:(float)count{
    if(count > 5 || count < 0){
        NSLog(@"星星取值不可用");
        return;
    }
    //先让星星处于初始状态
    for(NSInteger i = 0; i < 5; i ++){
        UIImageView *starView = starImageArr[i];
        [starView setImage:[UIImage imageNamed:@"myInfoGrayStar"]];
    }
    
    //starView.backgroundColor = [UIColor yellowColor];
    
    
    if(count == 0){
        for(NSInteger i = 0; i <=  4 ; i ++){
            UIImageView *imageView = starImageArr[i];
            [imageView setImage:[UIImage imageNamed:@"myInfoGrayStar"]];
        }
    }
    if(count == 0.5 || count == 1.5 || count == 2.5 || count == 3.5 || count == 4.5){
        // NSLog(@"星星小数");
        [self addWithHalfStar:count];
    }else {//整数
        // NSLog(@"星星整数");
        for(NSInteger i = 0; i < count; i ++){
            UIImageView *imageView = starImageArr[i];
            
            [imageView setImage:[UIImage imageNamed:@"myInfoStar"]];
        }
    }
}
//处理半星方法
- (void)addWithHalfStar:(NSInteger)count{
    NSInteger i = 0;
//    for(i = 0; i <=  4 ; i ++){
//        UIImageView *imageView = starImageArr[i];
//        [imageView setImage:[UIImage imageNamed:@"hui"]];
//    }
//    NSInteger j = 0;
//    if(count == 0.5){
//        UIImageView *imageView = starImageArr[0];
//        [imageView setImage:[UIImage imageNamed:@"banxing"]];
//    }else{
//        for(j = 0; j <  count - 0.5 ; j ++){
//            UIImageView *imageView = starImageArr[j];
//            [imageView setImage:[UIImage imageNamed:@"xing"]];
//        }
//        UIImageView *imageView = starImageArr[j];
//        [imageView setImage:[UIImage imageNamed:@"banxing"]];
//    }
    
}

-(void)touchesEnded:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event{
    [[NSNotificationCenter defaultCenter] postNotificationName:@"clickStarViewNoti" object:nil];
}


@end
