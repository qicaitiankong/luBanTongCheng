//
//  MessageFeedBackViewController.m
//  鲁班同城
//
//  Created by apple on 2018/7/13.
//  Copyright © 2018 Mac. All rights reserved.
//

#import "MessageFeedBackViewController.h"
#import "OwnTextView.h"
#import "PersonalInfoAddPhotoFlagView.h"
#import "CustomeStyleCornerButt.h"
#import <AFNetworking.h>

@interface MessageFeedBackViewController (){
    OwnTextView *problemTextView;
    PersonalInfoAddPhotoFlagView *addPictureFlagView;
}

@property (strong,nonatomic)NSString *selectedImageBase64Str;

@end

@implementation MessageFeedBackViewController

-(void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    [NavTools displayNav:self.navigationController];
    [NavTools hiddenTabbar:self.rdv_tabBarController];
}

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor whiteColor];
    [NavTools displayNav:self.navigationController];
    [NavTools hiddenTabbar:self.rdv_tabBarController];
    self.title = @"信息反馈";
    //
    [self addViews];
    //
    WS(weakSelf);
    self.selectedImageBlock = ^(NSString *pictureBase64str, UIImage *selectedPicture) {
        __strong typeof(weakSelf) sslef = weakSelf;
        [sslef -> addPictureFlagView.imageView setImage:selectedPicture];
        weakSelf.selectedImageBase64Str = pictureBase64str ;
    };
}

- (void)feedBackRequest{
    if (problemTextView.writeTextView.text.length == 0){
        [SVProgressHUD showInfoWithStatus:@"请填写反馈信息"];
        return;
    }
    NSData *decodedData = [[NSData alloc] initWithBase64EncodedString:self.selectedImageBase64Str options:0];
    
    
//    [TDHttpTools uploadFile:@{@"userId":[lzhGetAccountInfo getAccount].userID,@"content":problemTextView.writeTextView.text,@"backMsgPic":@""} singleImage:decodedData success:^(id response) {
//        if([response[@"status"] integerValue] == 0){
//            NSLog(@"反馈信息成功");
//        }else{
//            NSLog(@"反馈信息失败");
//        }
//
//    } failure:^(NSError *error) {
//        NSLog(@"反馈信息失败");
//    }];
//
}


- (void)addViews{
    WS(weakSelf);
    UIScrollView *baseScrollView = [[UIScrollView alloc]initWithFrame:CGRectMake(0, 0, self.view.width, CENTER_VIEW_HEIGHT + TAB_BAR_HEIGHT)];
    baseScrollView.contentInsetAdjustmentBehavior = UIScrollViewContentInsetAdjustmentNever;
    baseScrollView.backgroundColor = RGBA(242, 242, 242,1);
    [self.view addSubview:baseScrollView];
    //
    CGFloat leftSpace = 15;
    UIView *topBaseView = [[UIView alloc]initWithFrame:CGRectMake(leftSpace, 15, self.view.width - 2 * leftSpace, 300)];
    topBaseView.layer.cornerRadius = 5;
    topBaseView.backgroundColor = [UIColor whiteColor];
    //
    UILabel *topTipLabel = [[CustomeLzhLabel alloc]initWithCustomerParamer:[UIFont getPingFangSCMedium:15] titleColor:[UIColor colorWithHexString:@"#666666"] aligement:0];
    topTipLabel.frame = CGRectMake(5, 5, topBaseView.width - 10, 15);
    topTipLabel.text = @"问题和意见";
    [topBaseView addSubview:topTipLabel];
    //
    problemTextView = [[OwnTextView alloc]initWithFrame:CGRectMake(topTipLabel.left, topTipLabel.bottom + 10, topTipLabel.width, topBaseView.height - topTipLabel.bottom - 30)];
    problemTextView.backgroundColor = [UIColor whiteColor];
    problemTextView.writeViewPlaceHolderLabel.text = @"请简要描述你的问题和意见";
    [topBaseView addSubview:problemTextView];
    //
    [baseScrollView addSubview:topBaseView];
    //
    UIView *botBaseView = [[UIView alloc]initWithFrame:CGRectMake(leftSpace, topBaseView.bottom + 15, self.view.width - 2 * leftSpace, 150)];
    botBaseView.layer.cornerRadius = 5;
    botBaseView.backgroundColor = [UIColor whiteColor];
    //
    UILabel *botTipLabel = [[CustomeLzhLabel alloc]initWithCustomerParamer:[UIFont getPingFangSCMedium:15] titleColor:[UIColor colorWithHexString:@"#666666"] aligement:0];
    botTipLabel.frame = CGRectMake(5, 5, botBaseView.width - 10, 15);
    botTipLabel.text = @"图片（选填，提供问题截图）";
    [botBaseView addSubview:botTipLabel];
    //
     addPictureFlagView = [[PersonalInfoAddPhotoFlagView alloc]initWithFrame:CGRectMake(botTipLabel.left, botTipLabel.bottom + 10, 100, 100)];
    addPictureFlagView.selectedAddPhotoBlock = ^(UIImageView *imageView) {
        if (imageView.image == nil){
             [weakSelf callActionSheetFunc];
        }
    };
    [botBaseView addSubview:addPictureFlagView];
    //
    [baseScrollView addSubview:botBaseView];
    //
    CustomeStyleCornerButt *nextButt = [[CustomeStyleCornerButt alloc] initWithFrame:CGRectMake(0, botBaseView.bottom + 50, self.view.width - 2 * leftSpace, 45) backColor:[UIColor colorWithHexString:@"#78CAC5"] cornerRadius:4 title:@"提交" titleColor:[UIColor whiteColor] font:[UIFont getPingFangSCMedium:18]];
    nextButt.center = CGPointMake(self.view.width  / 2, nextButt.centerY);
    nextButt.clickButtBlock = ^{
        [weakSelf feedBackRequest];
    };
    [baseScrollView addSubview:nextButt];
    //
    baseScrollView.contentSize = CGSizeMake(baseScrollView.width, nextButt.bottom + 20);
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
