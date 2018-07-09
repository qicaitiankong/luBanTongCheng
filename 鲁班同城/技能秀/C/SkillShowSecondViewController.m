//
//  SkillShowSecondViewController.m
//  鲁班同城
//
//  Created by apple on 2018/7/9.
//  Copyright © 2018年 Mac. All rights reserved.
//

#import "SkillShowSecondViewController.h"
#import "SkillShowCommentToolView.h"
#import "CustomeStyleCornerButt.h"
#import "CompanyRecuritDetailViewController.h"

@interface SkillShowSecondViewController (){
    CGFloat bottomCommentHeight;
    SkillShowCommentToolView *bottomCommentView;
    UIImageView *companyLogoImageView;
    UILabel *companyNameLabel;
    
}

@property (strong,nonatomic) CustomerImageButt *backImageButt;

@end

@implementation SkillShowSecondViewController



- (void)viewDidLoad {
    [super viewDidLoad];
    //
    [self initOwnObjects];
    [self addViews];
}

- (void)initOwnObjects{
    bottomCommentHeight = SCREEN_HEIGHT * 0.078;
}

- (void)sayMore{
    NSLog(@"说点什么");
}

- (void)shareMore{
    NSLog(@"转发");
}

- (void)findButtClick{
    NSLog(@"点击查看");
    CompanyRecuritDetailViewController *companyDetailVC = [[CompanyRecuritDetailViewController alloc]init];
    [self.navigationController pushViewController:companyDetailVC animated:YES];
}

- (void)addViews{
    WS(weakSelf);
    
    self.backImageButt = [[CustomerImageButt alloc]initWithFrame:CGRectMake(0, 0, self.view.width, SCREEN_HEIGHT - bottomCommentHeight)];
    self.backImageButt.backgroundColor = [UIColor whiteColor];
    [self.backImageButt.imageView setImage:[UIImage imageNamed:@"test03"]];
    [self.view addSubview:self.backImageButt];
    //
    CustomerImageButt *navReturnButt = [NavTools getOwnNavStyleWhiteReturnButt];
    navReturnButt.clickButtBlock = ^{
        [weakSelf.navigationController popViewControllerAnimated:YES];
    };
    [self.view addSubview:navReturnButt];
    //
    companyLogoImageView = [[UIImageView alloc]initWithFrame:CGRectMake(10, SCREEN_HEIGHT * 0.758, SCREEN_HEIGHT * 0.061, SCREEN_HEIGHT * 0.061)];
    companyLogoImageView.layer.cornerRadius = companyLogoImageView.width / 2;
    companyLogoImageView.backgroundColor = [UIColor grayColor];
    [companyLogoImageView setImage:[UIImage imageNamed:@"test01"]];
    [self.view addSubview:companyLogoImageView];
    //
    companyNameLabel = [[CustomeLzhLabel alloc]initWithCustomerParamer:[UIFont getPingFangSCBold:16] titleColor:[UIColor whiteColor] aligement:0];
    companyNameLabel.frame = CGRectMake(companyLogoImageView.right + 5, 0, self.view.width * 0.373, SCREEN_HEIGHT * 0.023);
    companyNameLabel.center = CGPointMake(companyNameLabel.centerX, companyLogoImageView.centerY);
    [self.view addSubview:companyNameLabel];
    //
    CustomeStyleCornerButt *findButt = [[CustomeStyleCornerButt alloc]initWithFrame:CGRectMake(companyNameLabel.right + 5, 0, 45, 25) backColor:nil cornerRadius:6 title:@"查看" titleColor:[UIColor whiteColor] font:[UIFont getPingFangSCMedium:14]];
    findButt.layer.cornerRadius = 6;
    findButt.layer.borderWidth = 1;
    findButt.layer.borderColor = [UIColor whiteColor].CGColor;
    findButt.center = CGPointMake(findButt.centerX, companyNameLabel.centerY);
    findButt.clickButtBlock = ^{
        [weakSelf findButtClick];
    };
    [self.view addSubview:findButt];
    //
    CGFloat labelHeight = SCREEN_HEIGHT * 0.019;
    CGFloat labelVerticalSpace = SCREEN_HEIGHT * 0.014;
    for (int i = 0; i < 2; i ++){
        UILabel *jobLabel = [[CustomeLzhLabel alloc]initWithCustomerParamer:[UIFont getPingFangSCMedium:14] titleColor:[UIColor whiteColor] aligement:0];
        jobLabel.frame = CGRectMake(companyLogoImageView.left, companyLogoImageView.bottom + labelVerticalSpace + (labelVerticalSpace + labelHeight) * i, self.view.width - 30, labelHeight);
        jobLabel.text = @"招洗碗工/厨师/收银";
        [self.view addSubview:jobLabel];
    }
    //
    bottomCommentView = [[SkillShowCommentToolView alloc]initWithFrame:CGRectMake(0,SCREEN_HEIGHT - bottomCommentHeight , self.view.width, bottomCommentHeight)];
    bottomCommentView.sayMoreButt.clickButtBlock = ^{
        [weakSelf sayMore];
    };
    bottomCommentView.sharButt.clickButtBlock = ^{
        [weakSelf shareMore];
    };
    [self.view addSubview:bottomCommentView];
    //
    companyNameLabel.text = @"青岛青岛青岛公司";
    bottomCommentView.commentView.rightLabel.text = @"123456";
    bottomCommentView.praiseView.rightLabel.text = @"123456";
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
