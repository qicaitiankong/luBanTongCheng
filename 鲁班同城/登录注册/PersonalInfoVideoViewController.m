//
//  PersonalInfoVideoViewController.m
//  鲁班同城
//
//  Created by apple on 2018/7/4.
//  Copyright © 2018年 Mac. All rights reserved.
//

#import "PersonalInfoVideoViewController.h"
#import "PersonalInfoAddPhotoFlagView.h"
#import "CustomeStyleCornerButt.h"
#import "CommitPopView.h"

@interface PersonalInfoVideoViewController (){
    ImageAndLabelView *firstImageAndLabelView;
    ImageAndLabelView *seondImageAndLabelView;
    UILabel *rightTopTipLabel;
    CommitPopView *popView;
    UIButton *popbackButt;
}

@end

@implementation PersonalInfoVideoViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor whiteColor];
    //WS(weakSelf);
    self.leftBarbuttBlock = ^{
    };
    self.rightBarbuttBlock = ^{
    };
    [self addViews];
}

- (void)addViews{
    WS(weakSelf);
    firstImageAndLabelView = [[ImageAndLabelView alloc] initWithFrame:CGRectMake(10, 30, 10, 10) image:[UIImage imageNamed:@"videoFlag"] title:@"技能-视频秀" font:[UIFont getPingFangSCMedium:14] titleColor:[UIColor colorWithHexString:@"#666666"]];
    [self.view addSubview:firstImageAndLabelView];
    //
    rightTopTipLabel = [[CustomeLzhLabel alloc]initWithCustomerParamer:[UIFont getPingFangSCMedium:14] titleColor:[UIColor colorWithRed:153.003/255.0 green:153.003/255.0 blue:153.003/255.0 alpha:1] aligement:2];
    rightTopTipLabel.frame = CGRectMake(5, firstImageAndLabelView.top, self.view.width - 10, firstImageAndLabelView.height);
    rightTopTipLabel.text = @"点击 +上传/拍摄";
    [self.view addSubview:rightTopTipLabel];
    //
    PersonalInfoAddPhotoFlagView *videoFlagView = [[PersonalInfoAddPhotoFlagView alloc]initWithFrame:CGRectMake(firstImageAndLabelView.left + firstImageAndLabelView.rightLabel.left, firstImageAndLabelView.bottom + 15, 130, 90)];
    [self.view addSubview:videoFlagView];
    //
    ImageAndLabelView * photoImageAndLabelView = [[ImageAndLabelView alloc] initWithFrame:CGRectMake(firstImageAndLabelView.left, videoFlagView.bottom + 15, 10, 10) image:[UIImage imageNamed:@"photoFlag"] title:@"技能-图片" font:[UIFont getPingFangSCMedium:14] titleColor:[UIColor colorWithHexString:@"#666666"]];
    [self.view addSubview:photoImageAndLabelView];
    //
    PersonalInfoAddPhotoFlagView *photoFlagView = [[PersonalInfoAddPhotoFlagView alloc]initWithFrame:CGRectMake(photoImageAndLabelView.left + photoImageAndLabelView.rightLabel.left, photoImageAndLabelView.bottom + 15, 130, 90)];
    [self.view addSubview:photoFlagView];
    //
    CGFloat buttWidth = SCREEN_WIDTH * 0.874;
    CGFloat buttHeigt = buttWidth * 0.137;
    CustomeStyleCornerButt *nextButt = [[CustomeStyleCornerButt alloc] initWithFrame:CGRectMake(0, photoFlagView.bottom + SCREEN_HEIGHT * 0.269, buttWidth, buttHeigt) backColor:[UIColor colorWithHexString:@"#78CAC5"] cornerRadius:4 title:@"完成" titleColor:[UIColor whiteColor] font:[UIFont getPingFangSCMedium:18]];
    nextButt.center = CGPointMake(self.view.width  / 2, nextButt.centerY);
    nextButt.clickButtBlock = ^{
        [weakSelf nextHandler];
    };
    [self.view addSubview:nextButt];
}

- (void)nextHandler{
    [self showPopView];
}

//弹窗
- (void)showPopView{
    UIWindow *appWindow = APP_MAIN_WINDOW;
    if (nil == popView){
        popbackButt = [UIButton buttonWithType:UIButtonTypeCustom];
        popbackButt.frame = CGRectMake(0, 0, SCREEN_WIDTH, SCREEN_HEIGHT);
        popbackButt.backgroundColor = [UIColor grayColor];
        popbackButt.alpha = 0.65;
        [popbackButt addTarget:self action:@selector(popBackButtHandler) forControlEvents:UIControlEventTouchUpInside];
        [appWindow addSubview:popbackButt];
        popView = [[CommitPopView alloc]initWithFrame:CGRectMake(0, 0, 194, 223)];
        popView.center = CGPointMake(SCREEN_WIDTH / 2, SCREEN_HEIGHT  / 2);
        [appWindow addSubview:popView];
        WS(weakSelf);
        popView.sureBlock = ^{
            __strong typeof(weakSelf)sself = weakSelf;
            [sself -> popbackButt setHidden:YES];
            [sself -> popView setHidden:YES];

        };
    }else{
        [popbackButt setHidden:NO];
        [popView setHidden:NO];
    }
}

- (void)popBackButtHandler{
    [popbackButt setHidden:YES];
    [popView setHidden:YES];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
